Import-Module simplysql, PSOpenAI
Import-Module $PSScriptRoot\Functions\PSConnectWiseAPI\PSConnectWiseAPI.psm1
Import-Module $PSScriptRoot\Functions\PSMySQL\PSMySQL.psm1
Import-Module $PSScriptRoot\Functions\PSNessusAPI\PSNessusAPI.psm1

# Setting variables
#region variables
$global:OPENAI_API_KEY = '{Azure Open AI Key}'
$Deployment = '{Azure Open AI Deployment Name}'
#endregion variables

# Connect to Patching DB
Connect-PatchingDB -Server '{SQL Server IP Address}' -Database {Database Name} -UserName {Username} -Password '{Password}' -port {port}

# Get the folder id for the company
$FolderIds = (Get-PSNessusFolders).folders | Select-Object -ExpandProperty id
$customObjects = @()
foreach ($FolderID in $FolderIds) {

    # get the scan ids for the folder id
    $ScanIds = (Get-PSNessusScans -FolderId $FolderId).scans | Select-Object name, @{Name = 'scanid'; Expression = { $_.id } }, @{Name = 'last_modification_date'; Expression = { Convert-UnixTimestampToDateTime -UnixTimestamp $_.last_modification_date } } | Where-Object { $_.last_modification_date -gt (Get-Date).AddDays(-7) } 

    foreach ($scanid in $scanids.scanid) {
        $ScanResults = Get-PSNessusScanReport -ScanId $scanid
        $remediations = $scanresults.remediations.remeidations.remediation
        $Vulns = $scanresults.vulnerabilities | Where-Object { $_.score -gt 6.9 }
        foreach ($Vuln in $Vulns) {
            $vulnresults = Get-PSNessusScanVulnerability -ScanId $scanid -VulnerabilityId $vuln.plugin_id
            $CVEDescription = $vulnresults.info.plugindescription.pluginattributes.description
            $CVEScore = $Vuln.score
            $CVEs = ($vulnresults.info.plugindescription.pluginattributes.ref_information.ref | Where-Object {$_.name -eq "cve"}).values.value
            $CVENessusSolution = $vulnresults.info.plugindescription.pluginattributes.solution
            $CVEPublishedDate = $vulnresults.info.plugindescription.pluginattributes.vuln_information.vuln_publication_date
            $CVELastModifiedDate = $vulnresults.info.plugindescription.pluginattributes.plugin_information.plugin_modification_date
            $URLs = $vulnresults.info.plugindescription.pluginattributes.ref_information.ref | Where-Object {$_.name -eq "cve"}
            $ChatGPTResults = Request-AzureChatGPT -Message "Can you provide a technical resolution for the following Nessus Tenable CVSS: $CVEs with the vulnerability description of $CVEDescription and the following proposed solution $CVENessusSolution. Please provide all code if a Powershell script or other scripting language can be used to resolve the issue." -Deployment $Deployment -ApiBase 'https://azureaiservices.openai.azure.com/'
            $CVEAIResolution = $ChatGPTResults.Answer
            foreach ($CVE in $CVEs){

                $FullURL = $URLs.url + $CVE
                    
                $customObject = [PSCustomObject]@{
                    CVE                 = $CVE
                    CVEScore            = $CVEScore
                    CVEDescription      = $CVEDescription
                    CVENessusSolution   = $CVENessusSolution
                    CVEPublishedDate    = $CVEPublishedDate
                    CVELastModifiedDate = $CVELastModifiedDate
                    CVEUrl              = $FullURL
                    CVEAIResolution     = $CVEAIResolution
                }
                # Add the custom object to the array
                $customObjects += $customObject
            }

        }
        
    }
}
#$customObjects | Update-PatchingCVEList
$customObjects | ForEach-Object {
    $_.CVEAIResolution = $_.CVEAIResolution -join "; " # Join array elements with a delimiter
    $_.CVEAIResolution = $_.CVEAIResolution -replace "'", "''" # Escape single quotes
    $_.CVEDescription = $_.CVEDescription -replace "'", "''" # Escape single quotes
    $_.CVENessusSolution = $_.CVENessusSolution -replace "'", "''" # Escape single quotes

    $_.CVEPublishedDate = $_.CVEPublishedDate.ToString("yyyy-MM-dd")
    $_.CVELastModifiedDate = $_.CVELastModifiedDate.ToString("yyyy-MM-dd")

    Update-PatchingCVEList -CVE $_.CVE -CVEScore $_.CVEScore -CVEDescription $_.CVEDescription -CVENessusSolution $_.CVENessusSolution -CVEAIResolution $_.CVEAIResolution -CVEPublishedDate $_.CVEPublishedDate -CVELastModifiedDate $_.CVELastModifiedDate -CVEUrl $_.CVEUrl
}
