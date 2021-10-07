Get-Help Get-Process -Online
<#
Parameters
    -ComputerName <String[]>
        Specifies the computers for which this cmdlet gets active processes. The default is the local computer.
        

        Required?                    false
        Position?                    named
        Default value                None
        Accept pipeline input?       True (ByPropertyName)
        Accept wildcard characters?  false

    -FileVersionInfo <SwitchParameter>
        Indicates that this cmdlet gets the file version information for the program that runs in the process.
        

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -Id <Int32[]>
        Specifies one or more processes by process ID (PID). To specify multiple IDs, use commas to separate the IDs. To find the PID of a process, type `Get-Process`.

        Required?                    true
        Position?                    named
        Default value                None
        Accept pipeline input?       True (ByPropertyName)
        Accept wildcard characters?  false

    -IncludeUserName <SwitchParameter>
        Indicates that the UserName value of the Process object is returned with results of the command.

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -InputObject <Process[]>
        Specifies one or more process objects. Enter a variable that contains the objects, or type a command or expression that gets the objects.

        Required?                    true
        Position?                    named
        Default value                None
        Accept pipeline input?       True (ByValue)
        Accept wildcard characters?  false

    -Module <SwitchParameter>
        Indicates that this cmdlet gets the modules that have been loaded by the processes.
        

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -Name <String[]>
        Specifies one or more processes by process name. You can type multiple process names (separated by commas) and use wildcard characters. The parameter name ("Name") is optional.

        Required?                    false
        Position?                    0
        Default value                None
        Accept pipeline input?       True (ByPropertyName)
        Accept wildcard characters?  false
#>



# doesn't work
Get-ADComputer -Filter * | Get-Process
# or, thre are no processes running with those names
Get-ADComputer -Filter * | Select-Object -Property name | Get-Process 

# want to use name (from get-adcomputer) as computername in get-process
# create an extra column with correct name

Get-ADComputer -Filter * | Select-Object @{n='ComputerName';e={$_.name}}

# now a pipe into get-process

Get-ADComputer -Filter * | Select-Object @{n='ComputerName';e={$_.name}} | Get-Process


