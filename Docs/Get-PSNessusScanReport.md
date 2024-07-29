---
Module Name: PSNessusAPI
online version:
schema: 2.0.0
---

# Get-PSNessusScanReport

## SYNOPSIS
Lists the results of a scan.

## SYNTAX

```
Get-PSNessusScanReport [-ScanId <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
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

## EXAMPLES

### EXAMPLE 1
```
Get-PSNessusScanReport -ScanId "1"
```

## PARAMETERS

### -ScanId
Specify the ID of the scan

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

This cmdlet outputs a list of hashtables.

### The returned results from the API call

## NOTES
Version:        0.0.1
Author:         Marcus Tedde
Creation Date:  15/12/2023
Purpose/Change: Initial script development

## RELATED LINKS