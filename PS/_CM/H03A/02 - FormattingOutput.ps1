# 1
Get-Service

# 2
Get-Service | Format-List -Property Name, Status

# 3
Get-ADComputer -Filter * -Properties OperatingSystem

# 4
Get-ADComputer -Filter * -Properties OperatingSystem | Format-Table -Property Name, OperatingSystem

# 5
Get-ADUser -Filter *

# 6
Get-ADUser -Filter * | Format-Wide -AutoSize
