Set-Location -Path 'C:\Work\PS\_Various Scripts\CSVImport2SQL'
$sqlserver = 'echo.pantheon.somewhere'
$database = 'tempdb'

. .\out-datatable.ps1  #let op dot-sourcing (extra dot)

. .\Add-SqlTable.ps1

. .\write-datatable.ps1

$dt = .\Get-DiskSpaceUsage.ps1 | Out-DataTable

Add-SqlTable -ServerInstance $sqlserver -Database $database -TableName diskspaceFunc -DataTable $dt  #create table, still empty

Write-DataTable -ServerInstance $sqlserver -Database $database -TableName 'diskspaceFunc' -Data $dt  # fill table

Invoke-Sqlcmd -ServerInstance $sqlserver -Database $database -Query 'Select * from diskspaceFunc' | format-table -AutoSize # read table

# nogmaals
$dt = Import-Csv -Path .\Customers.csv | Out-DataTable

Add-SqlTable -ServerInstance $sqlserver -Database $database -TableName Customers -DataTable $dt  #create table, still empty

Write-DataTable -ServerInstance $sqlserver -Database $database -TableName 'Customers' -Data $dt  # fill table

Invoke-Sqlcmd -ServerInstance $sqlserver -Database $database -Query 'Select * from Customers' | format-table -AutoSize


# cleanup
Invoke-Sqlcmd -ServerInstance $sqlserver -Database $database -Query "drop table diskspaceFunc;drop table Customers"

