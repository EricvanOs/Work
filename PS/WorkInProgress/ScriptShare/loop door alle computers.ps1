#search for all (recently) active computers

$ses = new-PSSession -ComputerName sisyphus
$result = invoke-command -session $ses -ScriptBlock{
    $DaysInactive = 90  
    $time = (Get-Date).Adddays(-($DaysInactive)) 
    $aa = Get-ADComputer -Filter {LastLogonTimeStamp -gt $time} -Properties LastLogonTimeStamp,Description -SearchBase 'dc=pantheon,dc=somewhere' | 
    Where-Object{$_.Enabled -eq 'True'} | where-object{$_.Description -ne 'Failover cluster virtual network name account' } 
    $aa.DNSHostName 
}
get-PSSession  | Remove-PSSession

#use output (list of computers)
$comps = $result

$ErrorActionPreference = 'SilentlyContinue'  # oplossen mbv try and catch

foreach ($comp in $comps){
  Write-host $comp
  $ses = New-PSSession -ComputerName $comp
  Invoke-Command -Session $ses -ScriptBlock {
      schtasks.exe /delete /TN "QuoteOfDay" /F;
      schtasks.exe /delete /TN "Mythology" /F
      }
  get-PSSession  | Remove-PSSession
} 

foreach ($comp in $comps){
  Write-host $comp
  $ses = New-PSSession -ComputerName $comp
  Invoke-Command -Session $ses -ScriptBlock {
     Remove-Item -Path 'C:\Utils\BGInfo\Quote.vbs'
     Remove-item -Path 'C:\Utils\BGInfo\Mythology.vbs'
     Remove-item -Path 'C:\Utils\BGInfo\Generate_txt.ps1'
      }
  get-PSSession  | Remove-PSSession
} 