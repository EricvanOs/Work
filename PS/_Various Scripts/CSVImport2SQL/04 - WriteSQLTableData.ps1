# Write-SqlTableData belongs to the module sqlserver (not very fast, specially for csv-files when all columns are nvarchar(max))
Get-help -Name Write-SqlTableData -ShowWindow

Set-Location -Path 'C:\Work\PS\_Various Scripts\CSVImport2SQL'
$sqlserver = 'echo.pantheon.somewhere'
$database = 'tempdb'

#import data

(Import-Csv -Path .\Customers.csv)| Select-Object -First 100 | 
    Write-SqlTableData -ServerInstance $sqlserver -DatabaseName $database -SchemaName "dbo" -TableName "Customers" -Force


(Get-Process | Select-Object -Property Id,ProcessName,StartTime,UserProcessorTime,WorkingSet,Description)  | 
Write-SqlTableData -ServerInstance $sqlserver -DatabaseName $database -SchemaName "dbo" -TableName "Process" -Force

#test
Invoke-Sqlcmd -ServerInstance $sqlserver -Database $database -Query "select * from dbo.Customers" | Format-Table -AutoSize
Invoke-Sqlcmd -ServerInstance $sqlserver -Database $database -Query "select * from dbo.Process" | Format-Table -AutoSize

# cleanup
Invoke-Sqlcmd -ServerInstance $sqlserver -Database $database -Query "drop table dbo.Customers;drop table dbo.Process"


