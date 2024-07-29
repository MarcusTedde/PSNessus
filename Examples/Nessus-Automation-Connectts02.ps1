param (
    [Parameter(Mandatory = $true)]
    [string]$CompanyName

)

if (-not (Get-Module -Name PSOpenAI -ListAvailable)) {
    try {
        Install-Module -Name PSOpenAI -Scope AllUsers -Force -SkipPublisherCheck
    }
    catch {
        Write-Error "Error: $_"
        exit
    }
}

$modules = @('PSOpenAI', 'PSNessusAPI', 'PSConnectWiseAPI', 'PSMySQL')

# Import the modules PSOpenAI, PSNessusAPI and PSConnectWiseAPI
Import-Module $modules

# if a module did not import then exit the script and display an error message
foreach ($module in $modules) {
    if (-not (Get-Module -Name $module)) {
        Write-Error "Error: $module module not imported"
        exit
    }
}

# Setting variables
#region variables
$global:OPENAI_API_KEY = '{Azure Open AI API Key}'
$Deployment = '{Azure Open AI Deployment Name}'
#endregion variables

# Connect to Patching DB
Connect-PatchingDB -Server '{SQL Server IP Address}' -Database {DatabaseName} -UserName {Username} -Password '{Password}' -port {Port}

# Get the folder id for the company
$FolderId = (Get-PSNessusFolders).folders | Where-Object {$_.name -match $CompanyName} | Select-Object -ExpandProperty id

# get the scan ids for the folder id
$ScanIds = (Get-PSNessusScans -FolderId $FolderId).scans | Select-Object name, @{Name='scanid';Expression={$_.id}}, @{Name='last_modification_date';Expression={Convert-UnixTimestampToDateTime -UnixTimestamp $_.last_modification_date}} | Where-Object {$_.last_modification_date -gt (Get-Date).AddDays(-7)} 

