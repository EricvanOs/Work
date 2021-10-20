$tenant = 'in-li.eu'

$openid = Invoke-RestMethod  -uri "https://login.microsoftonline.com/$tenant/v2.0/.well-known/openid-configuration" 

$openid

$openid.token_endpoint

$token = $openid.token_endpoint

$Body = @{
    client_id = "14a4552e-c0b8-40be-8285-33505c7f303d"        # better use keyvault
    client_secret = "~0wo6kV6_BAz1nzl_dK-58a40K~6f.OKdN"      # better use keyvault
    redirect_uri = "https://localhost"
    grant_type = "client_credentials"
    scope = "https://graph.microsoft.com/.default" 
    tenant = $tenant
}


# request access token
$request = Invoke-RestMethod -uri $token -Body $Body -Method Post


$request.access_token

$graph = "https://graph.microsoft.com/beta/users"

$api = Invoke-RestMethod -Headers @{Authorization = "Bearer $($request.access_token)"} -uri $graph -Method Get

$api.value | Select-Object -Property userPrincipalName, AccountEnabled

# give "auto" consent to group

#test again

$graph = "https://graph.microsoft.com/beta/groups"

$api = Invoke-RestMethod -Headers @{Authorization = "Bearer $($request.access_token)"} -uri $graph -Method Get

$api.value
