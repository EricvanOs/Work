# Microsoft Graph permissions reference
# https://learn.microsoft.com/en-us/graph/permissions-reference

Import-Module -Name JWTDetails

Disconnect-MgGraph 

Connect-MgGraph -Scopes 'User.Read.All'

# ARM Endpoint
$AccessTokenTypeARM = (Get-AzAccessToken).Token
$AccessTokenTypeARM | Get-JWTDetails


# MS Graph Endpoint
$AccessTokenTypeGraph = (Get-AzAccessToken -ResourceTypeName MSGraph).Token
$AccessTokenTypeGraph | Get-JWTDetails


#MS Graph Endpoint (same as previous)
$AccessTokenUrl = (Get-AzAccessToken -ResourceUrl 'https://graph.microsoft.com').Token
$AccessTokenUrl | Get-JWTDetails



Get-MgUser -UserId 'ericvanos@xhelios.onmicrosoft.com'
Get-MgUser -All

# force disconnect
Disconnect-MgGraph 


# Connect to MS Graph with tenantid
Connect-MgGraph  -TenantId c395f110-ab2e-44ab-b096-7000e2511b32
# Connect to MS Graph (with latest used tenant)
Connect-MgGraph 




# work in progress
Connect-MgGraph  -Scopes 'Policy.ReadWrite.ApplicationConfiguration','Policy.Read.All'
Import-Module Microsoft.Graph.Identity.SignIns
Get-MgPolicyTokenLifetimePolicy

Connect-MgGraph -Scopes 
Get-MgPolicyTokenLifetimePolicy


