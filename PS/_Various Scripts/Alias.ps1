<#

# dangerous! dangerous! dangerous!
Remove-Item -Path Alias:dir
Set-Alias -Name dir -Value Remove-Item

#>


# leesbaarheid !!!

gps | sort WS -des | select -fi 10 

Get-Process | Sort-Object -Property  WS -Descending  | Select-Object -First 10 