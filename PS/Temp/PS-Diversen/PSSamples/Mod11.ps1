Get-CimInstance -ClassName Win32_NTLogEvent
#local job
Start-Job -ScriptBlock {Get-CimInstance -ClassName Win32_NTLogEvent}
Get-Job
Receive-Job -id 10 -Keep
get-job -id 8 |  fl *
get-job -id 9 |  fl *
Get-Job -HasMoreData $false -State Completed  | Remove-Job
#alternatief
Receive-Job -id 10 -AutoRemoveJob -Wait
get-job
Receive-Job -id 15 | gm


#remoting job
$remoteS=New-PSSession -ComputerName 192.168.92.19,192.168.92.21
Invoke-Command -ScriptBlock {get-process} -Session $remoteS -AsJob
Get-Job -id 12 |fl *
Get-Job -id 13 |fl *
Receive-Job -id 12 
get-job

#CIM/WMI job
Get-wmiobject -Class Win32_NTLogEvent -AsJob
Receive-Job -id 17 
get-job


#scheduledTasks
Get-Command -noun *Task*
Get-Command -Module ScheduledTasks
$TaskT=New-ScheduledTaskTrigger -At (get-date).AddSeconds(20) -Once
$TaskA=New-ScheduledTaskAction -Execute notepad.exe -Argument C:\svc.txt 
$taskS =New-ScheduledTaskSettingsSet -DisallowDemandStart -AllowStartIfOnBatteries 
Register-ScheduledTask -TaskPath \Darwin\ -TaskName MyCoolTask -Action $TaskA -Settings $taskS -Trigger $TaskT 

Get-ScheduledTask -TaskName XblGameSavetask | fl *
Get-ScheduledTask -TaskName XblGameSavetask | Select-Object -ExpandProperty Actions
Get-ScheduledTask -TaskName XblGameSavetask | Select-Object -ExpandProperty triggers
(Get-ScheduledTask -TaskName XblGameSavetask).triggers.repetition
(Get-ScheduledTask -TaskName XblGameSavetask).Settings
(Get-ScheduledTask -TaskName XblGameSavetask).Principal

#scheduled job
Get-Command -Module PSScheduledJob
$JobT= New-JobTrigger -At (get-date).AddMinutes(1) -Once
$jobO = New-ScheduledJobOption -ContinueIfGoingOnBattery -WakeToRun
Register-ScheduledJob -ScriptBlock {get-process} -Name MyProcessJob `
    -Trigger $JobT -ScheduledJobOption $jobO 
Get-ScheduledJob
Get-ScheduledJob -Id 1 | fl *
(Get-ScheduledJob -Id 1).JobTriggers

get-job  #toont scheduledjobs ook NA uitvoer
#resultaat op locale PC:
#C:\Users\Administrator\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\MyProcessJob\Output
Receive-Job -Name MyProcessJob



