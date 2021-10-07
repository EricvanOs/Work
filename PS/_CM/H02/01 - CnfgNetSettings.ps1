# 1
Test-Connection sisyphus 

# 1b
Test-NetConnection -ComputerName hydra -Port 3389


# 2
Get-NetIPConfiguration

# 3
New-NetIPAddress -InterfaceAlias Ethernet -IPAddress 172.16.0.30 -PrefixLength 24   # adds new ipaddress
Set-NetIPAddress -InterfaceAlias Ethernet -PrefixLength 16   # change setting of interface except ipaddress
Remove-NetIPAddress -InterfaceIndex ethernet -IPAddress 17.16.0.15 # remove "old" address
 
get-help Set-NetIPAddress -Online

# 4
Set-DnsClientServerAddress -InterfaceAlias Ethernet -IPAddress 172.16.0.11

# 5
Remove-NetRoute -InterfaceAlias Ethernet -DestinationPrefix 0.0.0.0/0 -Confirm:$false

# 6
New-NetRoute -InterfaceAlias Ethernet -DestinationPrefix 0.0.0.0/0 -NextHop 172.16.0.2

#7
Get-NetIPConfiguration

#8
Test-NetConnection Sisyphus