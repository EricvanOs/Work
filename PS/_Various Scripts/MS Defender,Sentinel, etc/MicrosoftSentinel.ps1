<#  Already done
    # once save pfx-password in vault, applicationid also
    # create selfsigned cert
    # export to cer,pfx-file 

    #import cer-file in azure
    #import pfx-file on machine
#>

Open-HeliosVault 
$vault = 'ScriptingVault'
# Read secrets from vault 
$TenantId = (Get-Secret -Name TenantID -Vault $vault -AsPlainText) 
$ApplicationId = (Get-Secret -Name MicrosoftSentinel-ApplicationID -Vault $vault -AsPlainText)
$subscriptionId = (Get-Secret -Name SubscriptionId -Vault $vault -AsPlainText)
Close-HeliosVault

$thumbprint = (Get-ChildItem -Path Cert:\CurrentUser\My |Where-Object{$_.Subject -eq 'CN=SentinelManagement'}).Thumbprint

Connect-AzAccount -ServicePrincipal `
  -CertificateThumbprint $Thumbprint `
  -ApplicationId $ApplicationId `
  -TenantId $TenantId

Get-AzAccessToken
$apitoken = (Get-AzAccessToken).Token

# e2574477-8ce4-4f31-9bf2-080cb60cff52 - Service Principal (MicrosoftSentinel) has been placed in Microsoft Sentinel Responder role @ loganalytics2li workspace

# https://docs.microsoft.com/en-us/rest/api/securityinsights/

# GET https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents?api-version=2021-10-01

# always use a here-string as the string can contain single-quotes and $filter (not a PS variable) 
$url = @'
  https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents?api-version=2021-10-01'
'@  

# create variables with same name as {....} in above string
Set-Variable resourceGroupName  -Value 'loganalytics'
Set-Variable workspaceName  -Value 'loganalytics2li'

$url = $ExecutionContext.InvokeCommand.ExpandString((($url -replace '{','$') -replace '}',''))
  
$headers = @{ 
    'Content-Type' = 'application/json'
    Accept = 'application/json'
    Authorization = "Bearer $apiToken" 
}

$webResponse = Invoke-WebRequest -Method GET -Uri $url -Headers $headers  -ErrorAction Stop
$response = $webResponse | ConvertFrom-Json
$response.value

# disconnect 
Disconnect-AzAccount

@'
'@
