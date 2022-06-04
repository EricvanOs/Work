# create self-signed certificate
New-SelfSignedCertificate -Subject "Sentinel Mgmt" -CertStoreLocation Cert:\CurrentUser\My

#install certificate
$thumbprint = (Get-ChildItem -Path Cert:\CurrentUser\My |Where-Object{$_.Subject -eq 'CN=Sentinel Mgmt'}   ).Thumbprint
$path = '\\pantheon\data\misc\Credentials'

Export-Certificate -Cert Cert:\CurrentUser\My\$thumbprint -Type Cert -FilePath $path\SentinelMgmt.cer
$password = ConvertTo-SecureString -String "CertificateSecretPassword" -Force -AsPlainText  # not safe
Export-PfxCertificate -Password $password -Cert Cert:\CurrentUser\My\$thumbprint -FilePath $path\SentinelMgmt.pfx

# good practice remove certificate from machine
Get-ChildItem -Path Cert:\CurrentUser\My |Where-Object{$_.Subject -eq 'CN=Sentinel Mgmt'} | Remove-Item

# upload cer-file (not pfx) manually to azure or scripted
Connect-AzAccount 

$ApplicationID = '7ffa9e3d-95ad-418c-9ee5-2422e989a634'  # same as ClientID (not safe) 

$cert = New-Object  System.Security.Cryptography.X509Certificates.X509Certificate("$($path)\SentinelMgmt.cer")
$key = [System.Convert]::ToBase64String($cert.GetRawCertData())
New-AzADAppCredential -ApplicationId $ApplicationID  -CertValue $key

# logoff azure to test 
Disconnect-AzAccount


# Now want to use certificate based authentication to App

# install pfx file
$password = ConvertTo-SecureString -String "CertificateSecretPassword" -Force -AsPlainText
Import-PfxCertificate -Password $password -FilePath $path\SentinelMgmt.pfx -CertStoreLocation Cert:\CurrentUser\My

# test 
# if needed Install-Module Microsoft.Graph -Scope CurrentUser 
Connect-MgGraph -ClientId $ApplicationID -TenantId 'in-li.eu' -CertificateThumbprint $thumbprint
Get-MgAuditLogSignIn | Measure-Object
