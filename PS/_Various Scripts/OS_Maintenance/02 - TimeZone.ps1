$cred = Get-Credential  'pantheon\administrator'
Enter-PSSession -ComputerName eos -Credential $cred
Set-TimeZone -Name 'W. Europe Standard Time' 
Exit-PSSession 