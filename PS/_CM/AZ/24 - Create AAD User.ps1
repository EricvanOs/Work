Disconnect-MgGraph
Connect-MgGraph -Scopes 'User.Read.All'


Get-Command -Name *MGUser

Get-MgUser | Where-Object{$_.DisplayName -eq 'Abbie Parsons'} | Select-Object -Property *


# create new user
$NewPasswordProfile = @{}
$NewPasswordProfile["Password"]= "Pa55w.rd123456"
$NewPasswordProfile["ForceChangePasswordNextSignIn"] = $True

$UserParams = @{
    DisplayName = 'Danny Argo'
    GivenName = 'Danny'
    SurName = 'Argo'
    UserPrincipalName = 'DannyA@in-li.eu'
    UsageLocation = 'US'
    MailNickName = 'DannyA'
    PasswordProfile = $NewPasswordProfile 
    AccountEnabled = $true
}


New-MgUser @UserParams   # should fail

# use the correct scope
Connect-MgGraph -Scopes 'User.Read.All','User.ReadWrite.All'

# try again
New-MgUser @UserParams    


#  test

Get-MgUser | Where-Object{$_.DisplayName -eq 'Danny Argo'} | Select-Object -Property *

# delete account
$userId = Get-MgUser | Where-Object{$_.DisplayName -eq 'Danny Argo'} | Select-Object -ExpandProperty id
Remove-MgUser -UserId $userId