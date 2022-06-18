Get-WinEvent -ListLog * | select-object -Property *

Clear-EventLog -LogNAME 'Microsoft-Windows-WMI-Activity/Operational'

 Remove-EventLog


 function clear-all-event-logs ($computerName="localhost")
    {
    $logs = get-eventlog -computername $computername -list | foreach {$_.Log}
    $logs | foreach {clear-eventlog -comp $computername -log $_ }
    get-eventlog -computername $computername -list
    }

    clear-all-event-logs  $computername 
    

    $path='c:\windows\System32\Winevt\Logs\Microsoft-Windows-RemoteAssistance%4Operational.evtx'


Get-WinEvent -ListLog * | select-object -Property * | where-object{$_.logname -like '*powershell*'}

Clear-EventLog  'Windows PowerShell'

Clear-EventLog $path

