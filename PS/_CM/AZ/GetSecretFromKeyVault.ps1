login-azAccount

$a = Get-AzKeyVaultSecret -VaultName 'keyvault2he' -Name 'mysecret' -Version '5a651de5f61f4155b876df6e396c4164'

$a.SecretValue

ConvertFrom-SecureString $a.SecretValue -AsPlainText


# of 

$a = Get-AzKeyVaultSecret -VaultName 'keyvault2he' -Name 'mysecret'

ConvertFrom-SecureString $a.SecretValue -AsPlainText

# opmerkingen -- alleen met powershell 7 en az-module
# vanuit cloudshell lukt 't niet omdat er dan eerst een compound identity gemaakt moet worden

