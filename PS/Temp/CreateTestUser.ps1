
<# run once to create test-user account
Connect-MgGraph -Scopes 'User.Read.All','User.ReadWrite.All'

# Delete test User if exists
if ($null -ne (Get-MgUser | Where-Object{$_.DisplayName -eq 'Marcus Aurelius'})){Remove-MgUser -UserId ((Get-MgUser | Where-Object{$_.DisplayName -eq 'Marcus Aurelius'})).id}


# create new user
$NewPasswordProfile = @{}
$NewPasswordProfile["Password"]= "P@ssw0rd1234"
$NewPasswordProfile["ForceChangePasswordNextSignIn"] = $false

$UserParams = @{
    DisplayName = 'Marcus Aurelius'
    GivenName = 'Marcus'
    SurName = 'Aurelius'
    UserPrincipalName = 'Caesar@in-li.eu'
    UsageLocation = 'IT'
    MailNickName = 'Verissimus'
    PasswordProfile = $NewPasswordProfile 
    AccountEnabled = $true
}

New-MgUser @UserParams    

Disconnect-MgGraph
Disconnect-AzAccount -Username 'ericvanos@xhelios.onmicrosoft.com'
#>

## login with test-user
$user = 'Caesar@in-li.eu'
$password = ConvertTo-SecureString 'P@ssw0rd1234' -AsPlainText -Force 
$cred = [PSCredential]::new($user, $password)


#login 
$azc = Connect-AzAccount -Credential $cred

# whoami?
$azc

#
Connect-MgGraph -Scopes 'User.Read.All' 
Get-MgUser 


Get-MgGroup # will fail
