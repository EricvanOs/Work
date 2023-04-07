Connect-MgGraph -Scopes 'LicenseAssignment.ReadWrite.All'

Get-MgSubscribedSku


# list of all licensed users
Get-MgUser -All | Where-Object {($_.AssignedLicenses.Count) -ne 0}  
To get a list of all unlicensed users, use the following cmdlet: 

Get-MgUser -All | Where-Object {($_.AssignedLicenses.Count) -eq 0 }  

$userid =  'ericvanos@xhelios.onmicrosoft.com' 
Get-MgUserLicenseDetail -UserId  $userid | Format-List 

Get-Mguser -All | Where-Object{(($_.AssignedLicenses).SkuId) -eq '189a915c-fe4f-4ffa-bde4-85b9628d07a0'}


# group management


Get-MgGroup -All
Suppose you want to find only the security-enabled groups; you can use the –Filter parameter and find the mail-enabled groups in Office 365. 

Get-MgGroup –Filter “securityEnabled eq true” -All

Get-MgGroupMember -GroupId <GroupId> | select AdditionalProperties | foreach {$_.AdditionalProperties.mail}
Get Office 365 Group Membership Reports Using Microsoft Graph PowerShell

To get the Office 365 groups a user is a member of, use the below cmdlet:

Get-MgUserMemberOf -UserId <User ID> | foreach {$_.AdditionalProperties.displayName}
The below cmdlet helps to identify in which groups the given group is a member,

Get-MgGroupMemberOf -GroupId <Group ID> | foreach {$_.AdditionalProperties}
After identifying the group membership, it is necessary to find the Office 365 Group owner. So, to find the group owner, run the following cmdlet.

Get-MgGroupOwner -GroupId <Group ID> | foreach {$_.AdditionalProperties.userPrincipalName}


Get-MgUser -All | Select DisplayName,UserPrincipalName,JobTitle| Export-CSV -Path "C:\ExportDetails.CSV" -NoTypeInformation

'

Get-MgUser  -UserId 'ericvanos@xhelios.onmicrosoft.com' | Select-Object -Property AssignedLicenses,LicenseAssignmentStates,LicenseDetails