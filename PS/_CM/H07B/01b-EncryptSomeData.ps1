# encrypting some data

$secureString = ConvertTo-SecureString -Force -AsPlainText "hello"

# encrypted string via read-host
$secureString = Read-Host -AsSecureString

# convert it back again
[System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($securestring))

##
$secureString = ConvertTo-SecureString -String 'Example' -AsPlainText
ConvertFrom-SecureString -SecureString $secureString -AsPlainText 


#Create user
New-ADUser -Name PSHelpDeskTest -samAccountName PSHelpDeskTest
# enable account, will fail
Enable-ADAccount PSHelpDeskTest
#set password
Set-ADAccountPassword -Identity PSHelpDeskTest -NewPassword (ConvertTo-SecureString -AsPlainText 'P@ssw0rd1234567' -force)
# enable account
Enable-ADAccount PSHelpDeskTest
#cleanup
Remove-ADUser PSHelpDeskTest -Confirm:$false
