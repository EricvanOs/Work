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