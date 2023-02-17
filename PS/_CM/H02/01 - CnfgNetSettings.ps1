# equivalent of ping
Test-Connection sisyphus 

# equivalent of port-ping
Test-NetConnection -ComputerName hydra -Port 3389

$ProgressPreference = 'SilentlyContinue'
Test-NetConnection -ComputerName hydra -Port 3389 
$ProgressPreference = 'Continue'

# equivalent of ipconfig
Get-NetIPConfiguration

(Get-NetIPConfiguration).Ipv4Address | Select-Object IPAddress,Prefixlength

# change ipaddress
New-NetIPAddress -InterfaceAlias Ethernet -IPAddress 172.16.0.30 -PrefixLength 24   # adds new ipaddress
Set-NetIPAddress -InterfaceAlias Ethernet -PrefixLength 16   # change setting of interface except ipaddress
Remove-NetIPAddress -InterfaceIndex ethernet -IPAddress 17.16.0.15 # remove "old" address
 
get-help Set-NetIPAddress -Online

# set dns-server address
Set-DnsClientServerAddress -InterfaceAlias Ethernet -IPAddress 172.16.0.11

# equivalent of route delete
Remove-NetRoute -InterfaceAlias Ethernet -DestinationPrefix 0.0.0.0/0 -Confirm:$false

# equivalent of route add
New-NetRoute -InterfaceAlias Ethernet -DestinationPrefix 0.0.0.0/0 -NextHop 172.16.0.2


## Extra
Get-NetIPConfiguration | Select-Object -Property AllIpAddresses

Get-NetIPConfiguration | Select-Object -ExpandProperty   AllIpAddresses

Get-NetIPConfiguration | Select-Object -ExpandProperty   AllIpAddresses | Select-Object -Property IpAddress 

(Get-NetIPConfiguration | Select-Object -ExpandProperty   AllIpAddresses).IPAddress 

# vergelijk typename
Get-NetIPConfiguration | Select-Object -ExpandProperty   AllIpAddresses | Select-Object -Property IpAddress | get-member

(Get-NetIPConfiguration | Select-Object -ExpandProperty   AllIpAddresses).IPAddress | Get-Member

