# no module needed

$Path = 'C:\Work\PS\_Various Scripts\Powershell-Excel\Sample - Superstore.xls'

$Excel = New-Object -ComObject Excel.Application 

$Workbook = $Excel.Workbooks.Open($Path)

$workSheet = $Workbook.Sheets.Item(1)
$WorkSheet.Name

$Found = $WorkSheet.Cells.Find('Nebraska')

$BeginAddress = $Found.Address(0,0,1,1)
$BeginAddress

$found.row

$workSheet | Get-Member

$workSheet.rows(23).Value2
# row 23
# 22	CA-2016-137330	12/9/2016	12/13/2016	Standard Class	KB-16585	Ken Black	Corporate	United States	Fremont	Nebraska	68025	Central	OFF-AR-10000246	Office Supplies	Art	Newell 318	19.46	7	0	5.0596


[pscustomobject]@{
    WorkSheet = $Worksheet.Name
    Column = $Found.Column
    Row =$Found.Row
    Text = $Found.Text
    Address = $BeginAddress
}

# all orders from the sam address
Do {
    $Found = $WorkSheet.Cells.FindNext($Found)
    $Address = $Found.Address(0,0,1,1)
    If ($Address -eq $BeginAddress) {
        BREAK
    }
    [pscustomobject]@{
        WorkSheet = $Worksheet.Name
        Column = $Found.Column
        Row =$Found.Row
        Text = $Found.Text
        Address = $Address
    }                 
} Until ($False)

#region function to search in excel file
Function Search-Excel {
    [cmdletbinding()]
    Param (
        [parameter(Mandatory)]
        [ValidateScript({
            Try {
                If (Test-Path -Path $_) {$True}
                Else {Throw "$($_) is not a valid path!"}
            }
            Catch {
                Throw $_
            }
        })]
        [string]$Source,
        [parameter(Mandatory)]
        [string]$SearchText
        #You can specify wildcard characters (*, ?)
    )
    $Excel = New-Object -ComObject Excel.Application
    Try {
        $Source = Convert-Path $Source
    }
    Catch {
        Write-Warning "Unable locate full path of $($Source)"
        BREAK
    }
    $Workbook = $Excel.Workbooks.Open($Source)
    ForEach ($Worksheet in @($Workbook.Sheets)) {
        # Find Method https://msdn.microsoft.com/en-us/vba/excel-vba/articles/range-find-method-excel
        $Found = $WorkSheet.Cells.Find($SearchText) #What
        If ($Found) {
            # Address Method https://msdn.microsoft.com/en-us/vba/excel-vba/articles/range-address-property-excel
            $BeginAddress = $Found.Address(0,0,1,1)
            #Initial Found Cell
            [pscustomobject]@{
                WorkSheet = $Worksheet.Name
                Column = $Found.Column
                Row =$Found.Row
                Text = $Found.Text
                Address = $BeginAddress
            }
            Do {
                $Found = $WorkSheet.Cells.FindNext($Found)
                $Address = $Found.Address(0,0,1,1)
                If ($Address -eq $BeginAddress) {
                    BREAK
                }
                [pscustomobject]@{
                    WorkSheet = $Worksheet.Name
                    Column = $Found.Column
                    Row =$Found.Row
                    Text = $Found.Text
                    Address = $Address
                }                 
            } Until ($False)
        }
        Else {
            Write-Warning "[$($WorkSheet.Name)] Nothing Found!"
        }
    }
    $workbook.close($false)
    [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$excel)
    [gc]::Collect()
    [gc]::WaitForPendingFinalizers()
    Remove-Variable excel -ErrorAction SilentlyContinue
}
#endregion

# a search
Search-Excel -Source $Path -SearchText Nebraska | Format-Table


## cleanup, Important!!
$workbook.close()
$Excel.Quit()

[void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($Excel)

Remove-Variable excel 
Remove-Variable Workbook

[gc]::Collect()
[gc]::WaitForPendingFinalizers()

Get-Process | Where-Object{$_.Name -like "*excel*"} | Stop-Process




