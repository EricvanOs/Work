# connect
$azc = Connect-AzAccount
# The SubscriptionId in which to create these objects
$SubscriptionId = (Get-AzSubscription -TenantId ($azc.Context.Tenant)).Id
#  $SubscriptionId = (Get-AzContext).Subscription.id  # also possible
# Set subscription context
Set-AzContext -SubscriptionId $subscriptionId 

# connect and set correct context  in one step
# Set-AzContext -SubscriptionId (Get-AzSubscription -TenantId ((Connect-AzAccount).Context.Tenant)).Id

$ResourceGroupName = 'myResourceGroup77788'
if ($null -eq (Get-AzResourceGroup  | Where-Object{$_.ResourceGroupName -eq $ResourceGroupName})) { New-AzResourceGroup -name $ResourceGroupName -Location westeurope }  


#  username and password for the Azure VM
$cred = Get-Credential -UserName admin3444 

# splatting
$vmParams = @{
ResourceGroupName = $ResourceGroupName
Name = 'TestVM'
Location = 'westeurope'
ImageName = 'Win2016Datacenter'
PublicIpAddressName = 'TestPublicIp'
Credential = $cred
OpenPorts = 3389
}


New-AzVM @vmParams -PublicIpSku Standard -WhatIf


# cleanup
Get-AzResourceGroup  | Where-Object{$_.ResourceGroupName -eq $ResourceGroupName} | Remove-AzResourceGroup -Confirm:$false -Force