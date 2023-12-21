#networking
Get-Command -Module NetAdapter
Get-Command -Module netTCPIP
Get-Command -Name Get-NetIPAddress

Get-NetIPAddress
Get-NetIPAddress -AddressFamily IPv4
Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet

Get-NetRoute

Get-DnsClientCache
Get-DnsClientServerAddress

Get-NetFirewallRule -DisplayName "*file and print*sharing*icmpv4*out*"


#testen
#ping
Test-Connection -ComputerName 8.8.8.8  #standaard 4 pakketjes
Test-Connection -ComputerName 8.8.8.8 -Count 1 -Quiet  # 1 pakeet, alleen resultaat

#tracert
Test-NetConnection -ComputerName 8.8.8.8
Test-NetConnection -ComputerName 40.69.88.149 -Port 80 
Test-NetConnection -ComputerName 40.69.88.149 -Port 8080 
Test-NetConnection -ComputerName 8.8.8.8 -TraceRoute 


