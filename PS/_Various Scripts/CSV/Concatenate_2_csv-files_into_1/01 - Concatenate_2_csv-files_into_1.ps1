$path = 'K:\_Various Scripts\CSV\Concatenate_2_csv-files_into_1'
Set-Location -Path $path

$file1 = Import-CSV -LiteralPath test1.csv
$file2 = Import-CSV -LiteralPath test2.csv

$i = 0
$file1 | ForEach-Object{

  $_ | Add-Member -type NoteProperty -name email -value $file2[$i].email
  $i++

}

$file1 | Export-CSV -LiteralPath result.csv -notype


## cleanup 

get-item -Path result.csv | Remove-Item
