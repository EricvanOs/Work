# Local Job
Start-Job -ScriptBlock { Get-ChildItem -Path C:\ -Recurse } -Name LocalDir

# Remote Job
Invoke-Command -ScriptBlock { Get-EventLog -LogName Security -Newest 100 } -ComputerName hydra,erebus -AsJob -JobName RemoteLogs

# 3
Get-Job 

# 4
Get-Job -Name LocalDir | Stop-Job

# 5
Receive-Job  -Name LocalDir

# 6
Remove-Job -Name LocalDir

# 7
Wait-Job -Name RemoteLogs
Get-Job 
#letop ook childjobs
Get-Job -IncludeChildJob

# 8
$id = Get-Job -Name RemoteLogs -IncludeChildJob | Where-Object{$_.location -eq 'hydra'} | Select-Object -ExpandProperty ID

# 9
Get-Job -ID $id | Receive-Job -Keep 

# include all childjobs
Receive-Job -Name RemoteLogs
Receive-Job -Name RemoteLogs  # nu is die leeg

# test and remove job
Get-Job -Name RemoteLogs  # HasMoreData -> false

Remove-Job -Name RemoteLogs

Get-Job 

# CIM and WMI in a job via start-job  (local or remote)

Start-Job -ScriptBlock{Get-CimInstance -ComputerName hydra -ClassName Win32_ComputerSystem} -Name 'CIMJob'
# Start-Job -ScriptBlock{Get-WMIObject -ComputerName hydra -ClassName Win32_ComputerSystem} -Name 'WMIJob'

Get-Job -name CIMJob 
Get-Job -name CIMJob  | Receive-Job

Get-Job -name CIMJob  | Remove-Job


# Voor WMI mag ook op deze wijze, voor PS 5.1
Get-WmiObject -Class Win32_ComputerSystem -ComputerName Hydra -AsJob 

$job = Get-Job | Where-Object{'Job'+ ($_.id) -eq $_.Name }
$job   | Receive-Job

# cleanup
Get-Job  | Remove-Job