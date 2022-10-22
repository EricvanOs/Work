Open-HeliosVault 
$vault = 'ScriptingVault'
# Read secrets from vault 
$ApplicationId = (Get-Secret -Name MSGraphMail-ApplicationID -Vault $vault -AsPlainText)
Close-HeliosVault

# upload cer-file (not pfx) manually to azure or scripted
Connect-AzAccount 

$path = '\\pantheon\data\misc\Credentials'
$cert = New-Object  System.Security.Cryptography.X509Certificates.X509Certificate("$($path)\MSGraphMail.cer")
$key = [System.Convert]::ToBase64String($cert.GetRawCertData())
New-AzADAppCredential -ApplicationId $ApplicationID  -CertValue $key

Disconnect-AzAccount
