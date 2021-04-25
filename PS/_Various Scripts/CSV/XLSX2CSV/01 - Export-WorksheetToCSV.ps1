Function Export-WorksheetToCSV{
<#
.SYNOPSIS
Converts all xlsx-worksheets to csv-files.
.DESCRIPTION
Used for converting xslx-worksheets to csv-files
.PARAMETER ExcelPath
Path where xlxs-file resides.
.PARAMETER ExcelFileName
Name of xlsx-file
.PARAMETER CSVPath
Path where csv-files will be saved
.EXAMPLE
Export-WorksheetToCSV -ExcelPath C:\Temp -ExcelFileName OurFile -CSVPath C:\Temp\CSV
An excel-file resides in c:\temp with a name OurFile.xlsx (no extension needed when calling the function.
The resultset (one or more csv-files) will be saved in c:\Temp\CSV
#>

    Param(
        [string]$ExcelPath,
        [string]$ExcelFileName,
        [string]$CSVPath
    )

    $ExcelFile = (Join-Path -Path $path -ChildPath $ExcelFileName) + '.xlsx'
    $E = New-Object -ComObject Excel.Application
    $E.Visible = $false
    $E.DisplayAlerts = $false
    $wb = $E.Workbooks.Open($ExcelFile)
    foreach ($ws in $wb.Worksheets)
    {
        $n = $ExcelFileName + "_" + $ws.Name
        $ws.SaveAs((Join-Path -Path $CSVPath -ChildPath $n) + '.csv', 6)
    }
    $E.Quit()
}


# test

$path = 'K:\_Various Scripts\CSV\XLSX2CSV'
Set-Location -Path $path

Export-WorksheetToCSV -ExcelPath $path -ExcelFileName OurFile -CSVPath "$Path\CSV"

get-help Export-WorksheetToCSV -Examples