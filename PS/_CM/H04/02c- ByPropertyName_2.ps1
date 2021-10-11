Get-Help Get-Process -Online
<#
Parameters
-Id
Specifies one or more processes by process ID (PID). To specify multiple IDs, use commas to separate the IDs. To find the PID of a process, type Get-Process.

Type:	Int32[]
Aliases:	PID
Position:	Named
Default value:	None
Accept pipeline input:	True
Accept wildcard characters:	False

-Name
Specifies one or more processes by process name. You can type multiple process names (separated by commas) and use wildcard characters. The parameter name ("Name") is optional.

Type:	String[]
Aliases:	ProcessName
Position:	0
Default value:	None
Accept pipeline input:	True
Accept wildcard characters:	True

#>

# test 
Start-Process -FilePath Notepad -WindowStyle Hidden
Get-Process notepad
$id = (Get-Process notepad).id
Get-Process $id   # fail because parameter id is a "named" parameter 
Get-Process -Id $id


# doesn't work
Get-ADComputer -Filter * | Get-Process
# or, there are no processes running with those names
Get-ADComputer -Filter * | Select-Object -Property name | Get-Process 

# want to use name (from get-adcomputer) as computername in get-process
# create an extra column with correct name

Get-ADComputer -Filter * | Select-Object @{n='ComputerName';e={$_.name}}

# now a pipe into get-process

Get-ADComputer -Filter * | Select-Object @{n='ComputerName';e={$_.name}} | Get-Process


