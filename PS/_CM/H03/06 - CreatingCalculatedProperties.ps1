# want to have extra column, if uptime is larger then 7 days ShouldReboot = 'Yes' else 'No'
get-uptime | Select-Object TotalDays, @{n='ShouldReboot'; e={If((get-uptime).Days -ge 7){'Yes'}else{'No'} }}

# voorwerk            
$a = 'Pantheon\Marc'
$a.Substring(9,2)
$a.Substring(9,$a.Length - 9)

# extra column Name
get-process  -IncludeUserName   
| Where-Object{$_.UserName -like 'PANTHEON*' }
| Select-Object  -First 5 -Property ProcessName , UserName, @{n='Name';e={($_.UserName).Substring(9,($_.UserName).Length - 9)}}


# Look at AD
Get-ADuser -Filter * -Properties whenCreated

# sort on property
Get-ADuser -Filter * -Properties whenCreated | Sort-Object -Property whenCreated -Descending

#3
[datetime]$startdate = '2021-10-03'
[datetime]$enddate   = '2021-10-05'
New-TimeSpan -Start $startdate -End $enddate
(New-TimeSpan -Start $startdate -End $enddate).Days

Get-ADUser -Filter * -Properties whenCreated | Sort-Object -Property whenCreated -Descending |  
            Select-Object -Property Name,@{n='Account age (days)';e={(New-TimeSpan -Start $PSItem.whenCreated -End (get-date)).Days}} 



