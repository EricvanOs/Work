$Path = 'C:\Work\PS\_Various Scripts\Encryption'
Set-Location -Path $Path

$password = Read-Host -Prompt 'Enter your Password'
Write-Host "$password is password"
$secure = ConvertTo-SecureString $password -Force -asPlainText
$bytes = ConvertFrom-SecureString $secure
$bytes | Out-File .\securepassword.txt


# using the "$bytes" in script instead of reading file

$encrypted = '01000000d08c9ddf0115d1118c7a00c04fc297eb01000000246017843f27634487db58e1cc27fc0f0000000002000000000003660000c000000010000000b8a5570887cd0e02de502e1ad7f77c260000000004800000a0000000100000006062cb73118e8620c0f1da6977adc7f810000000ca1ec58ce878e8e4c67f5f140d59e0b7140000005d65950372c5c5968a2966e2f33640f4a6f15399'
$user = 'lab\sukhijv'
$password = ConvertTo-SecureString -string $encrypted

$cred = New-Object -typename System.Management.Automation.PSCredential -ArgumentList $user,$password

#
$cred.GetNetworkCredential().userName
$cred.GetNetworkCredential().Domain
$cred.GetNetworkCredential().password

#cleanup
Remove-Item -Path .\securepassword.txt


