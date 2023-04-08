# group management
Connect-MgGraph -Scopes 'GroupMember.ReadWrite.All','Group.ReadWrite.All'



#region creating all objects
    # create group A,B 
    # create userA, UserB1,UserB1
    # userA mmber of GroupA, UserB1 and UserB2 member of GroupB
    # GroupA contains userA and GroupB

$params = @{
	Description = "Group A"
	DisplayName = "Group A"
	MailEnabled = $false
	MailNickname = "libraryA"
	SecurityEnabled = $true
}
New-MgGroup -BodyParameter $params


$params = @{
	Description = "Group B"
	DisplayName = "Group B"
	MailEnabled = $false
	MailNickname = "libraryB"
	SecurityEnabled = $true
}
New-MgGroup -BodyParameter $params

$NewPasswordProfile = @{}
$NewPasswordProfile["Password"]= "Pa55w.rd123456"
$NewPasswordProfile["ForceChangePasswordNextSignIn"] = $True

$UserParams = @{
    DisplayName = 'UserA'
    GivenName = 'UserA'
    SurName = 'UserA'
    UserPrincipalName = 'UserA@in-li.eu'
    UsageLocation = 'US'
    MailNickName = 'UserA'
    PasswordProfile = $NewPasswordProfile 
    AccountEnabled = $true
}

New-MgUser @UserParams 

$NewPasswordProfile = @{}
$NewPasswordProfile["Password"]= "Pa55w.rd123456"
$NewPasswordProfile["ForceChangePasswordNextSignIn"] = $True

$UserParams = @{
    DisplayName = 'UserB1'
    GivenName = 'UserB1'
    SurName = 'UserB1'
    UserPrincipalName = 'UserB1@in-li.eu'
    UsageLocation = 'US'
    MailNickName = 'UserB1'
    PasswordProfile = $NewPasswordProfile 
    AccountEnabled = $true
}

New-MgUser @UserParams 


$NewPasswordProfile = @{}
$NewPasswordProfile["Password"]= "Pa55w.rd123456"
$NewPasswordProfile["ForceChangePasswordNextSignIn"] = $True

$UserParams = @{
    DisplayName = 'UserB2'
    GivenName = 'UserB2'
    SurName = 'UserB2'
    UserPrincipalName = 'UserB2@in-li.eu'
    UsageLocation = 'US'
    MailNickName = 'UserB2'
    PasswordProfile = $NewPasswordProfile 
    AccountEnabled = $true
}

New-MgUser @UserParams 

#endregion

#region adding users/groups to groups
# Add user B1 ,B2 to GroupB
$objectid = (Get-mgUser -UserId 'userB1@in-li.eu').id
$groupidB = (get-mgGroup -all | where-object{$_.DisplayName -eq 'Group B'}).Id
New-MgGroupMember -GroupId $groupidB -DirectoryObjectId $objectid

$objectid = (Get-mgUser -UserId 'userB2@in-li.eu').id
New-MgGroupMember -GroupId $groupidB -DirectoryObjectId $objectid

# add groupB and UserA to groupA
$objectid = (Get-mgUser -UserId 'userA@in-li.eu').id
$groupidA = (get-mgGroup -all | where-object{$_.DisplayName -eq 'Group A'}).Id
New-MgGroupMember -GroupId $groupidA -DirectoryObjectId $objectid
New-MgGroupMember -GroupId $groupidA -DirectoryObjectId $groupidB

#endregion


# All groups
Get-MgGroup -All

# All security groups
Get-MgGroup -Filter “securityEnabled eq true” -All

# get all members of groupA
Get-MgGroupMember -GroupId $GroupidA | 
Foreach-Object {$_.AdditionalProperties.displayName}

# userB is member of group?
$userid = (Get-mgUser -UserId 'userB1@in-li.eu').id
Get-MgUserMemberOf -UserId $userid | Foreach-Object {$_.AdditionalProperties.displayName}

# GroupB is member of group?
Get-MgGroupMemberOf -GroupId $groupidB | foreach-object  {$_.AdditionalProperties}


# export users to csv-file
Set-Location -Path 'C:\work\ps\_Various Scripts'

Get-MgUser -All | 
Select-Object DisplayName,UserPrincipalName,JobTitle | 
Export-CSV -Path .\ExportDetails.csv -NoTypeInformation

# test 
Get-Content -Path .\ExportDetails.csv


#region cleanup
remove-item -Path .\ExportDetails.csv

$objectid = (Get-mgUser -UserId 'userB1@in-li.eu').id
Remove-MgUser -UserId $objectid
$objectid = (Get-mgUser -UserId 'userB2@in-li.eu').id
Remove-MgUser -UserId $objectid
$objectid = (Get-mgUser -UserId 'userA@in-li.eu').id
Remove-MgUser -UserId $objectid

$groupid = (get-mgGroup -all | where-object{$_.DisplayName -eq 'Group A'}).Id
Remove-MgGroup -GroupId $groupid
$groupid = (get-mgGroup -all | where-object{$_.DisplayName -eq 'Group B'}).Id
Remove-MgGroup -GroupId $groupid

#endregion