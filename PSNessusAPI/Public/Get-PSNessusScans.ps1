function Get-PSNessusScans {
    <#
    .SYNOPSIS
    Retrieves a list of scans from Nessus.
    .DESCRIPTION
    This cmdlet retrieves a list of scans from Nessus. The scans are stored within a hash table called scans. You can also filter the results by folder_id and last_modification_date.
    .PARAMETER FolderId
    The folder_id parameter is used to filter the results by folder. The folder_id is the ID of the folder you want to filter by.    
    .PARAMETER LastModificationDate
    The last_modification_date parameter is used to filter the results by last modification date. The last_modification_date is the date you want to filter by.    
    .OUTPUTS
    The results are stored within a hash tables which are named as follows:
    folders
    scans
    timestamp
    .NOTES

    Version:        0.0.1
    Author:         Marcus Tedde
    Creation Date:  15/12/2023
    Purpose/Change: Initial script development

    .EXAMPLE
    Get-PSNessusScans
    .EXAMPLE
    Get-PSNessusScans -FolderId "1"
    .EXAMPLE
    Get-PSNessusScans -LastModificationDate "2020-01-01"
    .EXAMPLE
    Get-PSNessusScans -FolderId "1" -LastModificationDate "2020-01-01"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$FolderId,
        [Parameter(Mandatory = $false)]
        [string]$LastModificationDate
    )

    $endpoint = "/scans"

    if (($FolderId) -and !($LastModificationDate)) {
        $endpoint = $endpoint + "?folder_id=$FolderId"
    }

    if (($LastModificationDate) -and !($FolderId)) {
        $QueryParameters += @{
            $endpoint = $endpoint + "?last_modification_date=$LastModificationDate"
        }
    }

    if (($FolderId) -and ($LastModificationDate)) {
        $QueryParameters += @{
            $endpoint = $endpoint + "?folder_id=$FolderId&last_modification_date=$LastModificationDate"
        }
    }

    try {
        $response = Invoke-PSNessusAPI -Endpoint $endpoint -Method Get
        return $response  # The property name depends on the API response
    }
    catch {
        Write-Error "Error: $_"
    }
}
