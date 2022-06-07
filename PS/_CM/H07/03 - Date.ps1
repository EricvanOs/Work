#Place the current date in a variable
$date = Get-Date

#View date properties
$date
$date.Hour
$date.Minute
$date.Day
$date.DayOfWeek
$date.Month
$date.Year

#or 
Get-Date | Format-List

#Add or subtract time from a date
$date.AddDays(100)
$date.AddDays(-60)

#Long and short formats
$date.ToLongDateString()
$date.ToShortDateString()
$date.ToLongTimeString()
$date.ToShortTimeString()

# difference between two dates
$diff = New-TimeSpan -Start $date -End $date.AddDays(13.25) 
$diff
$diff.TotalDays
$diff.TotalHours

# from file-import
$Date = '2020-09-07T13:35:08.4780000Z'  #UTC-time
[DateTime]$Date  # localtime (Daylight saving - Spring Forward, Summer Time) +2 hours

$Date = '2020-02-07T13:35:08.4780000Z'  #UTC-time
[DateTime]$Date #localtime (Winter Time) +1 hour

#TimeZone
[TimeZoneInfo]::Local
[System.TimeZone]::CurrentTimeZone.GetUtcOffset([datetime]::Now).TotalHours
[System.TimeZone]::CurrentTimeZone.GetUtcOffset([datetime]$Date).TotalHours

# 
[string]$sDate = '2022-06-07 11:26:02 AM +07:00' 
$sDate
[datetime]$sDate #my localtime
([datetime]$sDate).ToLocalTime()

([datetime]$sDate).ToUniversalTime() # converted to UCT


