# install module if needed
Install-Module Microsoft.PowerShell.SecretManagement, Microsoft.PowerShell.SecretStore -Scope AllUsers
Install-Module -Name SecretManagement.KeePass -RequiredVersion 0.9.2

# using keepass with file authentication (Use NTFS on folder) and masterpassword
$FolderPath = '\\pantheon\data\misc\credentials'
$VaultParameters = @{
    Path = "$FolderPath\ScriptingVault.kdbx"
    UseMasterPassword = $true
    KeyPath= "$FolderPath\ScriptingVault.keyx"   #mag op USB-stick
}

# Masterpassword = mijnsupergeheimepaswoord

Register-SecretVault -Name 'ScriptingVault' -ModuleName 'SecretManagement.Keepass' -VaultParameters $VaultParameters

# test Keepass Database 
Test-SecretVault -Name ScriptingVault

#Common set of commands can use across vaults (where secrets are stored)
Get-Command -Module Microsoft.PowerShell.SecretManagement

#Commands to manage the Secret Store vault
Get-Command -Module Microsoft.PowerShell.SecretStore

#What vaults are registered
Get-SecretVault

# add secrets (once)
Set-Secret -Name ApplicationID -Secret "7ffa9e3d-95ad-418c-9ee5-2422e989a634" -Vault ScriptingVault

# read a secret
Get-Secret -Name ApplicationID -AsPlainText


# end of script unregister the SecretVault
Unregister-SecretVault -Name ScriptingVault
