function Connect-PSNessusAPI {
     <#
    .SYNOPSIS
    Connect to Nessus API.
    .DESCRIPTION
    This cmdlet will connect to the Nessus API using username and password.    
    .OUTPUTS
    This cmdlet will produce an access token which is stored in the $script:Token variable to be used to connect to the various REST API endpoints..
    .NOTES

    Version:        0.0.1
    Author:         Marcus Tedde
    Creation Date:  15/12/2023
    Purpose/Change: Initial script development

    .EXAMPLE
    Connect-PSNessusAPI -username "admin" -password "password"
    
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$username,
        [Parameter(Mandatory = $true)]
        [string]$password
    )

    $body = @{
        "password" = $Password
        "username" = $username
    }

    $endpoint = "/session"

    try {
        $response = Invoke-PSNessusAPI -Endpoint $endpoint -Method Post -QueryParameters $body
        Write-Host "Successfully connected to Nessus API" -ForegroundColor Green
        $script:Token = $response.token
        return $script:Token  # The property name depends on the API response
    }
    catch {
        Write-Error "Error: $_"
    }
}
