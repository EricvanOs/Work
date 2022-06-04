(Get-Culture).DateTimeFormat


$cultures = 'en-US','en-GB','fr-CA','fr-FR','ms-MY','zh-HK'

foreach ($c in $cultures){
 $culture = New-Object system.globalization.cultureinfo($c)
 $date = Get-Date -format ($culture.DateTimeFormat.ShortDatePattern)
 New-Object psobject -Property @{'name'=$culture.displayname; 'date'=$date}
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
