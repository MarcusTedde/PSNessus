---
Module Name: PSNessusAPI
online version:
schema: 2.0.0
---

# Get-PSNessusScans

## SYNOPSIS
Retrieves a list of scans from Nessus.

## SYNTAX

```
Get-PSNessusScans [-FolderId <String>] [-LastModificationDate <String>]
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrieves a list of scans from Nessus. The scans are stored within a hash table called scans. You can also filter the results by folder_id and last_modification_date.

## EXAMPLES

### EXAMPLE 1
```
Get-PSNessusScans
```
### EXAMPLE 2
```
Get-PSNessusScans -FolderId "1"
```
### EXAMPLE 3
```
Get-PSNessusScans -LastModificationDate "2020-01-01"
```
### EXAMPLE 4
```
Get-PSNessusScans -FolderId "1" -LastModificationDate "2020-01-01"
```
## PARAMETERS

### -FolderId
Specify the ID of the folder to view the scans for

```yaml
Type: String
Aliases:

Required: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -LastModificationDate
Specify the last modification date of the scan to view

```yaml
Type: String
Aliases:

Required: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

The results are stored within a hash tables which are named as follows:
    folders
    scans
    timestamp

### The returned results from the API call

## NOTES
Version:        0.0.1
Author:         Marcus Tedde
Creation Date:  15/12/2023
Purpose/Change: Initial script development

## RELATED LINKS