# 1 use ISE
Import-Module PSScheduledJob -UseWindowsPowerShell
Get-Command -Module PSScheduledJob 

#Cleanup
Get-Job | Remove-Job

# 2
$trigger = New-JobTrigger -Once -At (Get-Date).AddMinutes(2)

# 3
Register-ScheduledJob -Trigger $trigger -Name DemoJob -ScriptBlock { Get-EventLog -LogName Application } 

# 4
Get-ScheduledJob | Select-Object -Expand JobTriggers 

# 5
Get-ScheduledJob 
Start-Sleep -Seconds 90

# 6
Get-Job

# 7
Receive-Job -Name DemoJob

# 8
Get-Job -Name DemoJob | Remove-Job

# cleanup schedule
# zie taskscheduler-microsoft-windows-powershell-scheduledjobs
Unregister-ScheduledJob -Name DemoJob 



