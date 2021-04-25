$running = get-service | Where-Object {$_.status -eq 'running'} 

$running | Select-Object -Property Name   # met header, en nog steeds een object
$running | Select-Object -Property Name | Get-Member

 $running | Select-Object -ExpandProperty Name # zonder header, nu als array
($running | Select-Object -ExpandProperty Name).GetType()

 $running.name
($running.name).GetType()  # ook een array

#############
Get-Service -Name winmgmt | Select-Object -Property *

Get-Service -Name winmgmt| Select-Object -Property DependentServices

Get-Service -Name winmgmt| Select-Object -ExpandProperty DependentServices

(Get-Service -Name winmgmt).DependentServices

(Get-Service -Name winmgmt).DependentServices.DisplayName


