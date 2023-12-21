<#
.SYNOPSIS
    zoeken naar bestanden van een bepaalde grootte of groter
.DESCRIPTION
    je kan path, minsize en recurse ofgeven....
.PARAMETER path
    path moet drive of folder zijn
.PARAMETER minsize
    minsize van bestand  vb 10 , 100mb, 1GB
.EXAMPLE
    scanlargeFiles.ps1 -path c:\ -minsize 100MB -recurse

    zoekt alle bestanden groter dan 100 MB
.EXAMPLE
    scanlargeFiles.ps1 -path c:\ -minsize 100

    zoekt alle bestanden groter dan 100 MB, alleen in de root vd C:\ schijf
#>
function Scan-largeFiles
{
    [cmdletbinding()]
    param([string]$path="c:\",[int]$minSize=100MB,[switch]$recurse,[bool]$fullname)
    #origineel
    #Get-ChildItem -Path c:\ -Recurse | Where-Object length -gt 100MB

    if (Test-Path $path)
    {
        if ($recurse)
        {
             if ($fullname -eq $true)
            {Get-ChildItem -Path $path -Recurse  | Where-Object length -gt $minSize | select fullname}
             else
            {Get-ChildItem -Path $path -Recurse | Where-Object length -gt $minSize }
        }
    
        else
    
        {
            if ($fullname -eq $true)
            {Get-ChildItem -Path $path | Where-Object length -gt $minSize|select Fullname}
            else
            {Get-ChildItem -Path $path | Where-Object length -gt $minSize}
        }
    }
    else
    {
        Write-Host "$path bestaat niet...."
    }
}


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
function Scan-IPRange
{

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





}

#Scan-largeFiles -path c:\windows -minSize 100MB -recurse
#Scan-largeFiles -path C:\PSSamples -minSize 1MB -recurse

#Scan-IPRange -subnetrange 192.168.92 -beginIPaddress 10 -eindIPaddress 20
#Scan-IPRange -subnetrange 192.168.92 -beginIPaddress 140 -eindIPaddress 150


