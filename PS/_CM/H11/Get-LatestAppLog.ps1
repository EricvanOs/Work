## Define the log file
$logDir = 'C:\Work\PS\temp'
$logFile = "$logDir\AppLog_$(Get-Date -format 'yyyy-mm-dd_hh-mm-ss-tt').xml"

## Get the ten latest application log events
Get-WinEvent -LogName application -MaxEvents 10 |
Export-CliXml $logFile -Force