# extending modulepath (once)
$Env:PSModulePath += ";C:\PowerShell-Scripts\Modules"

# create module e.g Helios

# create functions to open en close the vault

# see \\pantheon\data\Misc\PowerShell-Scripts\Modules\Helios

# to test the module


Open-HeliosVault 

Get-SecretVault

Get-Secret -Name ApplicationID -AsPlainText

# open again without closing

Open-HeliosVault 

# close the vault
Close-HeliosVault
Get-SecretVault


# create password-xml-file; unique per (user,computer)-combination
$password = Read-Host -AsSecureString

$password | Export-Clixml -Path '\\pantheon\data\Misc\Credentials\Amphitrite\ScriptingVaultTest-Administrator.xml' #create a file per (user,computer)-combination

#import xml-file en decrypt

$securestring = Import-Clixml -Path '\\pantheon\data\Misc\Credentials\Amphitrite\ScriptingVaultTest-Administrator.xml'

$password = [System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($securestring))

$password

#cleanup
remove-item -Path '\\pantheon\data\Misc\Credentials\Amphitrite\ScriptingVaultTest-Administrator.xml'