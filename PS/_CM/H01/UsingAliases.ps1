# 1
dir

# 2 beter maak gebruik van
Get-ChildItem

# 3
Get-Alias dir

# 4
New-Alias list Get-ChildItem

# 5
list

# 6
Get-Alias -definition Get-ChildItem

# 7
Get-Command *alias*
Get-Help Set-Alias -Online # remark remove-item

Get-ChildItem alias:\

Remove-Item alias:\list

# 8 controle
Get-Alias -definition Get-ChildItem

# niet lekker leesbaar
gps| ? pm -gt 1000 | ft -a

# Aanzienlijk beter
Get-Process | Where-Object{$_.PagedMemorySize64 -gt 1000} | Format-Table -AutoSize