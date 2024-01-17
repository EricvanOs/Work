# Import-DbaCsv is a cmdlet in module dbatools
get-help Import-DbaCsv -ShowWindow

Set-Location -Path 'C:\Work\PS\_Various Scripts\CSVImport2SQL'
$sqlserver = 'echo.pantheon.somewhere'
$database = 'tempdb'

Import-DbaCsv -Path .\Customers.csv -SqlInstance $sqlserver -Database $database -Table mine -Schema test -AutoCreateTable

#test
Invoke-Sqlcmd -ServerInstance $sqlserver -Database $database -Query "select * from test.mine" | Format-Table -AutoSize

# cleanup
Invoke-Sqlcmd -ServerInstance $sqlserver -Database $database -Query "drop table test.mine;drop schema test"
