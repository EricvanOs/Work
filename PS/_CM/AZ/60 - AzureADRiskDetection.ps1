# using AzureADRiskDetection Application in Azure
$ClientID = "57cb2f26-655c-4033-90d6-30ae87b8edcd"  # also known as ApplicationID
$ClientSecret = "wLK7Q~sNVt4PotkShkj0wYjiCHB3_PmIVo_J5" 
$tenantdomain = "in-li.eu" 
$loginURL = "https://login.microsoft.com"
$resource = "https://graph.microsoft.com"
$body = @{grant_type="client_credentials";resource=$resource;client_id=$ClientID;client_secret=$ClientSecret}
$oauth = Invoke-RestMethod -Method Post -Uri $loginURL/$tenantdomain/oauth2/token?api-version=1.0 -Body $body
Write-Output $oauth
if ($null -ne $oauth.access_token ) {
	$headerParams = @{'Authorization'="$($oauth.token_type) $($oauth.access_token)"}
	$url = "https://graph.microsoft.com/v1.0/identityProtection/riskDetections"
 	Write-Output $url
 	$myReport = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $url)
 	foreach ($event in ($myReport.Content | ConvertFrom-Json).value) {
 		Write-Output $event
 	}
 } else {
 	Write-Host "ERROR: No Access Token"
 }


# to do --> cleanup & store secrets in vault