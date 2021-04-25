$pwd = 'secret'
$pwd | Export-Clixml -Path k:\tt.xml

Remove-Item -Path k:\tt.xml

$pwd =  ConvertTo-SecureString -AsPlainText 'secret' -Force
# of
$pwd = Read-Host -AsSecureString

$pwd | Export-Clixml -Path k:\tt.xml

#import tt.xml en decrypt

$securestring = Import-Clixml -Path k:\tt.xml

$pwd = [System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($securestring))

$pwd

Remove-Item -Path k:\tt.xml