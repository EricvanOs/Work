#login
$azc = Connect-AzAccount
# The SubscriptionId in which to create these objects
$subid = (Get-AzSubscription -TenantId ($azc.Context.Tenant)).Id

#Many commands use REST behind the scenes
Get-AzResourceGroup -debug

#Invoke-WebRequest - simple response
$r = Invoke-WebRequest -Uri https://azure.microsoft.com/updates/feed/
$r
$r.Content

#Invoke-RestMethod - rich format response. Translate the response, e.g. JSON to a custom object
Invoke-RestMethod -Uri https://azure.microsoft.com/updates/feed/ 
 | Format-Table -Property title, description, pubDate


#We often need to authenticate so need a token which is passed to the command

#For Azure we can use our existing context
$azContext = Get-AzContext
$azProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($azProfile)
$token = $profileClient.AcquireAccessToken($azContext.Subscription.TenantId)
 
#Create a hash table for the auth header as we have multiple headers
$authHeader = @{
    'Content-Type'='application/json'
    'Authorization'='Bearer ' + $token.AccessToken
}

#OR MUCH easier
$token = Get-AzAccessToken #This will default to Resource Manager endpoint
$authHeader = @{
    'Content-Type'='application/json'
    'Authorization'='Bearer ' + $token.Token
}

#Again WebRequest we see everything but have to do more work
$r1 = Invoke-WebRequest -Uri https://management.azure.com/subscriptions/$subid/resourcegroups?api-version=2016-09-01 -Method GET -Headers $authHeader
$r1.Content | ConvertFrom-Json | ConvertTo-Json -depth 100 #make it look pretty
$r1.Headers["x-ms-ratelimit-remaining-subscription-reads"] #But I can go poke around other values

#RestMethod much cleaner
$r2 = Invoke-RestMethod -Uri https://management.azure.com/subscriptions/$subid/resourcegroups?api-version=2016-09-01 -Method GET -Headers $authHeader
$r2.value

#Be careful of special characters like $. Have to escape it with `
$UriString = "https://management.azure.com/subscriptions/$subID/providers/Microsoft.Compute/skus?api-version=2019-04-01&`$filter=location eq 'eastus2'"
$r = Invoke-RestMethod -Uri $UriString -Method Get -Headers $authHeader
$r.value

# or use a here-string
$rquery =@'
api-version=2019-04-01&$filter=location eq 'eastus2'
'@
$UriString = "https://management.azure.com/subscriptions/$subID/providers/Microsoft.Compute/skus?$rquery"
$r = Invoke-RestMethod -Uri $UriString -Method Get -Headers $authHeader
$r.value


#Can token get for other audiences
$accessToken = (Get-AzAccessToken -ResourceUrl "https://graph.microsoft.com").Token #MS Graph audience
$authHeader = @{
    'Content-Type'='application/json'
    'Authorization'='Bearer ' + $accessToken
}

#Submit the REST call for the list guest users!
$rquery=@'
$filter=userType eq 'guest'
'@
$r = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/users/?$rquery" -Method GET -Headers $authHeader
$r.value

