# Install-Module -Name Write-ObjectToSQL 

Set-Location -Path 'C:\Temp\Powershell and SQL\_CM\CSVImport2SQL'

.\Get-DiskSpaceUsage.ps1 | Write-ObjectToSQL -Server eos -Database tempdb -TableName ProcessTable

Import-Csv -Path .\Customers.csv | Write-ObjectToSQL -Server eos -Database tempdb -TableName Customers

#test 
Invoke-Sqlcmd -ServerInstance eos -Database tempdb -Query "select * from ProcessTable" | Format-Table -AutoSize
Invoke-Sqlcmd -ServerInstance eos -Database tempdb -Query "select * from Customers" | Format-Table -AutoSize


# cleanup

Invoke-Sqlcmd -ServerInstance eos -Database tempdb -Query "drop table ProcessTable;drop table Customers"