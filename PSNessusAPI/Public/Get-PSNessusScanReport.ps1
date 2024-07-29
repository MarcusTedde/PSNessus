function Get-PSNessusScanReport {
    <#
    .SYNOPSIS
    Lists the results of a scan.
    .DESCRIPTION
    This cmdlet lists the results of a scan. The results are stored within a collection of hash tables. The hash tables are named as follows:
    info
    compliance
    filters
    comphosts
    saved_filters
    history
    summary
    notes
    hosts
    remediations
    prioritization
    vulnerabilities
    .PARAMETER ScanId
    The ID of the scan to show the results of
    .PARAMETER ReportType
    The type of report to show. The options are Vulnerabilities and Remediations. This parameter is not used currently.
    .OUTPUTS
    This cmdlet outputs a list of hashtables.
    .NOTES

    Version:        0.0.1
    Author:         Marcus Tedde
    Creation Date:  15/12/2023
    Purpose/Change: Initial script development

    .EXAMPLE
    Get-PSNessusScanReport -ScanId "1"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ScanId,
        [Parameter(Mandatory = $false)]
        [ValidateSet("Vulnerabilities", "Remediations")]
        [string]$ReportType
    )

    $endpoint = "/scans/$ScanId"

    $queryString = "?limit=2500&includeHostDetailsForHostDiscovery=true"

    try {
        $response = Invoke-PSNessusAPI -Endpoint $endpoint -Method Get -QueryString $queryString
        return $response  # The property name depends on the API response
    }
    catch {
        Write-Error "Error: $_"
    }
}