$PluginVulnerabilityDetails = @()
$HostScanDetails = @()
foreach ($scanid in $scanids.scandid) {

    # Get hosts from scan
    $ScanReport = Get-PSNessusScanReport -ScanId $scanid
    $hosts = $ScanReport.hosts
    $ScanName = $ScanReport.info.name

    foreach ($h in $hosts.{host_id}) {
        $hostdetails = Get-PSNessusScanHostDetails -ScanId $scanid -HostId $h
        $hostip = $hostdetails.info.{host-ip}
        $hostos = $hostdetails.info.{operating-system}
        $hostvulnerabilities = $hostdetails.vulnerabilities | where-object{$_.score -gt "6.5"}

        if (!$hostvulnerabilities) {
            Write-Host "No vulnerabilities found on $hostip"
            continue
        }

        foreach ($vuln in $hostvulnerabilities) {
            
            $vulnresults = Get-PSNessusScanVulnerability -ScanId $scanid -VulnerabilityId $vuln.plugin_id
            $CVEDescription = $vulnresults.info.plugindescription.pluginattributes.description
            $CVEScore = $_.score
            $CVE = $vulnresults.info.plugindescription.pluginattributes.cvss_score_source
            $CVENessusSolution = $vulnresults.info.plugindescription.pluginattributes.solution
            $CVEPublishedDate = $vulnresults.info.plugindescription.pluginattributes.vuln_information.vuln_publication_date
            $CVELastModifiedDate = $vulnresults.info.plugindescription.pluginattributes.plugin_information.plugin_modification_date

            $HostScanDetail = [PSCustomObject]@{
                ScanId = $scanid
                ScanName = $scanname
                HostId = $h
                HostIp = $hostip
                HostOs = $hostos
                VulnerabilityPluginId = $vuln.plugin_id
                VulnerabilityPluginName = $vuln.plugin_name
                VulnerabilityCVE = $CVE
                VulnerabilityPluginScore = $vuln.score
            }
            $HostScanDetails += $HostScanDetail

            $TempTableQuery = @"
            CREATE TEMPORARY TABLE CurrentScanResults (
                ScanId INT,
                ScanName VARCHAR(255),
                HostId INT,
                HostIp VARCHAR(15), -- Standard length for IPv4 addresses
                HostOs VARCHAR(255),
                VulnerabilityPluginId INT,
                VulnerabilityPluginName VARCHAR(255),
                VulnerabilityCVE VARCHAR(255),
                VulnerabilityPluginScore FLOAT
            );

            INSERT INTO CurrentScanResults (ScanId, ScanName, HostId, HostIp, HostOs, VulnerabilityPluginId, VulnerabilityPluginName, VulnerabilityCVE, VulnerabilityPluginScore)
            SELECT * FROM (
                SELECT $scanid, '$scanname', $h, '$hostip', '$hostos', $vulnerabilitypluginid, '$vulnerabilitypluginname', '$vulnerabilitycve', $vulnerabilitypluginscore
            ) AS tmp
            WHERE NOT EXISTS (
                SELECT 1 FROM CurrentScanResults
                WHERE ScanId = $scanid AND HostId = $h AND VulnerabilityPluginId = $vulnerabilitypluginid
            );

            DELETE nss
            FROM NessusScanResults nss
            LEFT JOIN CurrentScanResults csr ON nss.ScanId = csr.ScanId 
                                              AND nss.HostId = csr.HostId 
                                              AND nss.VulnerabilityPluginId = csr.VulnerabilityPluginId
            WHERE csr.ScanId IS NULL 
                  AND csr.HostId IS NULL 
                  AND csr.VulnerabilityPluginId IS NULL;

            INSERT INTO NessusScanResults (ScanId, ScanName, HostId, HostIp, HostOs, VulnerabilityPluginId, VulnerabilityPluginName, VulnerabilityCVE, VulnerabilityPluginScore)
            SELECT csr.ScanId, csr.ScanName, csr.HostId, csr.HostIp, csr.HostOs, csr.VulnerabilityPluginId, csr.VulnerabilityPluginName, csr.VulnerabilityCVE, csr.VulnerabilityPluginScore
            FROM CurrentScanResults csr
            LEFT JOIN NessusScanResults nss ON csr.ScanId = nss.ScanId 
                                              AND csr.HostId = nss.HostId 
                                              AND csr.VulnerabilityPluginId = nss.VulnerabilityPluginId
            WHERE nss.ScanId IS NULL 
                  AND nss.HostId IS NULL 
                  AND nss.VulnerabilityPluginId IS NULL;
                  
           
            
"@
    Invoke-SQLQuery -Query $TempTableQuery -ConnectionName 'default'


            if (Get-PatchingCVEs -CVE $CVE) {
                Write-Host "CVE $CVE already exists in the database" -ForegroundColor Yellow
                Write-Host "Skipping CVE $CVE" -ForegroundColor Yellow
            } else {

            $CVEUrl = @()
            foreach ($url in $vulnresults.info.plugindescription.pluginattributes.ref_information.ref) {
                $FullURL = $url.url + $url.values
                $CVEUrl += $FullURL
            }
            $ChatGPTResults = Request-AzureChatGPT -Message "Can you provide a technical resolution for the following Nessus Tenable CVSS: $CVE with the vulnerability description of $CVEDescription and the following proposed solution $CVENessusSolution. Please provide all code if a Powershell script or other scripting language can be used to resolve the issue." -Deployment $Deployment -ApiBase 'https://azureaiservices.openai.azure.com/'
            $CVEAIResolution = $ChatGPTResults.Answer

            $PluginVulnerabilityDetail = [PSCustomObject]@{
                CVE = $CVE
                CVEScore = $CVEScore
                CVEDescription = $CVEDescription
                CVENessusSolution = $CVENessusSolution
                CVEPublishedDate = $CVEPublishedDate
                CVELastModifiedDate = $CVELastModifiedDate
                CVEUrl = $CVEUrl
                CVEAIResolution = $CVEAIResolution
            }

            # Add the custom object to the array
            $PluginVulnerabilityDetails += $PluginVulnerabilityDetail

            }

        }
    }

}
Update-PatchingCVEDB -CVE $PluginVulnerabilityDetails.CVE -CVEScore $PluginVulnerabilityDetails.CVEScore -CVEDescription $PluginVulnerabilityDetails.CVEDescription -CVENessusSolution $PluginVulnerabilityDetails.CVENessusSolution -CVEAIResolution $PluginVulnerabilityDetails.CVEAIResolution -CVEPublishedDate $PluginVulnerabilityDetails.CVEPublishedDate -CVELastModifiedDate $PluginVulnerabilityDetails.CVELastModifiedDate -CVEUrl $PluginVulnerabilityDetails.CVEUrl
