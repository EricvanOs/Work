# using AzureADRiskDetection Application in Azure

# get information from Vault
Open-HeliosVault

$vault = 'ScriptingVault'
# Read secrets from vault 
$tenantId = (Get-Secret -Name TenantID -Vault $vault -AsPlainText) 
$ApplicationId = (Get-Secret -Name AzureADRiskDetection-ApplicationID -Vault $vault -AsPlainText) 
$ApplicationSecret = (Get-Secret -Name AzureADRiskDetection-Secret -Vault $vault -AsPlainText) 

Close-HeliosVault

$loginURL = "https://login.microsoft.com"
$resource = "https://graph.microsoft.com"
$body = @{grant_type="client_credentials";resource=$resource;client_id=$ApplicationID;client_secret=$ApplicationSecret}
$oauth = Invoke-RestMethod -Method Post -Uri $loginURL/$tenantid/oauth2/token?api-version=1.0 -Body $body
Write-Output $oauth
if ($null -ne $oauth.access_token ) {
	$headerParams = @{'Authorization'="$($oauth.token_type) $($oauth.access_token)"}
	$url = "https://graph.microsoft.com/v1.0/identityProtection/riskDetections"
	Write-Output $url
	$myReport = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $url)
	foreach ($event in ($myReport.Content | ConvertFrom-Json).value) {
		Write-Output $event
	}
	} 
	else {
		Write-Host "ERROR: No Access Token"
}




# easier via MS Graph
Connect-MgGraph -Scopes 'IdentityRiskyUser.Read.All','IdentityRiskEvent.Read.All'  -NoWelcome   #scopes: Risky User, User Risk

Get-MgRiskyUser
Get-MgRiskDetection
