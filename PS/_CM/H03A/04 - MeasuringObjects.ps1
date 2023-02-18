# number of services
Get-Service | Measure-Object

# number of users
Get-ADUser -Filter * | Measure-Object

# sizes
Get-Process | Measure-Object -Property VM -Sum -Average

Get-ChildItem -Path C:\Work\PS\Temp -Recurse | Measure-Object -Property Length -Sum -Average -Maximum -Minimum