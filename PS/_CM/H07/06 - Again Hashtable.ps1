##
$comps = 'echo','hydra'

Get-Process -ComputerName $comps | Sort-Object id | 
  Select-Object -Property MachineName,ProcessName -First 5

$comps | Get-Process  # gaat fout

#hash table definitie aanmaken
$prop = @{n='ComputerName';e={$PSItem}}

#dan gebruiken
$comps | Select-Object -Property $prop | Get-Process  | Sort-Object id | 
  Select-Object -Property ProcessName -First 5

# mag ook zo
Get-Process -ComputerName $comps  | Sort-Object id | 
  Select-Object -Property MachineName,ProcessName -First 5

# andere opbouw als input file
$comps = 'echo,hydra'
Get-Process -ComputerName ($comps -split ',') | Sort-Object id | 
  Select-Object -Property MachineName,ProcessName -First 5