$Path = 'C:\Work\PS\_Various Scripts\Powershell-Excel\Sample - Superstore.xls'

$Excel = New-Object -ComObject Excel.Application 

$Workbook = $Excel.Workbooks.Open($Path)

$workSheet = $Workbook.Sheets.Item(1)
$WorkSheet.Name

$Found = $WorkSheet.Cells.Find('Nebraska')

$BeginAddress = $Found.Address(0,0,1,1)
$BeginAddress

$found.row


## cleanup
$workbook.close()
$Excel.Quit()

[void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($Excel)

Remove-Variable excel 
Remove-Variable Workbook

[gc]::Collect()
[gc]::WaitForPendingFinalizers()

Get-Process | Where-Object{$_.Name -like "*excel*"} | Stop-Process


