[System.Net.ServicePointManager]::SecurityProtocol =[System.Net.SecurityProtocolType]::Tls12
Find-Module *sushi* -Repository PSgallery
Install-Module -Name PSSushibar -RequiredVersion 1.3
Set-PSRepository -Name PSgallery -InstallationPolicy Trusted
Get-InstalledModule
Get-Command -Module PSSushiBar
Start-SushiBar
Stop-SushiBar

$env:PSModulePath -split ";"

#signing van script
help about_signing
#signing cert aanmaken
New-SelfSignedCertificate -Type CodeSigningCert `
    -CertStoreLocation Cert:\CurrentUser\my -Subject "demo signing cert"

Get-ChildItem -Path cert:\ -Recurse -CodeSigningCert
#signing van script
$cert=get-item Cert:\CurrentUser\my\469F546D1B729CA6F72D0B215F8DCD405A565C66
Set-AuthenticodeSignature -FilePath C:\PSSamples\test.ps1 -Certificate $cert  #unknownerror
    #selfsignedcert moet in de ROOT staan!!
Move-Item -Path $cert.PSPath -Destination Cert:\CurrentUser\Root
Set-AuthenticodeSignature -FilePath C:\PSSamples\test.ps1 -Certificate $cert   #Valid !
#nu kan je script testen als executionpolicy op AllSigned staat (default is RemoteSigned)
#Set-ExecutionPolicy AllSigned

#constructs

#region  Foreach
#foreach-object cmdlet
get-service | ForEach-Object {Write-Host $psitem.name  $psitem.Status}

#foreach construct
$svcs=get-service
foreach ($svc in $svcs)
{
    Write-Host $svc.name  $svc.Status
}
#endregion

#region If...
$svcs =get-service
foreach ($svc in $svcs)
{
    if ($svc.Status -eq 'running')
    {
        Write-Host $svc.name  -ForegroundColor green
    }
    else
    { 
        Write-Host $svc.name  -ForegroundColor red
    }
}

#vergelijken
$score = Read-Host -Prompt "wat was je score?"
if ($score -gt 90)
{Write-Host "uitstekend"}
elseif ($score -gt 75)
{Write-Host "goed"}
elseif ($score -gt 50)
{Write-Host "juist geslaagd"}
else
{Write-Host "Niet geslaagd"}
Write-Host "de rest vd code..."

#endregion


#switch intern gebruikt
Get-DnsClientCache
Get-DnsClientCache | select name,type,status
#C:\Windows\System32\WindowsPowerShell\v1.0\Modules\DnsClient\DnsConfig.Format.ps1xml  --> zorgt voor getal-->tekst conversie

ii $PSHOME

#region Switch
$servernaam=read-host -Prompt "wat is de machinenaam?"
switch ($servernaam)
{
    "lon-dc1"
        {write-host "Domain Controller"
        #break
        }
    "lon-svr1"
        {write-host "member server"}
    "lon-cl1"
        {write-host "client"}
    "lon-dc1"
        {write-host "in London"}
    default
        {write-host "onbekend"}
}
Write-Host "de rest vd code...."



#endregion


#region Switch met wildcard
$servernaam=read-host -Prompt "wat is de machinenaam?"
switch -Wildcard ($servernaam)
{
    "*dc*"
        {write-host "Domain Controller"}
    "*svr*"
        {write-host "member server"}
    "*cl*"
        {write-host "client"}
    "lon-*"
        {write-host "in London"}
     "ams-*"
        {write-host "in Amsterdam"}
    default
        {write-host "onbekend"}
}
Write-Host "de rest vd code...."
#endregion


#pattern matching (regular expressions)
"darwin" -match "[a-f]"
"2300" -match "[0-9]{4}"
"300" -match "[0-9]{4}"
"300354564" -match "[0-9]{4}"
"darwin" -match "^d"
"darwin" -match "n$"
"darwin","ben","marc" -match "n$"
"lon-dc1"  -match "lon-[a-z]{2,3}[0-9]{1,2}"
"blon-dc1545"  -match "lon-[a-z]{2,3}[0-9]{1,2}"  #niet correct patroon
"blon-dc1545"  -match "^lon-[a-z]{2,3}[0-9]{1,2}$"  #niet correct patroon
"ams-dc15"  -match "^(lon|ams)-[a-z]{2,3}[0-9]{1,2}$"  #niet correct patroon



#region Switch met wildcard
$servernaam=read-host -Prompt "wat is de machinenaam?"
switch -regex ($servernaam)
{
   "[a-g]"
        {Write-Host "bevcat letters uit a-g range"}
   "^d"
        {Write-Host "begint met d"}
   "^(lon|ams)-[a-z]{2,3}[0-9]{1,2}$"
        {Write-Host "geldige machine naam"}
    default
        {write-host "onbekend"}
}
Write-Host "de rest vd code...."
#endregion


#region For
$sum=0  #initialisatie

for ($i = 1; $i -le 100; $i++)
{ 
       $sum += $i
}
Write-Host "resultaat: $sum"
#alternatief:   1..100| foreach{$sum+=$psitem}


#arrays doorlopen
$getallen = @(654,448,8798,4898,81,6,7946,1649,91,698,79,668,768798,41)
for ($j = 0; $j -le $getallen.GetUpperBound(0) ; $j++)
{ 
       $sum2 += $getallen[$j]
}
$sum2

#endregion

#region progressbar
for ($i = 1; $i -le 100; $i++)
{ 
      Write-Progress -Activity "PC inventarisen" -Status "PC $i" -PercentComplete $i -id 1
      for ($j = 1; $j -le 100; $j++)
        { 
              Write-Progress -Activity "PC$i inventarisen" -Status "$j" -PercentComplete $j -ParentId 1
              
        }
      #Start-Sleep -Milliseconds 150
}


#endregion


#region do... while/until

do
{
    $pwd=Read-Host -Prompt "Wachtwoord?" 
}
while ($pwd -ne "Alsjeblief")
Write-Host "Welkom"



#endregion


#region Continue in block

$sum=0  #initialisatie

for ($i = 1; $i -le 100; $i++)
{ 
    if (($i % 5) -eq 0)
    { $sum += $i}
    else
    { continue}
}
$sum

#endregion


#region import files
$inhoud=Get-Content -Path C:\pslog.log -ReadCount 5
$inhoud[0]
Get-Content -Path C:\pslog.log -Tail 10 -ReadCount 5 

#csv
(Get-Content -Path C:\procs.csv)[2]  | gm   #niet ideaal!
Import-Csv -Path C:\procs.csv | Sort-Object ID | SELECT-object processname,id,vm,pm
Import-Csv -Path C:\procs.csv |gm

#custom csv zonder header
Import-Csv -Path C:\PSSamples\PCs.txt -Header "machinenaam","locatie","afdeling" |gm
Import-Csv -Path C:\PSSamples\PCs.txt -Header "machinenaam","locatie","afdeling" |Sort-Object afdeling
#hoeveel kolommen? : ((Get-Content -Path C:\PSSamples\PCs.txt)[0]  -split ",").Length


#XML
Import-Clixml -Path C:\procs.xml  | Where-Object id -gt 5000 | Sort-Object -Property id
Import-Clixml -Path C:\procs.xml  | gm

#JSON
get-content -Path C:\procs.json|  ConvertFrom-Json 

#rest API
#oldskool
(Invoke-WebRequest -Uri https://newgnjxtvk.execute-api.eu-west-1.amazonaws.com/dev/videos |
    Select-Object  -ExpandProperty content ) | ConvertFrom-Json | select -ExpandProperty files
#korter
((Invoke-WebRequest -Uri https://newgnjxtvk.execute-api.eu-west-1.amazonaws.com/dev/videos).content |convertfrom-json).files
#beter voor RESTAPI
(Invoke-RestMethod -Uri https://newgnjxtvk.execute-api.eu-west-1.amazonaws.com/dev/videos).files

<#andere demo URL's
https://reqres.in/
https://dummy.restapiexample.com/
https://gorest.co.in/
#>

#endregion

#LAB uitbreiding ex 4
for ($i=1;$i -lt 3000;$i++)
{
    
    write-host ("{0,5}" -f  "$i`:") -NoNewline
    Write-Host ("{0,3}" -f [char]$i) -ForegroundColor Yellow -NoNewline
    if (($i % 10) -eq 0)
    {Write-Host "| " }
    else
    {Write-Host "| " -NoNewline}
}





