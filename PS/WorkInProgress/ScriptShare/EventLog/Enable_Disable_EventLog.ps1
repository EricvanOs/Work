$LogName = 'Microsoft-Windows-TerminalServices-RemoteConnectionManager/Admin'

Get-WinEvent -ListLog $LogName | Format-List is*

 
$log = New-Object System.Diagnostics.Eventing.Reader.EventLogConfiguration $logName
$log.IsEnabled=$false
$log.SaveChanges()

Get-WinEvent -ListLog $LogName | Format-List is*