$password = 'secret'
$password | Export-Clixml -Path k:\tt.xml

Remove-Item -Path k:\tt.xml

$password =  ConvertTo-SecureString -AsPlainText 'secret' -Force
# of
$password = Read-Host -AsSecureString

$password | Export-Clixml -Path k:\tt.xml

#import tt.xml en decrypt

$securestring = Import-Clixml -Path k:\tt.xml

$password = [System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($securestring))

$password

Remove-Item -Path k:\tt.xml