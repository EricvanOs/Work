# foreach($file in (Get-ChildItem "\\cyg7006\Data\P&R\Reporting\Data_Sources\CustomerCare\Source\")) {
#    $newname = $file.FullName -replace '\.xlsx$', '.csv'
#    $ExcelWB = new-object -comobject excel.application
#    $Workbook = $ExcelWB.Workbooks.Open($file.FullName) 
#    $Workbook.SaveAs($newname,6)
#    $Workbook.Close($false)
#    $ExcelWB.quit()
# }

$xlsxPath = "\\cyg7006\Data\P&R\Reporting\Data_Sources\CustomerCare\Source\"
$csvPath = "\\cyg7006\Data\P&R\Reporting\Data_Sources\CustomerCare\Source\"

$xlsxFile = Get-ChildItem -Path $xlsxPath -Filter *.xlsx

$excelFile = $xlsxFile.FullName
$excelFileName = $xlsxFile.BaseName
$excelPath = $xlsxPath

Function ExportWSToCSV ($excelPath,$excelFileName, $csvLoc)
{
    $excelFile = $excelPath + $excelFileName + ".xlsx"
    $E = New-Object -ComObject Excel.Application
    $E.Visible = $false
    $E.DisplayAlerts = $false
    $wb = $E.Workbooks.Open($excelFile)
    foreach ($ws in $wb.Worksheets)
    {
        $n = $excelFileName + "_" + $ws.Name
        $ws.SaveAs($csvLoc + $n + ".csv", 6)
    }
    $E.Quit()
}


ExportWSToCSV -excelPath $excelPath -excelFileName $excelFileName -csvLoc $csvPath





