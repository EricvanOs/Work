# 1
Get-ADuser -Filter * -Properties whenCreated

# 2
Get-ADuser -Filter * -Properties whenCreated | Sort-Object -Property whenCreated -Descending

#3
[datetime]$startdate = '2021-10-03'
[datetime]$enddate   = '2021-10-05'
New-TimeSpan -Start $startdate -End $enddate
(New-TimeSpan -Start $startdate -End $enddate).Days

Get-ADUser -Filter * -Properties whenCreated | Sort-Object -Property whenCreated -Descending |  
            Select-Object -Property Name,@{n='Account age (days)';e={(New-TimeSpan -Start $PSItem.whenCreated -End (get-date)).Days}} 



