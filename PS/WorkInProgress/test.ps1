$password = Read-Host -AsSecureString

$password | Export-Clixml -Path '\\pantheon\data\Misc\Credentials\Amphitrite\ScriptingVault-Administrator.xml'

#import xml-file en decrypt

$securestring = Import-Clixml -Path '\\pantheon\data\Misc\Credentials\Amphitrite\ScriptingVault-Administrator.xml'

$password = [System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($securestring))

$password