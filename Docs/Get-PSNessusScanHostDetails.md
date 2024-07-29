---
Module Name: PSNessusAPI
online version:
schema: 2.0.0
---

# Get-PSNessusScanHostDetails

## SYNOPSIS
Produces detailed information on a specific host under a specific scan in Nessus.

## SYNTAX

```
Get-PSNessusScanHostDetails [-ScanId] <String> [-HostID] <String> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet fetches and presents detailed information regarding a specific host's vulnerabilities identified in a specified scan. It organizes the results into a collection of hash tables, specifically named `outputs` and `info`, to facilitate easy access to detailed vulnerability data.

## EXAMPLES

### EXAMPLE 1
```
Get-PSNessusScanHostDetails -ScanId "1" -HostID "1"
```
This example retrieves detailed vulnerability information for a host identified by HostID "1" from the scan with ScanId "1".

## PARAMETERS

### -ScanId
Specifies the ID of the Nessus scan from which to retrieve host details.

```yaml
Type: String
Required: True
Position: Named
Accept pipeline input: False
Accept wildcard characters: False
```

### -HostID
Specifies the ID of the host within the specified scan to retrieve detailed information for.

```yaml
Type: String
Required: True
Position: Named
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

None. You cannot pipe objects to this cmdlet.

## OUTPUTS

### Collection of Hash Tables
This cmdlet returns a collection of hash tables with nested hash tables, providing detailed information on the vulnerabilities of a specific host in a given scan.

## NOTES
- Version: 0.0.1
- Author: Marcus Tedde
- Creation Date: 15/12/2023
- Purpose/Change: Initial script development for producing detailed host vulnerability information from Nessus scans.

## RELATED LINKS
