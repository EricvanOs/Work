# https://github.com/PowerShell/GraphicalTools

# Install-Module Microsoft.PowerShell.ConsoleGuiTools


Set-Location -Path 'C:\Work\PS\_Various Scripts\ConsoleGridView'

Get-Process | Out-ConsoleGridView

$P = Get-Process | Out-ConsoleGridView -OutputMode Single
$P

($A = Get-ChildItem -Path $pshome -Recurse) | Out-ConsoleGridView
$A

Get-Process | Out-ConsoleGridView  | Export-Csv -Path .\ProcessLog.csv

#cleanup
Get-Item -Path .\ProcessLog.csv | Remove-Item
