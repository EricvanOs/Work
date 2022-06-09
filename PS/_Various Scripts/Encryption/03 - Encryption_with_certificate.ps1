$Path = 'K:\_Various Scripts\Encryption'
Set-Location -Path $Path

$params = @{DnsName = $env:COMPUTERNAME
            CertStoreLocation =  'Cert:\CurrentUser\My'
            KeyUsage = 'KeyEncipherment','DataEncipherment','KeyAgreement'
            Type = 'DocumentEncryptionCert'
            FriendlyName = 'My selfsigned certificate'
            }


New-SelfSignedCertificate @params

$cert = Get-Childitem -Path Cert:\CurrentUser\My -DocumentEncryptionCert | 
  Where-Object{$_.FriendlyName -eq 'My selfsigned certificate' -and  $_.subject -eq "cn=$($env:COMPUTERNAME)"}


'This is a secret message' | Protect-CmsMessage -To $cert -OutFile ".\secret.txt"
Get-Content -path ".\secret.txt" 

Unprotect-CmsMessage -Path ".\secret.txt"

#cleanup

$cert | Remove-Item 
remove-item -Path ".\secret.txt"