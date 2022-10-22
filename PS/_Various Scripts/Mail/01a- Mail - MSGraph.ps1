# CertificateBasedApp For MSGraphMail 

#region Need to do once for a certificate to use with Application

    # create self-signed certificate
    New-SelfSignedCertificate -Subject "MSGraphMail" -CertStoreLocation Cert:\CurrentUser\My

    #install certificate & export cer and pfx-file
    $thumbprint = (Get-ChildItem -Path Cert:\CurrentUser\My |Where-Object{$_.Subject -eq 'CN=MSGraphMail'}).Thumbprint
    $path = '\\pantheon\data\misc\Credentials'

    Export-Certificate -Cert Cert:\CurrentUser\My\$thumbprint -Type Cert -FilePath $path\MSGraphMail.cer
    $password = ConvertTo-SecureString -String "CertificateSecretPassword" -Force -AsPlainText  # not safe
    Export-PfxCertificate -Password $password -Cert Cert:\CurrentUser\My\$thumbprint -FilePath $path\MSGraphMail.pfx

    # good practice remove certificate from machine
    Get-ChildItem -Path Cert:\CurrentUser\My |Where-Object{$_.Subject -eq 'CN=MSGraphMail'} | Remove-Item

#endregion