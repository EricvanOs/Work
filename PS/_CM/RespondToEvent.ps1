<#
Specify an action to respond to an event
When you specify an action, events that are raised are not added to the event queue. 
Instead, the action responds to the event. 
In this example, when an instance creation event is raised indicating that a new process is started, a new ProcessCreated event is raised.
#>

$queryParameters = '__InstanceCreationEvent', (New-Object TimeSpan 0,0,1), "TargetInstance isa 'Win32_Process'"

$Query = New-Object System.Management.WqlEventQuery -ArgumentList $queryParameters

$ProcessWatcher = New-Object System.Management.ManagementEventWatcher $query

$newEventArgs = @{
    SourceIdentifier = 'PowerShell.ProcessCreated'
    Sender = $Sender
    EventArguments = $EventArgs.NewEvent.TargetInstance
}

$Action = { New-Event @newEventArgs }

Register-ObjectEvent -InputObject $ProcessWatcher -EventName "EventArrived" -Action $Action


<#
The Register-ObjectEvent command returns a job object that represents the action, which runs as a background job. 
You can use the Job cmdlets, such as Get-Job and Receive-Job, to manage the background job. 
For more information, see about_Jobs.
#>

#test 
notepad

get-job | Receive-Job