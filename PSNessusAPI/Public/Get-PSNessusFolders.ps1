function Get-PSNessusFolders {
    <#
    .SYNOPSIS
    Gets a list of all folders in Nessus.
    .DESCRIPTION
    This cmdlet will retrieve a list of all folders within Nessus. The folders are where companies are configured and scans are run against.
    .OUTPUTS
    As this is calling on REST API the results will be in JSON format. The outputs are stored within a hash table called folders.
    .NOTES
    Version:        0.0.1
    Author:         Marcus Tedde
    Creation Date:  15/12/2023
    Purpose/Change: Initial script development

    .EXAMPLE
    Get-PSNessusFolders
    
    #>
    [CmdletBinding()]

    $endpoint = "/folders"

    try {
        $response = Invoke-PSNessusAPI -Endpoint $endpoint -Method Get
        return $response  # The property name depends on the API response
    }
    catch {
        Write-Error "Error: $_"
    }
}