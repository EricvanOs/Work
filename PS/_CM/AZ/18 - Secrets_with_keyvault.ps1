# save credential once. bounded to user on specific computer
<# 
$username = "$env:USERDOMAIN\$env:USERNAME"
Get-Credential -UserName $username | Export-Clixml -Path "\\pantheon\data\Courses\AZ040\$($env:USERDOMAIN)_$($env:USERNAME)_$($env:computername).xml"
#>

#Install if needed
Install-Module Microsoft.PowerShell.SecretManagement

#Common set of commands can use across vaults (where secrets are stored)
Get-Command -Module Microsoft.PowerShell.SecretManagement

#What vaults are registered
Get-SecretVault

# need to login into Azure
$azc = Connect-AzAccount
# The SubscriptionId in which to create these objects
$SubscriptionId = (Get-AzSubscription -TenantId ($azc.Context.Tenant)).Id
# Set subscription 
Set-AzContext -SubscriptionId $subscriptionId 

#Azure Key Vault
#Must be authenticated already with context set
$KVParams = @{ AZKVaultName = "keyvault2he"; SubscriptionId = $SubscriptionId}
Register-SecretVault -Module Az.KeyVault -Name KeyVaultStore -VaultParameters $KVParams

#Test again what vaults are registered
Get-SecretVault

#Store a secret in it
Set-Secret -Name Password1 -Secret "Pa55word"

Get-Secret -Name Password1 -AsPlainText
Set-Secret -Name Password1 -Secret "N3wPa55word"

<#
#Useful later!!!
Set-Secret -Name DevSubID -Secret "YourSubID"
$AzSubID = Get-Secret -Name DevSubID -AsPlainText
#>

#secrets can also be hash tables
Set-Secret -Name Password2 -Secret @{ username1 = "Pa55word1"; username2 = "N3verGue55"}
$creds = Get-Secret -Name Password2 -AsPlainText
$creds.username1


Get-SecretInfo -Vault KeyVaultStore
Get-Secret -Name Secret1 -AsPlainText #-vault if have same name over vaults


# https://www.powershellgallery.com/packages?q=secretmanagement

#Credential Manager (Windows Only) for current user
Install-Module -Name SecretManagement.JustinGrote.CredMan -Scope AllUsers -Force
Register-SecretVault -Module SecretManagement.JustinGrote.CredMan -Name CredManStore
Set-Secret -Name CredTest1 -Secret "WontShare" -Vault CredManStore #shows under credential manager as ps:<name>
Get-Secret -Name CredTest1 -AsPlainText

#See across all
Get-SecretInfo


Get-SecretVault
#cleanup
Remove-Secret -Name Credtest1 -Vault CredManStore 
Unregister-SecretVault -Name CredManStore

Remove-Secret -Name Password1 -Vault KeyVaultStore
Remove-Secret -Name Password2 -Vault KeyVaultStore
Unregister-SecretVault -Name KeyVaultStore
