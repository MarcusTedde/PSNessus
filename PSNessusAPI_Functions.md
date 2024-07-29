---
Module Name: PSNessusAPI
Help Version: 0.0.0.1
Locale: en-US
---

# PSNessusAPI Module
## Description
These commands should mirror what is available via the REST API .

## PSNessusAPI Cmdlets
### [Connect-PSNessusAPI](Docs/Connect-PSNessusAPI.md)
This command is used to authenticate with the Nessus server.

### [Get-PSNessusFolders](Docs/Get-PSNessusFolders.md)
This function will list all folders in Nessus.

### [Get-PSNessusScans](Docs/Get-PSNessusScans.md)
This function will list all scans or specific scans based on a folder ID.

### [Get-PSNessusScanReport](Docs/Get-PSNessusScanReport.md)
This function will list the output of the scans based on the scan id.

### [Get-PSNessusScanVulnerability](Docs/Get-PSNessusScanVulnerability.md)
This function will list all vulnerabilities for a scan based on the scan id and vulnerability id.