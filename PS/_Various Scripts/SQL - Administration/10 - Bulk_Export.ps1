$Path = 'K:\_CM\_Various Scripts\SQL'
set-location -Path $Path 

$instanceName = 'echo.pantheon.somewhere'
$dbName = 'AdventureWorks'
$exportfile = Join-Path -Path $Path -ChildPath 'person.csv'

$query = @' 
SELECT    * FROM    Person.Address 
'@ 

Invoke-Sqlcmd -Query $query -ServerInstance $instanceName -Database $dbName | 
  Export-Csv -LiteralPath $exportfile -NoTypeInformation

# cleanup

get-item -Path $exportfile | Remove-Item