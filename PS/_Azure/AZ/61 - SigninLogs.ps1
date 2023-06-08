Connect-AzAccount

$SetDate = (Get-Date).AddDays(-30);
$SetDate = Get-Date($SetDate) -format yyyy-MM-dd
$array = Get-AzureADAuditSignInLogs -Filter "createdDateTime gt $SetDate" | 
Select-Object userDisplayName, userPrincipalName, appDisplayName, ipAddress, clientAppUsed, @{Name = 'DeviceOS'; Expression = {$_.DeviceDetail.OperatingSystem}},@{Name = 'Location'; Expression = {$_.Location.City}}
$array | Export-Csv "C:\PS\AzureUserSigninLogs.csv" –NoTypeInformation