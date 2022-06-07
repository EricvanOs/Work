(Get-Culture).DateTimeFormat


$cultures = 'en-US','de-DE','fr-CA','fr-FR','ms-MY','zh-HK'

foreach ($c in $cultures){
 $culture = New-Object system.globalization.cultureinfo($c)
 $date = Get-Date -format ($culture.DateTimeFormat.ShortDatePattern)
 $longdate = Get-Date -format ($culture.DateTimeFormat.LongDatePattern)
 New-Object psobject -Property @{'name'=$culture.displayname; 'date'=$date; 'longdate'=$longdate}
}


# All Cultures
[globalization.cultureinfo]::GetCultures('allCultures')

# CultureInfo
[globalization.cultureinfo]::GetCultureInfo('en-US')

#list of static methods
[globalization.cultureinfo].GetMethods() | Select-Object Name, IsStatic -Unique

# parse a string into datetime
[DateTime]::ParseExact('02-06-2018 16:25:28', 'dd-MM-yyyy HH:mm:ss', $null)

$date = '02}06+2018 16:25:28'
([datetime]::ParseExact($date,"dd}MM+yyyy HH:mm:ss",$null))


$tdate = '05-Nov-2019'
#change it to datetime object as below
$termdate = [datetime]::ParseExact($tdate,'dd-MMM-yyyy',$null)

# display in different format
$termdate.ToString('MMM/dd/yyyy')
#or 
$termdate.ToString('MM/dd/yyyy')


# parse a string into datetime, succeeds
[DateTime]::ParseExact('02-06-2018 16:25:28', 'dd-MM-yyyy HH:mm:ss', $null)
# parse a string into datetime, fails
[DateTime]::ParseExact('02-16-2018 16:25:28', 'dd-MM-yyyy HH:mm:ss', $null)


$string = '5/22/2012 10:31'
#[DateTime]$date = new-object DateTime 1900,1,1
[DateTime]$date = new-object DateTime 1900,7,4
[dateTime]::tryParse($string, [ref][DateTime]$date)
$date

[DateTime]::Parse($string, $null)