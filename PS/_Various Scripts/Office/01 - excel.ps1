# install-module ImportExcel

Import-Module importexcel

Get-Module -Name importexcel | Select-Object -ExpandProperty Exportedcommands

get-help set-row -Examples

Set-Location -Path 'C:\Work\PS\_Various Scripts\Office'

# export data to excel
$data = ConvertFrom-Csv @"
Region,State,Units,Price
West,Texas,927,923.71
North,Tennessee,466,770.67
East,Florida,520,458.68
East,Maine,828,661.24
West,Virginia,465,053.58
North,Missouri,436,235.67
South,Kansas,214,992.47
North,North Dakota,789,640.72
South,Delaware,712,508.55
"@

$data | Export-Excel .\salesData.xlsx

# read data from excel
$data = Import-Excel .\salesData.xlsx
$data

# Add chart to spreadsheet
$data = ConvertFrom-Csv @"
Region,State,Units,Price
West,Texas,927,923.71
North,Tennessee,466,770.67
East,Florida,520,458.68
East,Maine,828,661.24
West,Virginia,465,053.58
North,Missouri,436,235.67
South,Kansas,214,992.47
North,North Dakota,789,640.72
South,Delaware,712,508.55
"@

$chart = New-ExcelChartDefinition -XRange State -YRange Units -Title "Units by State" -NoLegend

$data | Export-Excel .\salesData.xlsx -AutoNameRange -ExcelChartDefinition $chart -Show

#Pivot table
$data = ConvertFrom-Csv @"
Region,State,Units,Price
West,Texas,927,923.71
North,Tennessee,466,770.67
East,Florida,520,458.68
East,Maine,828,661.24
West,Virginia,465,053.58
North,Missouri,436,235.67
South,Kansas,214,992.47
North,North Dakota,789,640.72
South,Delaware,712,508.55
"@

$data | Export-Excel .\salesData.xlsx -AutoNameRange -Show -PivotRows Region -PivotData @{'Units'='sum'} -PivotChartType PieExploded3D

# cleanup

Get-ChildItem -Path .\salesData.xlsx | Remove-Item



# other cmdlets

get-range -start 1 -stop 4

Set-Column   -Column 1 -StartRow 2

# see: https://www.youtube.com/watch?v=YyAEsZG21ao&list=PL5uoqS92stXioZw-u-ze_NtvSo0k0K0kq&index=2

Set-Column -Worksheet $excelInfo.Name  -Heading "WinsToFastLaps"  -Value {"=E$row/C$row"} -Column 7 -AutoSize -AutoNameRange


################

find-module -Name *excel*


Install-Module -Name PSExcel 


get-command -Module PSexcel