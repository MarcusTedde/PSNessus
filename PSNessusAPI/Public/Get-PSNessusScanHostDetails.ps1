function Get-PSNessusScanHostDetails {
    <#
    .SYNOPSIS
    Produces detailed information on a specific vulnerability under a specific scan.
    .DESCRIPTION
    This cmdlet produces detailed information on a specific vulnerability under a specific scan. The results are stored within a collection of hash tables. The hash tables are named as follows:
    outputs
    info
    .PARAMETER ScanId
    The ID of the scan to show the results of.
    .PARAMETER VulnerabilityId
    The id of the vulnerability to show the results of.
    .OUTPUTS
    A collection of hash tables with nested hash tables. Displays more information on a specific vulnerability.
    .NOTES

    Version:        0.0.1
    Author:         Marcus Tedde
    Creation Date:  15/12/2023
    Purpose/Change: Initial script development

    .EXAMPLE
    Get-PSNessusScanVulnerability -ScanId "1" -VulnerabilityId "1"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ScanId,
        [Parameter(Mandatory = $true)]
        [string]$HostID
    )

    $endpoint = "/scans/$ScanId/hosts/$HostID"
    Write-Debug "Gathering vulnerability information for Host:$HostID using endpoint $endpoint"

    try {
        Write-Debug "Invoking Invoke-PSNessusAPI with endpoint $endpoint"
        $response = Invoke-PSNessusAPI -Endpoint $endpoint -Method Get
        return $response  # The property name depends on the API response
    }
    catch {
        Write-Error "Error: $_"
    }
}