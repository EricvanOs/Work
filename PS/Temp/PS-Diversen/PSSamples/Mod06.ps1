#namespaces
Get-WmiObject -List -Namespace root -Recurse | Select-Object __namespace -Unique


#classes
Get-WmiObject -list -Namespace root/cimv2
get-wmiobject -list -Namespace root/cimv2 -Class win32_service 
get-wmiobject -list -Namespace root/cimv2 -Class win32_service | 
    Select-Object -ExpandProperty Methods
get-wmiobject -list -Namespace root/cimv2 -Class win32_service | 
    Select-Object -ExpandProperty properties


Get-CimClass -Namespace root/CIMV2
Get-CimClass -Namespace root/CIMV2 -ClassName Win32_NetworkAdapter | Select-Object -ExpandProperty cimclassmethods
Get-CimClass -Namespace root/CIMV2  -ClassName Win32_NetworkAdapter| 
    Select-Object -ExpandProperty cimclassproperties | Select-Object name

#instance/object info
Get-WmiObject -Class win32_service 
Get-WmiObject -Class win32_service | get-member
Get-WmiObject -Class win32_service | select name,startmode,startname,installdate

Get-CimInstance -ClassName Win32_NetworkAdapter | gm
Get-CimInstance -ClassName Win32_NetworkAdapter | Select-Object name,MACAddress,Manufacturer

#query/filter WQL--> wildcard % ipv *
Get-WmiObject -Namespace root/cimv2 -Class win32_service -Filter  "name ='spooler'"  #geen -eq gebruiken!!!
Get-CimInstance -Namespace root/cimv2 -ClassName Win32_NetworkAdapter -Filter "name like '*Intel*'"  #fout
Get-CimInstance -Namespace root/cimv2 -ClassName Win32_NetworkAdapter -Filter "name like '%Intel%'"
#alias niet ondersteund in WQL
Get-CimInstance -ClassName Win32_Process  | gm  #processname is een AliasProperty
Get-CimInstance -ClassName Win32_Process  -Filter "Processname like '%power%'" #foutmelding
Get-CimInstance -ClassName Win32_Process  -Filter "name like '%power%'"
#filteren via Where-object --> Powershell syntax
Get-CimInstance -ClassName win32_process | Where-Object processname -like '*power*'

#query parameter
Get-CimInstance -Namespace root/CIMV2 -Query "select * from win32_networkadapter where name like '%intel%'"

#remote PC benaderen
Get-WmiObject -Namespace root/cimv2 -Class win32_share -ComputerName 192.168.92.19 -Credential administrator

#WINRM error , geen domain hier
#voor Win7/8/10 clients : enable-PSRemoting uitvoeren (of via GPO)
Get-CimInstance -Namespace root/cimv2 -ClassName win32_share -ComputerName 192.168.92.19 
set-item WSMan:\localhost\Client\TrustedHosts -Value *  #voor winrm service naar niet domain-joined PCs
$s=New-CimSession -ComputerName 192.168.92.19 -Credential administrator
Get-CimInstance -Namespace root/cimv2 -ClassName win32_networkadapterconfiguration -CimSession $s


#dingen aanpassen
Get-CimClass -ClassName win32_service | Select-Object -ExpandProperty cimclassmethods

Get-Ciminstance -ClassName win32_service -Filter "name ='spooler'" |
    Invoke-CimMethod -MethodName StartService
#info over parameters zoeken --> welke waarden kan startmode aannemen?
Get-CimClass -ClassName win32_service | Select-Object -ExpandProperty cimclassmethods |
    Where-Object name -eq Changestartmode | select -ExpandProperty parameters|
    Select-Object -ExpandProperty Qualifiers | Where-Object Name -eq Valuemap |
    Select-Object -ExpandProperty vALUE

#korter
(Get-CimClass -ClassName win32_service ).CimClassMethods.Where({$_.name -eq 'Changestartmode'}).parameters.qualifiers.where({$_.name -eq 'Valuemap'}).value

#uitvoeren van methode
Get-Ciminstance -ClassName win32_service -Filter "name ='spooler'" |
    Invoke-CimMethod -MethodName ChangeStartMode -Arguments @{Startmode='Manual'}


#nieuwe cmdlets zijn vaak wrappers rond CIMqueries
Get-NetAdapter | gm  #typename verwijst naar CIM

#zoeken naar classes
Get-CimClass -Namespace root\cimv2 -ClassName *processor*
get-cimclass -Namespace root\cimv2 | Where-Object cimclassmethods -like "*ChangeStartmode*"
get-cimclass -Namespace root\cimv2 | Where-Object cimclassproperties -like "*MACaddress*"
get-cimclass -Namespace root\cimv2 | Where-Object cimclassproperties -like "*temperature*"
    






