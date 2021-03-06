set-location -Path 'c:\Work\PS\WorkInProgress'
$file = Get-Content -Path '.\Trein_log_Iparix_Repaired.txt'
$newfile = 'newlog.txt'
Get-ChildItem -Path . | where-object{$_.name -eq 'newlog.txt'} | Remove-Item -Force
new-item .\$newfile

foreach($line in $file){
  
  
  if ($line -match '^Trein'){continue}
  if (($line -match '^(?:Ma|Di|Wo|Do|Vr)') -eq $false) {continue ; write-host $line }
  if($line -match '(\w\w)\s+(\d{1,2})[-_](\d{1,2})\s+(.*)' -eq $true){
      $m2 = ('0'+ $matches[2]).Substring( ('0'+$matches[2]).length -2 , 2)
      $m3 = ('0'+ $matches[3]).Substring( ('0'+$matches[3]).length -2 , 2)
      $line = $matches[1] + ';' + '2002' + '-' + $m3 + '-' + $m2 + ';' + $matches[4]
  } elseif ($line -match '(\w\w)\s+(\d{1,2})[-_](\d{1,2})-(\d{4})\s+(.*)' -eq $true){
        $m2 = ('0'+ $matches[2]).Substring( ('0'+$matches[2]).length -2 , 2)
        $m3 = ('0'+ $matches[3]).Substring( ('0'+$matches[3]).length -2 , 2)
        $line = $matches[1] + ';' + '2002' + '-' + $m3 + '-' + $m2 + ';' + $matches[5]
  } else {
    continue
  }   
 
  #Write-Host $line
  $line | Out-File -FilePath $newfile -Append 
}

$AsArray = Import-Csv -Path .\$newfile -Delimiter ";"  -Header 'DayOfWeek','Date','Description'

#controle
for ($i=0 ; $i -lt ($AsArray.Length); $i++){
  if ((($AsArray[$i].Date) -match '2002-\d{2}-\d{2}') -eq $false) {write-host $i}
}

# trimdata
for ($i=0 ; $i -lt ($AsArray.Length); $i++){
  $AsArray[$i].DayOfWeek = ($AsArray[$i].DayOfWeek).Trim()
  $AsArray[$i].Date = ($AsArray[$i].Date).Trim()
  $AsArray[$i].Description = ($AsArray[$i].Description).Trim()
  
}


$bit =  1
while( $bit -eq 1){
$bit = 0
$NewArray = @()
$NewArray += $AsArray[0].Date
for ($i=1 ; $i -lt ($AsArray.Length); $i++){
    if (($AsArray[$i].Date) -lt ($AsArray[$i-1].Date )){
        $AsArray[$i-1].Date -match '(^\d{4})'
        $prev = $matches[1]
        for($j = $i ; $j -lt ($AsArray.Length); $j++ ){
            $AsArray[$j].Date =  ($AsArray[$j].Date) -replace '\d{4}' , (1 + $prev)
            $NewArray += $AsArray[$j].Date
        } 
    $bit = 1    
    break       
    }
    $NewArray += $AsArray[$i].Date

}   
#$AsArray = $newArray
}

$AsArray # goede inhoud

# repair of dataset

<# dataset "probleem" 
Di;2002-02-28;7:35 ok
Wo;2002-02-01;7:30 ok
Do;2002-03-02;7:30 ok, bus rijdt niet
#>

#
foreach($line in $file){
 if ($line -match 'Wo\s+01-02\s+7\:30') {write-host $line}

}

# Ma;2002-03-12;7:33 ok WK VERLOREN!!  
# moet zijn Ma;2002-07-12;7:33 ok WK VERLOREN!!

<# drie records fout
2011-03-22
2012-02-23
2012-02-24
2012-02-25
2012-03-28
#>

# 2015-07-17
<# blok fout 8 records
Di;2002-09-16;7:34 ok
Wo;2002-07-17;Geen werkdag meer
Do;2002-07-18;7:34 ok
Vr;2002-07-19;7:34 ok
Ma;2002-07-22;7:34 ok
Di;2002-07-23;7:34 ok
Wo;2002-07-24;Geen werkdag meer
Do;2002-07-25;7:34 ok
Vr;2002-07-26;7:34 ok
Ma;2002-09-29;7:34 ok Ludo out
#>
