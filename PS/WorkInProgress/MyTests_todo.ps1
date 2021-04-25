Get-Process -ComputerName 'eos','hydra' | select-object -Property machinename,ProcessName

Get-Process -ComputerName eos,hydra | select-object -Property machinename,ProcessName

$comps = eos,hydra # dit mag niet

$comps = 'eos','hydra'
Get-Process -ComputerName $comps | select-object -Property MachineName,ProcessName
# dir mag niet
$comps | Get-Process

$compsf = import-csv -Path K:\_cm\H04\Computers.csv

$compsf | Get-Process | select-object -Property machinename,ProcessName  # lijkt goed, is toch fout

[array]$compsa = import-csv -Path K:\_cm\H04\Computers.csv

$compsa | Get-Process  | select-object -Property machinename,ProcessName


[PSObject]$compsps = import-csv -Path K:\_cm\H04\Computers.csv
$compsps | Get-Process  | select-object -Property machinename,ProcessName
