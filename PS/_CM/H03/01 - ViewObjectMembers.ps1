# 1
Get-Service | Get-Member

# 2
Get-Process | Get-Member

# 3
Get-ChildItem | Get-Member

# 4
Get-ADUser -Filter * | Get-Member

# 5
Get-ADUser -Filter * -Properties * | Get-Member


#6
Get-ADUser -Filter * -Properties sid,surname | Get-Member

#7 letop format breekt alles
Get-ADUser -Filter * -Properties sid,surname | Format-Table -AutoSize | Get-Member
