<#
.SYNOPSIS
    simple IPscanner
.DESCRIPTION
    IP scanner om een bepaalt network af te lopen
.PARAMETER subnetrange
    de IPrange die je wil scannen via ping

.EXAMPLE
  IPscanner -subnetrange 192.168.92 -beginIPaddress 1 -eindIPaddress 254
  scant de hele iprange 192.168.92 af vanaf 192.168.92.1 tot  192.168.92.254
#>
#param([string]$subnetrange="192.168.92",[int]$beginIPaddress=1,[int]$eindIPaddress=254)
[cmdletbinding()]
param([parameter(Mandatory=$true)]
[string]$subnetrange,
[int]$beginIPaddress=1,
[int]$eindIPaddress=254)

Write-Verbose "deze range wordt gescand : $subnetrange.$beginIPaddress tot $subnetrange.$eindIPaddress" -OutBuffer 4
for ($ip=$beginIPaddress ; $ip -le $eindIPaddress ;$ip++)
{
    Write-Host "$subnetrange.$ip :" -NoNewline
    Test-Connection -ComputerName "$subnetrange.$IP" -Count 1 -Quiet 
}


