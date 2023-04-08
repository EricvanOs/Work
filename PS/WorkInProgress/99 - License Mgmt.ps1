Connect-MgGraph -Scopes 'LicenseAssignment.ReadWrite.All'

Get-MgSubscribedSku


# list of all licensed users
Get-MgUser -All | Where-Object {($_.AssignedLicenses.Count) -ne 0}  
To get a list of all unlicensed users, use the following cmdlet: 

Get-MgUser -All | Where-Object {($_.AssignedLicenses.Count) -eq 0 }  

$userid =  'ericvanos@xhelios.onmicrosoft.com' 
Get-MgUserLicenseDetail -UserId  $userid | Format-List 

Get-Mguser -All | Where-Object{(($_.AssignedLicenses).SkuId) -eq '189a915c-fe4f-4ffa-bde4-85b9628d07a0'}


