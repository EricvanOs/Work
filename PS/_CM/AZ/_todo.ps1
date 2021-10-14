Get-Command -Module AzureAD -Name connec*
get-help Connect-AzureAD 

Connect-AzureAD -Credential (Get-Credential)

$azc = Connect-AzAccount
# The SubscriptionId in which to create these objects
$SubscriptionId = (Get-AzSubscription -TenantId ($azc.Context.Tenant)).Id
#  $SubscriptionId = (Get-AzContext).Subscription.id  # also possible
# Set subscription 
Set-AzContext -SubscriptionId $subscriptionId 

Get-AzADUser


(Get-AzAccessToken).Token

Connect-AzureAD -AadAccessToken (Get-AzAccessToken).Token -tenantId  c395f110-ab2e-44ab-b096-7000e2511b32 -AccountId  940541f2-0f53-48e7-8046-f6530b423abc

import-module -name AzureAD
get-command -Name *azad*