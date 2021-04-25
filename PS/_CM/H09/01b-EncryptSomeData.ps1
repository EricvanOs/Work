# encrypting some data

$secureString = ConvertTo-SecureString -Force -AsPlainText "hello"

# encrypted string via read-host
$secureString = Read-Host -AsSecureString


# convert it back again
[System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($securestring))


#Create user
New-ADUser -Name PSHelpDeskTest -samAccountName PSHelpDeskTest
# enable account, will fail
Enable-ADAccount PSHelpDeskTest
#set password
Set-ADAccountPassword -Identity PSHelpDeskTest -NewPassword (ConvertTo-SecureString -AsPlainText 'P@ssw0rd' -force)
# enable account
Enable-ADAccount PSHelpDeskTest
#cleanup
Remove-ADUser PSHelpDeskTest -Confirm:$false
