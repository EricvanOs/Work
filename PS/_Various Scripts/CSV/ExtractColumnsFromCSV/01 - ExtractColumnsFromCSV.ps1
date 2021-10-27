$path = 'K:\_Various Scripts\CSV\ExtractColumnsFromCSV'
Set-Location -Path $path


$ColumnList = 'lastname','email'

$fileInput = Import-CSV test3.csv


$fileInput | Select-Object -Property $ColumnList | export-csv result.csv -notype

Get-Content -Path .\result.csv

## cleanup 
get-item -Path result.csv | Remove-Item