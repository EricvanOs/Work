$dc = New-PSSession -ComputerName sisyphus
$dc
$dc | Get-Member

get-module -ListAvailable -PSSession $dc

get-module -ListAvailable -PSSession $dc | Where-Object{$_.name -like '*share*'}

Import-Module -PSSession $dc -Name SmbShare -Prefix DC   # prefix op command is handig om verwarring te voorkomen

get-command get-dc*

Get-DCSmbShare  # shares op sisyphus

Get-DCSmbShare | Get-Member


Import-Module -PSSession $dc -Name DNSServer #zonder prefix
get-command get-dns*

Get-DnsServer

get-help Get-DnsServer -online

show-DnsServerCache | Get-Member

Show-DnsServerCache | where-object{$_.recordtype -eq 'A' -and $_.hostname -like '*asus*'}

$site = '*asus*'
Show-DnsServerCache | where-object{$_.recordtype -eq 'A' -and $_.hostname -like $site}  # werkt ook met parameters

Get-PSSession | format-list

Remove-PSSession -Session $dc

Get-PSSession | Remove-PSSession

