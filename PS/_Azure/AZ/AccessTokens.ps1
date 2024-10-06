# interactive login
Connect-AzAccount 


$token = (Get-AzAccessToken).token

$token | Get-JWTDetails


# get information about managed identity
Get-AzSystemAssignedIdentity -Scope "/subscriptions/940541f2-0f53-48e7-8046-f6530b423abc/resourcegroups/Arc/providers/Microsoft.HybridCompute/machines/Amphitrite" | 
    Select-Object -Property ClientId,PrincipalId
<#
    ClientId                             PrincipalId
    --------                             -----------
    48528e59-d8d8-4f38-a3c9-320be86593e9 4b04c20b-9402-438a-83ce-be9ed8b40c34
#>


Disconnect-AzAccount


# connect with Managed Identity
Connect-AzAccount -Identity
Set-AzContext -Subscription 'MSDN Platforms'

$token = (Get-AzAccessToken).token

$token | Get-JWTDetails

$token | Get-JWTDetails | Select-Object -Property appid , oid

# thus appid = Application (client) ID  and oid = PrincipalId (Object Id)

Disconnect-AzAccount


