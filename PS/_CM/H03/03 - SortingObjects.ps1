# 1
Get-Process

# 2
Get-Process | Sort-Object -Property ID

# 3
Get-Service | Sort-Object -Property Status 
# internally, with zero (stopped) comes before 1 (running).

# 4
Get-Service | Sort-Object -Property Status -Descending

# 5
Get-WinEvent -LogName Security -MaxEvents 10

# 6
Get-WinEvent -LogName Security -MaxEvents 10 | Sort-Object -Property TimeWritten

# 7
Get-ADUser -Filter * | Sort-Object -Property SurName | Format-Wide -AutoSize





