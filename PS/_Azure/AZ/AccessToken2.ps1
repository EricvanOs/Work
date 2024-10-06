#Once connected with an account (not a service Principal)
Connect-azaccount
#Let's generate an access token to the ARM fabric audience and make it a bearer token
$Token = "Bearer {0}" -f (Get-AzAccessToken -Resource "https://management.azure.com").Token
# again
Connect-AzAccount -AuthScope 'https://management.azure.com'
#Let's generate an access token to the ARM fabric audience and make it a bearer token
$Token = "Bearer {0}" -f (Get-AzAccessToken -Resource "https://management.azure.com").Token

#Let's define our subscriptionId
$subId = "940541f2-0f53-48e7-8046-f6530b423abc"
# Define our URI
$Uri = "https://management.azure.com/subscriptions/$subId/resourcegroups?api-version=2020-06-01"
#Create the header as before
$Headers = @{
    'Authorization' = $token
    "Content-Type"  = 'application/json'
}
# And let's call the endpoint
Invoke-RestMethod -Headers $Headers -Uri $uri -Method get
# You should now see all resource groups your users can see in the subscription
#Let's now imagine you have a Keyvault already created (in RBAC mode) and you want to store a new secret, lets try!
$uri = "https://<your vault>.vault.azure.net/secrets/<your secret name>?api-version=7.1"
#Let's now create a body that will contains your password
$Body = @{
    value = "MySuperSecret"
} | ConvertTo-Json
#Let's now call our Keyvault endpoint
Invoke-RestMethod -Headers $Headers -Uri $uri -Method PUT -Body $body
#You should now receive an error regarding the wrong audience and it's normal. Don't forget that previously, we've generated an AT why the https://management.azure.com audience.
# Keyvault is using another one. Let's generate a new token with the proper audience. You can use this:
$Token = "Bearer {0}" -f (Get-AzAccessToken -ResourceTypeName KeyVault).Token
#or the previous method if you prefer
$Token = "Bearer {0}" -f (Get-AzAccessToken -Resource "https://vault.azure.net").Token
#Regenerate the hearders
$Headers = @{
    'Authorization' = $token
    "Content-Type"  = 'application/json'
}
#You're good to go
Invoke-RestMethod -Headers $Headers -Uri $uri -Method get
# Now you have a new secret stored in our Keyvault