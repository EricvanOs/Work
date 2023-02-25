# import with parameter , run Get-Module -list AzureAD ; PSEdition = Desk 
# vooralsnog zijn beide imports nodig 

Import-Module AzureAD -SkipEditionCheck
Import-Module AzureAD -UseWindowsPowerShell
Connect-AzureAD  

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
Get-AzureADUser -ObjectId 1002e9f6-6269-417d-9bc8-e016527c540f

#all the user accounts in a Microsoft 365 tenant:
Get-AzureADUser -All $true


#cleanup, user needed in next examples
# Get-AzureADUser -ObjectId AbbieP@in-li.eu | Remove-AzureADUser

