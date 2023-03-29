# install-module ImportExcel

Import-Module importexcel

Get-Module -Name importexcel | Select-Object -ExpandProperty Exportedcommands

get-help set-row -Examples




$a = Import-Excel -Path C:\Tmp\Book1.xlsx 

$ExcelInfo = Get-ExcelSheetInfo -Path C:\tmp\Book1.xlsx
$WS = Import-Excel -Path C:\tmp\Book1.xlsx -WorksheetName sheet1
# Get-ExcelWorkbookInfo -Path C:\tmp\Book1.xlsx

get-range -start 1 -stop 4

Set-Column   -Column 1 -StartRow 2

# see: https://www.youtube.com/watch?v=YyAEsZG21ao&list=PL5uoqS92stXioZw-u-ze_NtvSo0k0K0kq&index=2

Set-Column -Worksheet $excelInfo.Name  -Heading "WinsToFastLaps"  -Value {"=E$row/C$row"} -Column 7 -AutoSize -AutoNameRange


################

find-module -Name *excel*


Install-Module -Name PSExcel 


get-command -Module PSexcel