# PS7

<#
# Get-LatestAppLog.ps1

## Define the log file
$logDir = 'C:\Work\PS\temp'
$logFile = "$logDir\AppLog_$(Get-Date -format 'yyyy-mm-dd_hh-mm-ss-tt').xml"

## Get the ten latest application log events
Get-WinEvent -LogName application -MaxEvents 10 |
Export-CliXml $logFile -Force
#>


# Create a new task action
$taskAction = New-ScheduledTaskAction `
    -Execute 'powershell.exe' `
    -Argument '-File C:\Work\PS\_CM\H11\Get-LatestAppLog.ps1'
$taskAction


# Create a new trigger (now plus 2 minutes)
$taskTrigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(2)
$taskTrigger

# Register the new PowerShell scheduled task

# The name of your scheduled task.
$taskName = "ExportAppLog"

# Describe the scheduled task.
$description = "Export the 10 newest events in the application log"

# Register the scheduled task
Register-ScheduledTask `
    -TaskName $taskName `
    -Action $taskAction `
    -Trigger $taskTrigger `
    -Description $description


    # get info
Get-ScheduledTaskInfo -TaskName ExportAppLog

# start by hand
# Start-ScheduledTask -TaskName ExportAppLog

# cleanup
Get-ScheduledTask -TaskName ExportAppLog | Unregister-ScheduledTask -Confirm:$false
Get-ChildItem -Path C:\work\PS\Temp\  | Where-Object{$_.name -like "AppLog_*"} | Remove-Item
