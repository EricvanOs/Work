$ErrorActionPreference='stop'
try
{
   $teller=Read-Host "geef een getal op"
   $noemer=Read-Host "geef nog een getal op"
   $result=($teller/$noemer)  #deling door 0 /tesxt --> Terminating
   Write-Host "resultaat is $result" -ForegroundColor Yellow
   Get-Content -Path C:\PSSamples\PCtjutys.txt  #non-terminating error
   Write-Host "de rest vd code...." -ForegroundColor Green
}
catch [DivideByZeroException]
{
    Write-Host "Divide by zero exception" -ForegroundColor red
    Add-Content -Path c:\errlog.log  -Value  "Divide by zero exception at $(get-date)"
    
}
catch [System.Management.Automation.ItemNotFoundException]
{
    Write-Host "bestand niet gevonden...." -ForegroundColor red
    Add-Content -Path c:\errlog.log  -Value  "File not found at $(get-date)"
}
catch 
{ 
    write-host "error: $($error[0].Exception.GetType().fullname) "  #om typename vd exception op te halen
    Write-Host "Other exception" -ForegroundColor Red
    Add-Content -Path c:\errlog.log  -Value  "Errors occurred at $(get-date)"
}
finally
{
    Write-Host "cleaning up ..." -ForegroundColor Yellow
}