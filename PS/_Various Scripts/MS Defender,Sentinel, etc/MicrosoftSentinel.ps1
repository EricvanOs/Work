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

Close-HeliosVault

$thumbprint = (Get-ChildItem -Path Cert:\CurrentUser\My |Where-Object{$_.Subject -eq 'CN=SentinelManagement'}).Thumbprint

Connect-AzAccount -ServicePrincipal `
  -CertificateThumbprint $Thumbprint `
  -ApplicationId $ApplicationId `
  -TenantId $TenantId


Disconnect-AzAccount

# mag ook zo
Connect-AzAccount -CertificateThumbprint $Thumbprint `
  -ApplicationId $ApplicationId `
  -TenantId $TenantId

Get-AzAccessToken

###############
$authUrl = "https://login.microsoftonline.com/" + $tenantId + "/oauth2/token";

$postParams = @{ 
    resource = "https://management.azure.com"
    grant_type = "client_credentials"
    client_id = $client_id
    client_secret = $client_secret
}

$authResponse = Invoke-RestMethod -Method POST -Uri $authurl -Body $postParams

$sessionExpires = $authResponse.expires_on
$apiToken = $authResponse.access_token



$workspace = '/subscriptions/'+$subscriptionId+'/resourcegroups/'+$workspaceResourceGroup+'/providers/microsoft.operationalinsights/workspaces/'+$workspaceName.


$headers = @{
    'Authorization' = "Bearer $apiToken "
    'Content-Type'  = 'application/json'
}
# Used single qoutes because we need to treat the $ in the URL as text, not as variable as they are part of the oData implementation.
$URI = 'https://management.azure.com' + $workspace + '/providers/Microsoft.SecurityInsights/incidents?api-version=2020-01-01

