$Path = 'C:\Work\PS\_Various Scripts\Encryption'
Set-Location -Path $Path

$password = Read-Host -Prompt 'Enter your Password' -MaskInput 
Write-Host "Your password is: $password"
$secure = ConvertTo-SecureString $password -Force -asPlainText       # $secure  TypeName: System.Security.SecureString
$bytes = ConvertFrom-SecureString $secure                            # $bytes   TypeName: System.String
$bytes | Out-File .\securepassword.txt

# how read a SecureString
[System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($secure))

# using the "$bytes" in script instead of reading file
$encrypted = '01000000d08c9ddf0115d1118c7a00c04fc297eb0100000097124fd3c63730479a23f2b0870ebbb60000000002000000000003660000c00000001000000028dd2e4e060982cd68d3822a7f45ec590000000004800000a0000000100000004428177c05c3507e0b236b6a2fcf0267100000001008c4337e6dec87d18845c24f52476014000000a982ac2b1538942b2ce5115fda354f4196538c32'
$encryptedpassword = ConvertTo-SecureString -string $encrypted

# can I read it?
[System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($encryptedpassword))

# making a credential 
$user = 'Booking\Marcus'
$cred = New-Object -typename System.Management.Automation.PSCredential -ArgumentList $user,$encryptedpassword  # $cred  TypeName: System.Management.Automation.PSCredential

# Can I read it?
$cred.GetNetworkCredential().userName
$cred.GetNetworkCredential().Domain
$cred.GetNetworkCredential().password

# which methods are available for this TypeName: System.Management.Automation.PSCredential
[System.Management.Automation.PSCredential].GetMethods() |  Select-Object -Property name -Unique | Sort-Object -Property name

#cleanup
Remove-Item -Path .\securepassword.txt