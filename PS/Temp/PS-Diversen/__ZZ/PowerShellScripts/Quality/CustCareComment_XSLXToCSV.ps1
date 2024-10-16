Set-PSDebug -Trace 0
C:
$xlsxPath = '\\cyg7006\Data\P&R\Reporting\Data_Sources\Quality\Source\CustCareComment\'
$csvPath = '\\cyg7006\Data\P&R\Reporting\Data_Sources\Quality\Source\CSV\CustCareComment\'
$xlsxFile = Get-ChildItem -Path $xlsxPath -Filter *.xlsx
 
#Test-Path '\\cyg7006\data\P&R\reporting\Data_Sources\Quality\source\CustCareComment' 
#Test-Path $xlsxPath


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

#Start-Sleep -Seconds 3
ExportWSToCSV -excelPath $excelPath -excelFileName $excelFileName -csvLoc $csvPath


# move xlsx to Archive 
 
rename-item -path $excelFile -newname  (($xlsxFile.BaseName) + '_' + (Get-Date).tostring("yyyy-MM-dd") + '.xlsx')


Set-Location "\\cyg7006\Data\P&R\Reporting\Data_Sources\Quality\Source\CustCareComment\"

Move-Item -Path .\*.xlsx -Destination "\\cyg7006\Data\P&R\Reporting\Data_Sources\Quality\Source\Archive\"

