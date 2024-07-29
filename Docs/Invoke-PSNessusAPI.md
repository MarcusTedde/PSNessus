---
Module Name: PSNessusAPI
online version:
schema: 2.0.0
---

# Invoke-PSNessusAPI

## SYNOPSIS
Invokes a RESTful API request to the Nessus server.

## SYNTAX

```
Invoke-PSNessusAPI [-Endpoint] <String> [[-QueryParameters] <Hashtable>] [-Method] <String> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet performs RESTful API requests to the Nessus server, supporting operations such as GET, POST, PUT, and DELETE. It is designed to interact with the Nessus server by specifying the API endpoint, optional query parameters, and the HTTP method. The cmdlet is versatile, allowing for a wide range of actions from session management to fetching or updating data on the Nessus server.

## PARAMETERS

### -Endpoint
Specifies the API endpoint for the Nessus server. The cmdlet ensures that the endpoint starts with a "/", appending one if necessary.

```yaml
Type: String
Required: True
Position: Named
Accept pipeline input: False
Accept wildcard characters: False
```

### -QueryParameters
A hashtable containing any query parameters to be sent with the request. This parameter is optional and allows for additional data to be specified in the API request.

```yaml
Type: Hashtable
Required: False
Position: Named
Accept pipeline input: False
Accept wildcard characters: False
```

### -Method
Specifies the HTTP method to use for the request. Valid options are "Get", "Post", "Put", and "Delete". This parameter is mandatory.

```yaml
Type: String
ValidateSet: "Get", "Post", "Put", "Delete"
Required: True
Position: Named
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

### EXAMPLE 1
```
Invoke-PSNessusAPI -Endpoint "/scans" -Method "Get"
```
This example performs a GET request to the `/scans` endpoint of the Nessus server, retrieving a list of scans.

## INPUTS

None. You cannot pipe objects to this cmdlet.

## OUTPUTS

The output varies based on the endpoint and operation performed. Generally, it returns the response from the Nessus API, which can be data related to the request or the status of the operation.

## NOTES
- Version: 0.0.2
- Author: Marcus Tedde
- Creation Date: 15/12/2023
- Purpose/Change: Initial development of the cmdlet for making RESTful API requests to the Nessus server.

## RELATED LINKS
