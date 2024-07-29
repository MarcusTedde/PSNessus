function Get-PSNessusGPTAnswer.ps1 {

  [CmdletBinding()]
  param (
      [Parameter(Mandatory = $true)]
      [string]$Deployment,
      [Parameter(Mandatory = $true)]
      [string]$CVE
  )

  $CVERequest = Invoke-WebRequest -Uri 'https://www.tenable.com/cve/$CVE'
  $Message = $CVERequest.ParsedHtml.getElementsByName('description') | Select-Object -ExpandProperty content
    
  # 3. Named parameter
  $Question = Request-AzureChatGPT -Message "Can you provide a suggested technical resolution for the following CVE description. If the resolution is a script, then please provide the exact code required with an explanation of what the code does: $Message" -Deployment $Deployment -ApiBase 'https://azureaiservices.openai.azure.com/'
  return $Question
}
