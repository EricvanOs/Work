Set-Location -Path 'C:\Work\PS\_CM\H07'

$path = '.\users.csv'
$csv = Import-Csv -Path $path

# add additional empty column 
$newcsv = $csv  | Add-Member -MemberType NoteProperty 'Available' -Value $null -PassThru

$newcsv

# set value(s)
$newcsv | Where-Object{$_.Department -eq 'IT'} | ForEach-Object{$_.Available = 'Yes'} 
$newcsv