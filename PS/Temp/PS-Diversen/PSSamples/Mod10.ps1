get-service -ComputerName 192.168.92.19
get-process -ComputerName 192.168.92.19  #remote registry service moet draaien!
get-service -Name *reg*

Get-Command  -ParameterName computername,cimsession  #niet alle cmdlets ondersteunen dit

#1-1 remoting
#enable-psremoting uitvoeren op client PCs, of via GPO
#set-item wsman:\localhost\client\trustedhost -value <IPaddress>
$s1 =New-PSSession -ComputerName 192.168.92.21 -Credential administrator
$s1
enter-PSSession -Session $s1
#volgende 3 cmds worden remote uitgevoerd
Get-NetIPConfiguration
Get-Process
$localvar="hello World"
Exit-PSSession
Get-PSSession
Enter-PSSession -Name session1
#variabele terug ophalen
$localvar
Exit-PSSession
Remove-PSSession -Name session1


#1-many remoting
$s2=New-PSSession -ComputerName 192.168.92.19,192.168.92.21 -Credential administrator 
$s2
Get-PSSession
Invoke-Command -Session $s2 -ScriptBlock {Get-EventLog -LogName Application  -Newest 10}
#oppassen voor plaats {} !!!
Invoke-Command -Session $s2 -ScriptBlock {Get-EventLog -LogName Application} | 
    Where-Object  entrytype -eq error  # locaal gefilterd
Invoke-Command -Session $s2 -ScriptBlock {Get-EventLog -LogName Application | 
    Where-Object  entrytype -eq error }  #op remote PCs filter uitgevoerd

#variabele doorsturen
$svcnaam="Bits"
get-service -Name $svcnaam
Invoke-Command -ComputerName 192.168.92.19 -ScriptBlock {get-service -Name $svcnaam}  #geeft alles terug
Invoke-Command -ComputerName 192.168.92.19 -ScriptBlock {get-service -Name $using:svcnaam}  #geeft alles terug

get-service | gm
Invoke-Command -ComputerName 192.168.92.19 -ScriptBlock {get-service }  | gm










