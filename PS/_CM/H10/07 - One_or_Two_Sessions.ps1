$ComputerName = 'Sisyphus'

# two separate sessions
Invoke-Command -ComputerName $ComputerName -ScriptBlock { $x = 'BITS' }
Invoke-Command -ComputerName $ComputerName -ScriptBlock { Get-Service | Where-Object{$_.Name -eq "$x"} }


# Just one session
$Session = New-PSSession -ComputerName $ComputerName 
Invoke-Command -Session $Session -ScriptBlock { $x = 'BITS' }
Invoke-Command -Session $Session -ScriptBlock { Get-Service | Where-Object{$_.Name -eq "$x"} }

$Session | Remove-PSSession


