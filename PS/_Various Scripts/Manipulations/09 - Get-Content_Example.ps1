$lines = Get-Content k:\_cm\test.txt   #reads file as a collection of lines
$lines.Count

ForEach ($line in $lines){
  $line -replace 't','x' | Out-File k:\_cm\new.txt -Append
}

# small files 

$lines = Get-Content k:\_cm\test.txt -Raw  #reads everything (the file) as 1 line 
$lines.Count

$lines -replace 't','x' | Out-File k:\_cm\new2.txt 


# cleanup
Get-Item -Path k:\_cm\new*.txt | Remove-Item 