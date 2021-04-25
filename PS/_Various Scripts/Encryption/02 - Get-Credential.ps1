$cred = Get-Credential

$cred | Export-Clixml -Path k:\cred.xml

$securestring = Import-Clixml -Path k:\cred.xml

$securestring.GetNetworkCredential().userName
$securestring.GetNetworkCredential().Domain
$securestring.GetNetworkCredential().password

# cleanup

Get-Item -Path K:\cred.xml | Remove-Item