dir

# beter, maak gebruik van
Get-ChildItem

# info 
Get-Alias dir

# 
New-Alias list Get-ChildItem

# 
list

# 
Get-Alias -definition Get-ChildItem

# 
Get-Command *alias*
Get-Help Set-Alias -Online # remark remove-item  OR select "Set-Alias" and CRTL+F1

Get-ChildItem alias:\

Remove-Item alias:\list

# controle
Get-Alias -definition Get-ChildItem

# niet lekker leesbaar
gps| ? pm -gt 1000 | ft -a

# Aanzienlijk beter
Get-Process | Where-Object{$_.PagedMemorySize64 -gt 1000} | Format-Table -AutoSize

# mag ook zo
Get-Process | 
Where-Object{$_.PagedMemorySize64 -gt 1000} | 
Format-Table -AutoSize

# of zo sinds ps 7
Get-Process 
 | Where-Object{$_.PagedMemorySize64 -gt 1000} 
 | Format-Table -AutoSize


<# 
dangerous! dangerous! dangerous!
Remove-Item -Path Alias:dir
Set-Alias -Name dir -Value Remove-Item 
#>

