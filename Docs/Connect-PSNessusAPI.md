---
Module Name: PSNessusAPI
online version:
schema: 2.0.0
---

# Connect-PSNessusAPI

## SYNOPSIS
Connect to Nessus API.

## SYNTAX

### Username and password
```
Connect-PSNessusAPI [-username <String>] [-username <password>] 
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will connect to the Nessus API using username and password.

## EXAMPLES

### EXAMPLE 1
```
Connect-PSNessusAPI -username "admin" -password "password"
```

## PARAMETERS

### -username
Specify the username to connect to the API

```yaml
Type: String
Aliases:

Required: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -password
The password for the user account used to connect to the API

```yaml
Type: String
Aliases:

Required: True
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

This cmdlet returns the access token as a string.

### The returned results from the API call
## NOTES
Version:        0.0.1
Author:         Marcus Tedde
Creation Date:  15/12/2023
Purpose/Change: Initial script development

## RELATED LINKS