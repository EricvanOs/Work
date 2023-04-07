# Microsoft Graph permissions reference
# https://learn.microsoft.com/en-us/graph/permissions-reference

Import-Module -Name JWTDetails

Disconnect-MgGraph 

Connect-MgGraph -Scopes 'User.Read.All'

# ARM Endpoint
$AccessTokenARM = (Get-AzAccessToken).Token

$AccessTokenARM | Get-JWTDetails


# MS Graph Endpoint
$AccessTokenType = (Get-AzAccessToken -ResourceTypeName MSGraph).Token
$AccessTokenType | Get-JWTDetails


#MS Graph Endpoint
$AccessTokenUrl = (Get-AzAccessToken -ResourceUrl 'https://graph.microsoft.com').Token
$AccessTokenUrl | Get-JWTDetails



Get-MgUser -UserId 'ericvanos@xhelios.onmicrosoft.com'
Get-MgUser -All



# Connect to MS Graph with tenantid
Connect-MgGraph  -TenantId c395f110-ab2e-44ab-b096-7000e2511b32
# Connect to MS Graph (with latest used tenant)
Connect-MgGraph 





Connect-MgGraph  -Scopes 'Policy.ReadWrite.ApplicationConfiguration','Policy.Read.All'
Import-Module Microsoft.Graph.Identity.SignIns
Get-MgPolicyTokenLifetimePolicy

Connect-MgGraph -Scopes 
Get-MgPolicyTokenLifetimePolicy
New-AzureADUser @UserParams -PasswordProfile $UserPassword -AccountEnabled $true

#test
Get-AzureADUser -ObjectId AbbieP@in-li.eu
Get-AzureADUser -ObjectId 1002e9f6-6269-417d-9bc8-e016527c540f

#all the user accounts in a Microsoft 365 tenant:
Get-AzureADUser -All $true


#cleanup, user needed in next examples
# Get-AzureADUser -ObjectId AbbieP@in-li.eu | Remove-AzureADUser

# https://learn.microsoft.com/en-us/powershell/microsoftgraph/migration-steps?view=graph-powershell-1.0