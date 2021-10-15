# import with parameter , run Get-Module -list AzureAD ; PSEdition = Desk 
# run as if windowspowershell 

Import-Module AzureAD -UseWindowsPowerShell
connect-AzureAd   

$UserPassword=New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile 
$UserPassword.Password="Pa55w.rd123456"

# splatting
$UserParams = @{
DisplayName = 'Abbie Parsons'
GivenName = 'Abbie'
SurName = 'Parsons'
UserPrincipalName = 'AbbieP@in-li.eu'
UsageLocation = 'US'
MailNickName = 'AbbieP'
}

New-AzureADUser @UserParams -PasswordProfile $UserPassword -AccountEnabled $true

#test
Get-AzureADUser -ObjectId AbbieP@in-li.eu

#all the user accounts in a Microsoft 365 tenant:
Get-AzureADUser -All $true

#cleanup
Get-AzureADUser -ObjectId AbbieP@in-li.eu | Remove-AzureADUser



