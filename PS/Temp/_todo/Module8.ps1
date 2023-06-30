#external modules
gcm -Noun module
gcm -Module powershellget
Find-Module -Name *exchange*
find-script -Name *teams*
Install-Module -Name lazyexchangeadmin
Get-InstalledModule
$env:PSModulePath -split ";"
Get-Module -ListAvailable 
Get-Command -Module lazyExchangeAdmin


#exec policy
Get-ExecutionPolicy 
#help about_signing
Set-ExecutionPolicy AllSigned
Get-ChildItem -Path cert: -Recurse -CodeSigningCert
$cert=get-item -Path Cert:\CurrentUser\my\D93D10ED4D58A11C2B4B441FD3A2F924B181D0FC
Set-AuthenticodeSignature -Certificate $cert -FilePath C:\ps\test.ps1
Get-AuthenticodeSignature -FilePath C:\PS\test.ps1 | fl *
Get-AuthenticodeSignature -FilePath 'C:\Program Files\VMware\VMware Horizon Media Engine\V264.dll' | fl *

Set-ExecutionPolicy RemoteSigned

#construct
#Foreach-object
get-service | ForEach-Object {Write-Host $psitem.Name $psitem.Status}
#foreach construct
$svcs=get-service
#some code....
foreach ($svc in $svcs)
{
    Write-Host $svc.Name $svc.Status
}

#if..then
$svcs=get-service
foreach ($svc in $svcs)
{
    if ($svc.Status -eq 'Running')
        {Write-Host $svc.Name -ForegroundColor Green}
    else
        {Write-Host $svc.Name -ForegroundColor Red}

}

#volgorde testen !!
$score=Read-Host -Prompt "wat was je score?"
if ($score -gt 90)
    {Write-Host "excellent"}
elseif ($score -gt 75)
    {Write-Host "goed"}
elseif ($score -gt 50)
    {Write-Host "juist genoeg"}
else
    {Write-Host "niet geslaagd"}
#....
Write-Host "rest vd code"


#switch (select case in VB)
$machinenaam=read-host -Prompt "wat is de servernaam?"
switch ($machinenaam)
{
    "lon-dc1"
        {Write-Host "domain controller"
            break #om uit de switch block te springen
            }
    "lon-cl1"
        {Write-Host "client machine"}
    "lon-svr1"
        {Write-Host "member server"}
    "lon-dc1"
        {Write-Host "staat in London"}
    default    
        {Write-Host "onbekend"}
}
Write-Host "de rest vd code"
#door get-dnsclientcache om de status en type weer te geven
#C:\Windows\System32\WindowsPowerShell\v1.0\Modules\DnsClient
Get-DnsClientCache 
Get-DnsClientCache | select name, status,type

#switch met wildcard
$machinenaam=read-host -Prompt "wat is de servernaam?"
switch -Wildcard ($machinenaam)
{
    "*dc*"
        {Write-Host "domain controller"}
    "*cl*"
        {Write-Host "client machine"}
    "*svr*"
        {Write-Host "member server"}
    "lon*"
        {Write-Host "staat in London"}
    "nyc*"
        {Write-Host "staat in New York"}
    default    
        {Write-Host "onbekend"}
}
Write-Host "de rest vd code"


#regular expressions https://www.debuggex.com/
"darwin" -match "[r-z]"  #geeft true/false terug
"darwin","els","peter" -match "[r-z]"  #geeft alle matches terug
"dan" -match "[r-z]"
"darwin" -match "^d"
"darwin" -match "n$"
"darwin" -match "[a-z]{2,8}"
"lon-dc1" -match "^lon-[a-z]{2,3}[0-9]{1,2}$"



$machinenaam=read-host -Prompt "wat is de servernaam?"
switch -regex ($machinenaam)
{
    "[a-d]"
        {Write-Host "bevat letters tss a - d"}
    "^d"
        {Write-Host "begint met d"}
    "n$"
        {Write-Host "eindigt op n"}
    "^lon-[a-z]{2,3}[0-9]{1,2}$"
        {Write-Host "geldige machinenaam"}
    default    
        {Write-Host "onbekend"}
}
Write-Host "de rest vd code"


#for
1..10 |ForEach-Object {Write-Host $PSItem -ForegroundColor Cyan -BackgroundColor DarkGreen}
<#
$getal=5
$getal++
$getal+=8
$getal
#>

$sum=0
for ($i = 1; $i -le 100; $i++)
{ 
    $sum += $i    
}
$sum

#progressbar
for ($i = 1; $i -le 100; $i++)
{ 
    Write-Progress -Activity "Processing machines " -Status "machine $i" `
        -PercentComplete $i
    #code....
    Start-Sleep -Milliseconds 150
}

#do..while/until...loop 
do
{
    $pwd=Read-Host -Prompt "wat is het wachtwoord?"
    
}
while ($pwd -cne "Hello World")
Write-Host "rest vd code"





#zonder continue stappen overslaan
$sum=0
for ($i = 1; $i -le 100; $i+=3)
{ 
    $i
    $sum += $i    
}
$sum

#met continue stappen overslaan
$sum=0
for ($i = 1; $i -le 100; $i++)
{ 
    if ($i % 3 )  #veelvoud van 3 testen
    {continue   }
    else
    {$sum +=$i
    }
}
$sum




#import files
#get-content
$info=Get-Content -Path C:\procs.csv
get-member -InputObject $info
$info.Count
$info2=Get-Content -Path C:\procs.csv -ReadCount 3
$info2.Count
Get-Content -Path C:\procs.csv -Tail 2

#import-*
Import-Csv -Path C:\procs.csv 
Import-Csv -Path C:\procs.csv | gm
import-csv -Path C:\ps\IPaddressen.txt -Header IPadres 

Import-Clixml -Path C:\procs.xml
Import-Clixml -Path C:\procs.xml | gm

Compare-Object -ReferenceObject (get-process) -DifferenceObject (Import-Csv `
    -Path C:\procs.csv) -Property processname
Compare-Object -ReferenceObject (get-process) -DifferenceObject (Import-Csv `
    -Path C:\procs.csv) -Property processname -IncludeEqual -ExcludeDifferent

#JSON local file import
(get-content -Path C:\procs.json |ConvertFrom-Json ) | gm
#public Rest API
(Invoke-RestMethod -Uri http://dummy.restapiexample.com/api/v1/employees -Method Get |
    select  -expandproperty data ) | gm



#LAB --> ASCII codes omzetten nr letters
$pasword=""
for ($i = 1; $i -le 30; $i++)
{ 
    $nr=get-random -Minimum 32 -Maximum 4000
    $karakter=([char]$nr)
    $pasword += $karakter
}
Write-Host "nieuw wachtwoord is " -NoNewline
Write-Host  $pasword -ForegroundColor Yellow

