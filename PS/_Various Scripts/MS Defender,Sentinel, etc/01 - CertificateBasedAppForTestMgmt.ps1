# CertificateBasedAppForTestMgmt

#region Need to do once for a certificate to use with Application

    # create self-signed certificate
    New-SelfSignedCertificate -Subject "Test Mgmt" -CertStoreLocation Cert:\CurrentUser\My

    #install certificate
    $thumbprint = (Get-ChildItem -Path Cert:\CurrentUser\My |Where-Object{$_.Subject -eq 'CN=Test Mgmt'}   ).Thumbprint
    $path = '\\pantheon\data\misc\Credentials'

    Export-Certificate -Cert Cert:\CurrentUser\My\$thumbprint -Type Cert -FilePath $path\TestMgmt.cer
    $password = ConvertTo-SecureString -String "CertificateSecretPassword" -Force -AsPlainText  # not safe
    Export-PfxCertificate -Password $password -Cert Cert:\CurrentUser\My\$thumbprint -FilePath $path\TestMgmt.pfx

    # good practice remove certificate from machine
    Get-ChildItem -Path Cert:\CurrentUser\My |Where-Object{$_.Subject -eq 'CN=Test Mgmt'} | Remove-Item

    # upload cer-file (not pfx) manually to azure or scripted
    Connect-AzAccount 

    $ApplicationID = '7ffa9e3d-95ad-418c-9ee5-2422e989a634'  # same as ClientID (not safe) 

    $cert = New-Object  System.Security.Cryptography.X509Certificates.X509Certificate("$($path)\TestMgmt.cer")
    $key = [System.Convert]::ToBase64String($cert.GetRawCertData())
    New-AzADAppCredential -ApplicationId $ApplicationID  -CertValue $key


    # logoff azure to test 
    Disconnect-AzAccount
    #endregion

#region Now want to use certificate based authentication 
    # install pfx file (once on a machine)
    $password = ConvertTo-SecureString -String "CertificateSecretPassword" -Force -AsPlainText
    Import-PfxCertificate -Password $password -FilePath $path\TestMgmt.pfx -CertStoreLocation Cert:\CurrentUser\My
#endregion

# test 
# if needed Install-Module Microsoft.Graph -Scope CurrentUser 
$ApplicationID = '7ffa9e3d-95ad-418c-9ee5-2422e989a634'
$thumbprint = (Get-ChildItem -Path Cert:\CurrentUser\My |Where-Object{$_.Subject -eq 'CN=Test Mgmt'}   ).Thumbprint

Connect-MgGraph -ClientId $ApplicationID -TenantId 'in-li.eu' -CertificateThumbprint $thumbprint
Get-MgAuditLogSignIn | Measure-Object

# finished using MSGraph
Disconnect-MgGraph 

#cleanup
Get-ChildItem -Path $path | Where-Object{$_.name -like 'TestMgmt.*'} | Remove-Item 
Get-ChildItem -Path Cert:\CurrentUser\My |Where-Object{$_.Subject -eq 'CN=Test Mgmt'} | Remove-Item
Connect-AzAccount
Get-AzADApplication -DisplayName 'CertificateBasedAppForTestMgmt' | Remove-AzADAppCredential
Disconnect-AzAccount

