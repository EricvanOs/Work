get-help Get-EventLog -ShowWindow
get-help about_CommonParameters -ShowWindow

<#
NAME
    Get-EventLog
    
SYNTAX
    Get-EventLog [-LogName] <string> [[-InstanceId] <long[]>] [-ComputerName <string[]>] [-Newest <int>] [-After <datetime>] [-Before <datetime>] 
    [-UserName <string[]>] [-Index <int[]>] [-EntryType {Error | Information | FailureAudit | SuccessAudit | Warning}] [-Source <string[]>] [-Message 
    <string>] [-AsBaseObject]  [<CommonParameters>]
    
    Get-EventLog [-ComputerName <string[]>] [-List] [-AsString]  [<CommonParameters>]

#>


# dit mag niet
Get-EventLog

# dit wel
Get-EventLog application

# beter, autonmatisch ook file completion
Get-EventLog -LogName Application

# Dit mag ook (zie tweede syntax regel)
Get-EventLog -List 

# officieel
Get-EventLog -List -AsString:$true # Get-EventLog -list -AsString:$false (dit is de default zie help; en mag derhalve weggelaten worden) 

# list geeft ook een default waarde

# conclusie alleen Parameter tussen [] --> verplichte parameter

# dit mag niet
$logs = 'Application','System'
get-eventlog -LogName $logs

#dit wel
$logs = 'Application'
get-eventlog -LogName $logs

# conclusie [-LogName] <string> geeft aan -LogName is verplicht en <string> ook verplicht maar slechts een "string"

Get-EventLog -ComputerName sisyphus,tantalus -List
# of
Get-EventLog -ComputerName sisyphus,tantalus -LogName Application

# conclusie [-ComputerName <string[]>]  Eerste [] geeft aan -computer is facultatief en string[] geeft aan meerdere "strings" zijn mogelijk