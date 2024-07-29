function Invoke-PSNessusAPI {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Endpoint,
        [Parameter(Mandatory = $false)]
        [hashtable]$QueryParameters,
        [Parameter(Mandatory = $true)]
        [validateset("Get", "Post", "Put", "Delete")]
        [string]$Method
    )

    # Base URL for the Nessus server
    $baseUri = "https://yournessusurl"
    Write-Debug "Base URI is $baseUri"

    # Check if $Endpoint has a / at the start, if it doesn't then add one
    if ($Endpoint -notlike "/*") {
        $Endpoint = "/" + $Endpoint
    }
    Write-Debug "Endpoint is $Endpoint"
    
    try {
        # Make the GET request
        $RESTRequest = @{
            'URI' = ($baseUri + $Endpoint)
            'Method' = $Method
            'ContentType' = 'application/json'
            'Headers' = @{"X-ApiKeys" = "accessKey={YourAccessKey}; secretKey={YourSecretKEy}";
}
        }
        Write-Debug 'Invoking Invoke-RestMethod with the rest request'

        $response = Invoke-RestMethod @RESTRequest

        Write-Debug 'Invoke-RestMethod completed'

        # Output the response
        return $response
    } catch {
        # Handle the error
        Write-Error "An error occurred: $_"
    }
}
