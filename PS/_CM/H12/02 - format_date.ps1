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


