# extending modulepath (once)
$Env:PSModulePath += ";C:\PowerShell-Scripts\Modules"

# create module e.g Helios

# create function

#input parameters to kdbx-file and keyx-file (and set defaults)
# install module if needed
if(-not (Get-Module Microsoft.PowerShell.SecretManagement -ListAvailable)){
    Install-Module Microsoft.PowerShell.SecretManagement -Scope AllUsers -Force
    }
if(-not (Get-Module Microsoft.PowerShell.SecretStore -ListAvailable)){
    Install-Module Microsoft.PowerShell.SecretStore -Scope AllUsers -Force
    }
if(-not (Get-Module SecretManagement.KeePass -ListAvailable)){
    Install-Module SecretManagement.KeePass 
    }   


# using keepass with file authentication (Use NTFS on folder) - no masterpassword
$FolderPath = '\\pantheon\data\misc\credentials'
$VaultParameters = @{
    Path = "$FolderPath\ScriptingVault.kdbx"
    UseMasterPassword = $false
    KeyPath= "$FolderPath\ScriptingVault.keyx"
}

Register-SecretVault -Name 'ScriptingVault' -ModuleName 'SecretManagement.Keepass' -VaultParameters $VaultParameters