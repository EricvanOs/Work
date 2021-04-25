# 1
Get-Service | Measure-Object

# 2
Get-ADUser -Filter * | Measure-Object

# 3
Get-Process | Measure-Object -Property VM -Sum -Average

Get-ChildItem -Path K: -Recurse | Measure-Object -Property Length -Sum -Average -Maximum -Minimum