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

$Path = 'K:\_Various Scripts\CSV\MergeCSV'
set-location -Path $Path




# mag ook, en is eleganter

@(Import-Csv test1.csv) + @(Import-Csv test2.csv) | Export-Csv joined.csv

# cleanup


Get-Item -Path output.csv,Joined.csv | Remove-Item