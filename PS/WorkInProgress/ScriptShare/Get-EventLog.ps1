Start-Process -FilePath notepad.exe -WindowStyle Minimized


Get-Process | where-object{$_.Name -like '*notepad*'} | stop-process

get-help Get-Eventlog -online


Get-EventLog -LogName Application

get-eventlog -List -Verbose

get-date

$a = Get-Date
$a | Get-Member
$a.Day
$a.AddDays(-4)

Get-EventLog -LogName Application -After (Get-Date).AddDays(-4)   # alle events uit Application EventLog van de laatste 4 dagen


# methods, properties, etc

Get-EventLog -LogName Application  | Get-Member


$b | get-member
$b.source 
$b.Count

$b | where-object{$_.source -like '*skype*'} | Format-Table -Property *   # Alle properties van 't System.Diagnostics object cq Get-EventLog (object)

$c =$b | where-object{$_.source -like '*skype*'} | Format-Table -Property *

$b | where-object{$_.source -like '*skype*'} | Get-Member  #nog steed Get-EventLog (object)
$c | Get-Member #merk op dat 't oorspronkelijke object weg is

Get-Process | Format-Table -Property * | Get-Member

get-process |  Out-GridView

get-process | Format-Table -Property * |Out-GridView #onzin



get-service | get-member  # TypeName: System.ServiceProcess.ServiceController

get-command -ParameterType System.ServiceProcess.ServiceController # all commands which accept TypeName: System.ServiceProcess.ServiceController as input

show-command

$Host| show-object  # powershellcookbook

save-help #to usb stick voor in cursussen
save-help -DestinationPath \\pantheon\data\Misc\Powershell-Help

1Gb

get-help  #in show-command en dan Category

show-object; Get-PSDrive

Out-GridView
get-command -module oneget

psedit