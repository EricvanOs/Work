$computer = 'deucalion'

Get-WmiObject -ComputerName $computer -Class Win32_NetworkAdapter | 
    Where-Object { $_.Speed -ne $null -and $_.MACAddress -ne $null } | 
    Format-Table -Property NetConnectionID,@{Label='Speed(GB)'; Expression = {$_.Speed/1GB}}