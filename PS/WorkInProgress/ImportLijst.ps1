import-module sqlserver

$path = '\\pantheon\data\Misc\StripLijsten'
$instanceName = 'clio'
$dbName = 'Comics'

$Lijsten = Get-ChildItem -Path $path -File -Name *.csv

Set-Location -Path $path

foreach ($lijst in $lijsten){
    
$FullPath = "'" + (Join-Path -Path $path -ChildPath $lijst).ToString()  + "'"
$query = @"
BULK INSERT comics.landingzone.lijst
   FROM $FullPath
   WITH
      (  
		 FIRSTROW=2
         ,FIELDTERMINATOR ='|'
         , ROWTERMINATOR ='\n'
      );
"@

Invoke-Sqlcmd -Query $query -ServerInstance $instanceName -Database $dbName 
}


get-comman

$tbl = Import-Csv -Path $lijst -Delimiter '|' | Select-Object -Property Naam:,Nummer:,Reeks:,Map:

$FullPath = "'" + (Join-Path -Path $path -ChildPath $lijst).ToString()  + "'"


$query = @"
BULK INSERT comics.landingzone.lijst
   FROM $FullPath
   WITH
      (  
		 FIRSTROW=2
         ,FIELDTERMINATOR ='|'
         , ROWTERMINATOR ='\n'
      );
"@


