# https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/licensing-service-plan-reference

$LicenseInfo = Import-Csv -Path 'C:\Work\PS\_CM\AZ\Product names and service plan identifiers for licensing.csv'

Connect-MgGraph -Scopes 'LicenseAssignment.ReadWrite.All'

# list of all SKU's but not very helpfull
Get-MgSubscribedSku

# join with othe 'table'
Import-Module -Name JoinModule

$SubscribedSku = Get-MgSubscribedSku

$SubscribedSku | InnerJoin $LicenseInfo -On SkuId -Equals Guid | 
Select-Object -Property Product_Display_Name, AppliesTo,CapabilityStatus,ConsumedUnits,Guid -Unique | Format-Table

# licenses assigned to a user
$userid =  'ericvanos@xhelios.onmicrosoft.com' 
Get-MgUserLicenseDetail -UserId  $userid | Format-List 



