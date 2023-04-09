$s = New-PSSession -ComputerName Sisyphus
Invoke-Command -Session $s -ScriptBlock {$d = [DateTime]::Today.AddDays(-90);
Get-ADComputer -Filter 'PasswordLastSet -ge $d' -SearchBase 'dc=pantheon,dc=somewhere'} -AsJob -JobName 'ListOfComputers'

# job kan even duren

while ((Get-Job -Name 'ListofComputers').State  -ne 'Completed')
{
    Start-Sleep -Milliseconds 500
}
    
$j = Get-Job -Name 'ListofComputers'
    
$results = $j | Receive-Job

