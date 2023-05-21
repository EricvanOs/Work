# RDP to a server using ipv6
# have to use the following structure:    2001-982-62f-1-2041-f947-7c4a-335f.ipv6-literal.net

[ipaddress]$ipv6 = '2a02:a469:dc98:1:192:168:82:121'

$ipv6Literal = $ipv6.IPAddressToString.Replace(":","-")+'.ipv6-literal.net'

$ipv6Literal

# test

$ProgressPreference = 'SilentlyContinue'
Test-NetConnection -ComputerName $ipv6Literal 
Test-NetConnection -ComputerName $ipv6
$ProgressPreference = 'Continue'