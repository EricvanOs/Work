# to be sure
Disconnect-MgGraph 

Connect-MgGraph -Scopes AuditLog.Read.All
Get-MgAuditLogSignIn -Top 1 | Select-Object -Property * |
Select-Object userDisplayName, userPrincipalName, appDisplayName, ipAddress, clientAppUsed, 
    @{Name = 'DeviceOS'; Expression = {$_.DeviceDetail.OperatingSystem}},
    @{Name = 'Location'; Expression = {$_.Location.City}}