# connect and set correct context
Set-AzContext -SubscriptionId (Get-AzSubscription -TenantId ((Connect-AzAccount).Context.Tenant)).Id

#  username and password for the Azure VM
$cred = Get-Credential

# splatting
$vmParams = @{
ResourceGroupName = 'myResourceGroup'
Name = 'TestVM'
Location = 'westeurope'
ImageName = 'Win2016Datacenter'
PublicIpAddressName = 'TestPublicIp'
Credential = $cred
OpenPorts = 3389
}


New-AzVM @vmParams -WhatIf