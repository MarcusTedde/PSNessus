$Public = @( Get-ChildItem -Recurse -Path "$PSScriptRoot\Public\" -File -Filter *.ps1 )
$Private = @( Get-ChildItem -Recurse -Path "$PSScriptRoot\Private\" -File -Filter *.ps1 )

@($Public + $Private) | ForEach-Object {
    Try {
        If ($_.Length -gt 0) {. $_.FullName}
    } Catch {
        Write-Error -Message "Failed to import function $($_.FullName): $_"
    }
}

#check PS version for this, PS 6 and above use -SkipCertificateCheck for Invoke-RestMethod
if ($PSVersionTable.PSVersion.Major -lt 6)
{
    #Ignore SSL errors
    If ($Null -eq ([System.Management.Automation.PSTypeName]'TrustAllCertsPolicy').Type) {
        Add-Type -Debug:$False @"
            using System.Net;
            using System.Security.Cryptography.X509Certificates;
            public class TrustAllCertsPolicy : ICertificatePolicy {
                public bool CheckValidationResult(
                    ServicePoint srvPoint, X509Certificate certificate,
                    WebRequest request, int certificateProblem) {
                    return true;
                }
            }
"@
    }
    [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
}

Export-ModuleMember -Function $Public.BaseName -Alias *