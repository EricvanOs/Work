Set-AzContext -SubscriptionId (Get-AzSubscription -TenantId ((Connect-AzAccount).Context.Tenant)).Id




Get-AzDisk 
| Select-Object -Property Name,ResourceGroupName,Type,DiskSizeGB,DiskState 
| Where-Object -Property DiskState -eq “Unattached”