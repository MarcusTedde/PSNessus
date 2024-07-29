---
Module Name: PSNessusAPI
online version:
schema: 2.0.0
---

# Get-PSNessusFolders

## SYNOPSIS
Gets a list of all folders in Nessus.

## SYNTAX

### Username and password
```
Get-PSNessusFolders
```

## DESCRIPTION
This cmdlet will retrieve a list of all folders within Nessus. The folders are where companies are configured and scans are run against.

## EXAMPLES

### EXAMPLE 1
```
Get-PSNessusFolders
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

As this is calling on REST API the results will be in JSON format. The outputs are stored within a hash table called folders.

### The returned results from the API call
## NOTES
Version:        0.0.1
Author:         Marcus Tedde
Creation Date:  15/12/2023
Purpose/Change: Initial script development

## RELATED LINKS