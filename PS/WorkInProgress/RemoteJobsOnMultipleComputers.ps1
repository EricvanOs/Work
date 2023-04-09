$s = New-PSSession -ComputerName Sisyphus
Invoke-Command -Session $s -ScriptBlock {$d = [DateTime]::Today.AddDays(-90);
Get-ADComputer -Filter 'PasswordLastSet -ge $d' -SearchBase 'dc=pantheon,dc=somewhere'} -AsJob -JobName 'ListOfComputers'

# job kan even duren

    
$j = Get-Job -Name 'ListofComputers' | Wait-Job
    
$results = $j | Receive-Job

$comps = $results.name


#############################

$s = New-PSSession -ComputerName $comps

Invoke-Command -Session $s -ScriptBlock{
      Test-Path -Path 'c:\tools' 
} -Asjob -Jobname 'AllComps'

# job kan even duren

while ((Get-Job -Name 'AllComps').State  -ne 'Completed')
{
    Start-Sleep -Milliseconds 500
}
    
$j = Get-Job -Name 'AllComps'
    
$results = $j | Receive-Job




#####################
# Een veel tragere oplossing met try and catch

$Options =  New-PSSessionOption  -OpenTimeout 1000
$ErrorActionPreference ='stop'
foreach ($comp in $comps){
  Write-host $comp
  try{
  $ses = New-PSSession -ComputerName $comp -SessionOption $Options
  Invoke-Command -Session $ses -ScriptBlock {
        Test-Path -Path 'c:\tools'
      }
    get-PSSession  | Remove-PSSession
  } 
  catch{} 
} 
$ErrorActionPreference ='continue'


