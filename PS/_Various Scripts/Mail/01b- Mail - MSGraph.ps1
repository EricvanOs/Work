# Add secrets/information to vault

# Naming Convention
<#
Directory (tenant) ID is always the same in my environment : TenantID
Application (client) ID is different per application : {name of registered application in Azure}-ApplicationID
Application Secret is different per application : {name of registered application in Azure}-Secret    
#>

#open the vault
Open-HeliosVault

#adding info to vault
#What vaults are registered
Get-SecretVault
$vault = 'ScriptingVault'
# test Keepass Database 
Test-SecretVault -Name $vault

#Common set of commands can use across vaults (where secrets are stored)
Get-Command -Module Microsoft.PowerShell.SecretManagement

# add tenantid (once for all apps) -- Only once in your environment
# Set-Secret -Name TenantID -Secret 'c395f110-ab2e-44ab-b096-7000e2511b32' -Vault $vault    

# read a secret
Get-Secret -Name TenantID -AsPlainText

# name of registered application in Azure
$RegApp = 'MSGraphMail'

Set-Secret -Name "$RegApp-ApplicationID" -Secret 'd1b2dce5-8b8d-490f-a1c3-f1eaf46ce2a2' -Vault $vault
# Set-Secret -Name "$RegApp-Secret" -Secret 'DuEblablabalblablabla' -Vault $vault  # geheim

# to test first three chars of secret
# (Get-Secret -Name MicrosoftDefenderForEndpoint-Secret -AsPlainText).ToString().Substring(0,3)


# close vault
Close-HeliosVault