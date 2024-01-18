function Merge-CSVFiles { 
[cmdletbinding()] 
param( 
    [string[]]$CSVFiles, 
    [string]$OutputFile 
) 
$Output = @(); 
foreach($CSV in $CSVFiles) { 
    if(Test-Path -Path $CSV) { 
        
        $FileName = [IO.Path]::GetFileName($CSV) 
        $temp = Import-CSV -Path $CSV | Select-Object *, @{Expression={$FileName};Label='FileName'} 
        $Output += $temp 

        } else { 
            Write-Warning "$CSV : No such file found" 
        } 
    } 
$Output | Export-Csv -Path $OutputFile -NoTypeInformation 
Write-Output "$OutputFile successfully created" 

}

$Path = 'C:\Work\PS\_Various Scripts\CSV\MergeCSV'
set-location -Path $Path

Merge-CSVFiles -CSVFiles "$Path\test1.csv" , "$Path\test2.csv" -OutputFile "$Path\output.csv"
Get-Content -Path .\test1.csv
Get-Content -Path .\test2.csv
Get-Content -Path .\output.csv

# mag ook, en is eleganter
@(Import-Csv test1.csv) + @(Import-Csv test2.csv) | Export-Csv .\merged.csv
Get-Content -Path .\test1.csv
Get-Content -Path .\test2.csv
Get-Content -Path .\merged.csv

# cleanup
Get-Item -Path .\output.csv, .\merged.csv | Remove-Item