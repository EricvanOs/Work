# Write-SqlTableData belongs to the module sqlserver (not very fast, specially for csv-files when all columns are nvarchar(max))
Get-Command -Name Write-SqlTableData

Set-Location -Path 'C:\Temp\Powershell and SQL\_CM\CSVImport2SQL'

#import data

(Import-Csv -Path .\Customers.csv)| Select-Object -First 100 | Write-SqlTableData -ServerInstance eos -DatabaseName tempdb -SchemaName "dbo" -TableName "Customers" -Force


(Get-Process | Select-Object -Property Id,ProcessName,StartTime,UserProcessorTime,WorkingSet,Description)  | Write-SqlTableData -ServerInstance eos -DatabaseName tempdb -SchemaName "dbo" -TableName "Process" -Force

#test
Invoke-Sqlcmd -ServerInstance eos -Database tempdb -Query "select * from dbo.Customers" | Format-Table -AutoSize
Invoke-Sqlcmd -ServerInstance eos -Database tempdb -Query "select * from dbo.Process" | Format-Table -AutoSize

# cleanup
Invoke-Sqlcmd -ServerInstance eos -Database tempdb -Query "drop table dbo.Customers;drop table dbo.Process"


