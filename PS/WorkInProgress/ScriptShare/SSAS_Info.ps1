[Reflection.Assembly]::LoadWithPartialName(“Microsoft.AnalysisServices”)

$ServerName = New-Object Microsoft.AnalysisServices.Server

$ServerName | Get-Member

$ServerName.connect('selene')

$ServerName


foreach($database in $ServerName.databases)
{foreach($cube in $database.Cubes)
{$cube | Select Name, LastProcessed}}