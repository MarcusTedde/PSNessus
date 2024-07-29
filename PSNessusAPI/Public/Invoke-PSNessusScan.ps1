function Invoke-PSNessusScan {
  <#
      .SYNOPSIS
        Will start a scan based on the scan ID.
      .DESCRIPTION
        This cmdlet lists launches a Nessus scan for an existing Scan ID.
      .PARAMETER ScanId
        The ID of the scan to run.
      .OUTPUTS
        This cmdlet outputs an invoke-webrequest response.
      .NOTES

        Version:        0.0.1
        Author:         Marcus Tedde
        Creation Date:  28/12/2023
        Purpose/Change: Initial script development

      .EXAMPLE
        Invoke-PSNessusScan -ScanId "1"
    #>
   [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ScanId
    )
  Try {
    $ScanResponse = Invoke-WebRequest -UseBasicParsing -Uri "https://yournessusurl/scans/$ScanID/launch" `
      -Method "POST" `
      -Headers @{
        "Accept"="*/*"
        "Accept-Encoding"="gzip, deflate, br"
        "Accept-Language"="en-US,en;q=0.9"
        "Origin"="https://yournessusurl"
        "Referer"="https://yournessusurl/"
        "Sec-Fetch-Dest"="empty"
        "Sec-Fetch-Mode"="cors"
        "Sec-Fetch-Site"="same-origin"
        "X-API-Token"="apitoken"
        "X-Cookie"="token=$script:Token"
      } `
      -ContentType "application/json"
      return $ScanResponse
  }
  catch
  {
    Write-Error "Error: $_"
  }
}
