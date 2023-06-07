$instanceName = 'echo.pantheon.somewhere'
$dbName = 'AdventureWorks'
# create here-string
$query = @"
Select top(10) * FROM Person.Address where city like 'bot%'
"@
$fileName = 'C:\Temp\ResultsFromPassThrough.csv'
#export query results to CSV
Invoke-Sqlcmd -Query $query -ServerInstance $instanceName -Database $dbName |
Export-Csv -LiteralPath $fileName -NoTypeInformation

# cleanup

Get-Item -Path $fileName | Remove-Item