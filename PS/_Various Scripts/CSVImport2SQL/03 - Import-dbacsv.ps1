# Import-DbaCsv is a cmdlet in module dbatools

get-command -name Import-DbaCsv 

Set-Location -Path 'C:\Temp\Powershell and SQL\_CM\CSVImport2SQL'

Import-DbaCsv -Path .\Customers.csv -SqlInstance eos -Database tempdb -Table mine -Schema test -AutoCreateTable

#test
Invoke-Sqlcmd -ServerInstance eos -Database tempdb -Query "select * from test.mine" | Format-Table -AutoSize


# cleanup
Invoke-Sqlcmd -ServerInstance eos -Database tempdb -Query "drop table test.mine;drop schema test"
