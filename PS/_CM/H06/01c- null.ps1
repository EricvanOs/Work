Set-Location -Path C:\Work\PS\Temp

New-Item -ItemType File -Name 'sample1.txt' 

# don't show output
New-Item -ItemType File -Name 'sample2.txt' | Out-Null

[void](New-Item -ItemType File -Name 'sample3.txt')

New-Item -ItemType File -Name 'sample4.txt' > $null

$null = (New-Item -ItemType File -Name 'sample5.txt')

#cleanup 
Get-Item -Path .\* -Filter "sample?.txt" | Remove-Item 