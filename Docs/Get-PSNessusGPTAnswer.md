---
Module Name: PSNessusAPI
online version:
schema: 2.0.0
---

# Get-PSNessusGPTAnswer

## SYNOPSIS
Retrieves suggested technical resolutions for CVEs using Azure's ChatGPT service.

## SYNTAX

```
Get-PSNessusGPTAnswer.ps1 [-Deployment] <String> [-CVE] <String> [<CommonParameters>]
```

## DESCRIPTION
This cmdlet leverages Azure ChatGPT to suggest technical resolutions for Common Vulnerabilities and Exposures (CVEs). By submitting a CVE identifier, the script fetches the CVE description from Tenable's database and queries Azure ChatGPT for a tailored technical resolution, potentially including exact script code with an explanation.

## EXAMPLES

### EXAMPLE 1
```
Get-PSNessusGPTAnswer.ps1 -Deployment "Production" -CVE "CVE-2021-34527"
```
This example fetches the description for CVE-2021-34527 from Tenable's CVE database and requests a technical resolution from Azure ChatGPT, using the "Production" deployment setting.

## PARAMETERS

### -Deployment
Specifies the deployment environment for the Azure ChatGPT request. This is mandatory and must be a valid Azure deployment name.

```yaml
Type: String
Required: True
Position: Named
Accept pipeline input: False
Accept wildcard characters: False
```

### -CVE
Specifies the CVE identifier for which a technical resolution is requested. This is mandatory and must match the format used by Tenable's CVE database.

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

### Azure ChatGPT Response
This cmdlet returns the response from Azure ChatGPT, which includes a suggested technical resolution for the specified CVE.

## NOTES
- Version: 0.0.1
- Author: Marcus Tedde
- Purpose/Change: Initial development of the cmdlet for fetching CVE resolutions using Azure ChatGPT.

## RELATED LINKS
