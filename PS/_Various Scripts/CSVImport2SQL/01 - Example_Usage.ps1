# Install-Module -Name Write-ObjectToSQL 

Set-Location -Path 'C:\Work\PS\_Various Scripts\CSVImport2SQL'

.\Get-DiskSpaceUsage.ps1 | Write-ObjectToSQL -Server echo -Database tempdb -TableName ProcessTable

Import-Csv -Path .\Customers.csv | Write-ObjectToSQL -Server echo -Database tempdb -TableName Customers

#test 
Invoke-Sqlcmd -ServerInstance echo.pantheon.somewhere -Database tempdb -Query "select * from ProcessTable" | Format-Table -AutoSize
Invoke-Sqlcmd -ServerInstance echo -TrustServerCertificate -Database tempdb -Query "select count(*) as cnt from Customers" 

# cleanup
Invoke-Sqlcmd -ServerInstance echo -TrustServerCertificate -Database tempdb -Query "drop table ProcessTable;drop table Customers"
