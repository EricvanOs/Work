# Creating a Certificate with New-SelfSignedCertificate 
New-SelfSignedCertificate -DnsName Amphitrite -CertStoreLocation "Cert:\CurrentUser\My" -KeyUsage KeyEncipherment,DataEncipherment, KeyAgreement -Type DocumentEncryptionCert
 
# test, is really available 
Get-Childitem -Path Cert:\CurrentUser\My -DocumentEncryptionCert
 
# get name of certificate
$subject = Get-Childitem -Path Cert:\CurrentUser\My -DocumentEncryptionCert | select-object -ExpandProperty Subject

# Encrypt some data 
"This is a secret message" | Protect-CmsMessage -To $subject -OutFile k:\_CM\secret.txt
 
# Decrypt some data 
Unprotect-CmsMessage -Path k:\_CM\secret.txt
 

# test with codesigning certificate --> Error if you encrypt data
$subject = Get-ChildItem -Path Cert:\CurrentUser\My -CodeSigningCert | select-object -ExpandProperty Subject

# create cert with: Data Encipherment or Key Encipherment key usage, and include the Document Encryption Enhanced Key Usage (1.3.6.1.4.1.311.80.1)
# create template first in CA
# use Get-Certificate 

# example using a template
Get-Certificate -Template WebServer -DnsName somename.pantheon.somewhere -Url ldap:  -CertStoreLocation cert:\LocalMachine\My 

#cleanup
Get-Childitem -Path Cert:\localMachine\My | Where-Object{$_.DNSNameList -like "*somename*"} | Remove-Item

remove-item -Path K:\_CM\secret.txt

