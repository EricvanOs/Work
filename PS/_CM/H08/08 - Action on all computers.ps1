#search for all (recently) active computers

$ses = new-PSSession -ComputerName sisyphus
$comps = invoke-command -session $ses -ScriptBlock{
    $DaysInactive = 90  
    $time = (Get-Date).Adddays(-($DaysInactive)) 
    $aa = Get-ADComputer -Filter {LastLogonTimeStamp -gt $time} -Properties LastLogonTimeStamp,Description -SearchBase 'dc=pantheon,dc=somewhere' | 
    Where-Object{$_.Enabled -eq 'True'} | where-object{$_.Description -ne 'Failover cluster virtual network name account' } 
    $aa.DNSHostName 
}
get-PSSession  | Remove-PSSession

#use output (list of computers)

$ErrorActionPreference = 'SilentlyContinue'  # better use try and catch
foreach ($comp in $comps){
  Write-host $comp
  $ses = New-PSSession -ComputerName $comp
  Invoke-Command -Session $ses -ScriptBlock {
      # Your commands on remote machine
      }
  Get-PSSession  | Remove-PSSession
} 
$ErrorActionPreference = 'Continue'

