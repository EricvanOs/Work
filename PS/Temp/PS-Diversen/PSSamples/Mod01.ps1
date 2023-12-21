$PSVersionTable
$Host.PrivateData.ErrorBackgroundColor="yellow"

Get-CommandCommand
Get-Command|Measure-Object #aantal cmdlets

#zoeken naar cmdlets
Get-Verb
Get-Command -Verb get
Get- -noun service*
Get-Command -Name *serv*
Get-Command -Name *file* -Module Dism

#gebruik parameters verklaren
get-service 
get-service -Name Spooler
get-service -Name spooler,winrm,wuauserv
get-service BITS
Get-Service -Name Spooler -DependentServices
Get-Service -Name Spooler -RequiredServices
get-service -Include win*m* -Exclude winrm

get-service -DisplayName 'ActiveX Installer (AxInstSV)'


get-help Get-Service  #roept de eerste keer Update-Help op !! probleem met Win10 10.0.18362
update-help -Force  #foreceert correcte installatie
get-help Get-Service -Full

#common parameter Verbose  --> altijd beschikbaar
stop-service -Name Spooler -Verbose
Get-Service -ComputerName 192.168.92.17 -Name Spooler
#afkorting parameter namen gebruiken
Get-Service -C 192.168.92.17 -N  Spooler
Get-Service Spooler -C 192.168.92.17


get-help get-eventlog -Full
Get-EventLog  #verplichte parameter mee opgeven!
get-eventlog -LogName System  
get-eventlog -LogName System,Security # niet toegelaten
get-eventlog -LogName System,security  
Get-EventLog -Message '*error*' -LogName Security -Newest 10
Get-EventLog -LogName System -EntryType Error 


#zoeken nr cmdlet
Get-Command -Verb new
Get-Command -Verb new -Module storage
Get-Command -Noun process*
Get-Command -Name *job*
Get-Command -Name get*job*
get-help Get-Job 
get-help Get-Job -Online
get-help Get-Job -ShowWindow
get-help Get-Job -Parameter state

#about_  help files
get-help about_signing
get-help about_parameters

#modules tonen
Get-Module -ListAvailable
Get-Module
Get-NetAdapter   #netadapter module autom geladen
Import-Module WindowsUpdate
Get-Command -Module WindowsUpdate
Get-Command -Module NetAdapter

#externe modules gebuiken
Get-Command -module powershellget
#forceren om TLS1.2 te gebruiken
[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12
find-module -Name *365*  #vraagt 1se keer om NUGET provider te installeren
install-module -Name 365Tools 
Get-Module -ListAvailable
Get-InstalledModule
Get-Command -Module 365Tools

#alias
get-alias
dir
Get-ChildItem
gci -Path C:\Windows\System32
dir /s   #fout!!!  --> alleen PS parameters gebruiken
ping 8.8.8.8
Test-Connection 8.8.8.8 
ipconfig 
Get-NetIPConfiguration

