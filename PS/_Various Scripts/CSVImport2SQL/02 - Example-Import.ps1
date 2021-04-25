Set-Location -Path 'C:\Temp\Powershell and SQL\_CM\CSVImport2SQL'

. .\out-datatable.ps1  #let op dot-sourcing (extra dot)

. .\Add-SqlTable.ps1

. .\write-datatable.ps1

$dt = .\Get-DiskSpaceUsage.ps1 | Out-DataTable

Add-SqlTable -ServerInstance 'eos' -Database 'tempdb' -TableName diskspaceFunc -DataTable $dt  #create table, still empty

Write-DataTable -ServerInstance 'eos' -Database 'tempdb' -TableName 'diskspaceFunc' -Data $dt  # fill table

Invoke-Sqlcmd -ServerInstance 'eos' -Database 'tempdb' -Query 'Select * from diskspaceFunc' | format-table -AutoSize # read table

# nogmaals
$dt = Import-Csv -Path .\Customers.csv | Out-DataTable

Add-SqlTable -ServerInstance 'eos' -Database 'tempdb' -TableName Customers -DataTable $dt  #create table, still empty

Write-DataTable -ServerInstance 'eos' -Database 'tempdb' -TableName 'Customers' -Data $dt  # fill table

Invoke-Sqlcmd -ServerInstance 'eos' -Database 'tempdb' -Query 'Select * from Customers' | format-table -AutoSize


# cleanup
Invoke-Sqlcmd -ServerInstance eos -Database tempdb -Query "drop table diskspaceFunc"
Invoke-Sqlcmd -ServerInstance eos -Database tempdb -Query "drop table Customers"
