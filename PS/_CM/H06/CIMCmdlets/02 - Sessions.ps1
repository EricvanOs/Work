# 1
$cred = Get-Credential

# mag ook op volgende wijze
$cred = Get-Credential  -UserName Pantheon\administrator -Message 'Fill in password'

$ses = New-CimSession -ComputerName Sisyphus -Credential $cred

# 2
Get-CimInstance -CimSession $ses -ClassName Win32_OperatingSystem

# 3
$ses | Remove-CimSession


Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName sisyphus   #geen credential mogelijk, gebruik new-cimsession voor credentials 


