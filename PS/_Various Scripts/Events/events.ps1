New-Event -SourceIdentifier Timer -Sender windows.timer -MessageData "Test"

Get-Event -SourceIdentifier 'Timer' 

Remove-Event -SourceIdentifier 'Timer'
Get-Event


# timer elapsed event
$Timer = New-Object Timers.Timer
$objectEventArgs = @{
    InputObject = $Timer
    EventName = 'Elapsed'
    SourceIdentifier = 'Timer.Elapsed'
}

Register-ObjectEvent @objectEventArgs
$Timer.Interval = 10000
$Timer.Autoreset = $False
$Timer.Enabled = $True

# list of EventSubscribers
Get-EventSubscriber

# wait for event to happen
Wait-Event -SourceIdentifier Timer.Elapsed

# remove event from queue
Get-Event -SourceIdentifier Timer.Elapsed | Remove-Event

# unregister event
Unregister-Event -SourceIdentifier Timer.Elapsed

# final test
Get-EventSubscriber
Get-Event

# timer event with action
$Timer = New-Object Timers.Timer
$Timer.Interval = 5000
$params = @{
    InputObject = $Timer
    EventName = 'Elapsed'
    SourceIdentifier = 'Timer.Random'
    Action = { $script:Random = Get-Random -Min 0 -Max 100 }
}
Register-ObjectEvent @params

$Timer.Enabled = $True
$Subscriber = Get-EventSubscriber -SourceIdentifier Timer.Random
($Subscriber.action).gettype().fullname

$Subscriber.action | Format-List -Property *

# timer loop is 5000ms and runs a action --> every 5s a new random number
& $Subscriber.action.module {$Random}

#cleanup
Unregister-Event -SourceIdentifier Timer.Random

################## to do

Get-Event -SourceIdentifier "PowerShell.ProcessCreated"

function Enable-ProcessCreationEvent
{
   $Query = New-Object System.Management.WqlEventQuery "__InstanceCreationEvent", (New-Object TimeSpan 0,0,1), "TargetInstance isa 'Win32_Process'"
   $ProcessWatcher = New-Object System.Management.ManagementEventWatcher $Query
   $Identifier = "WMI.ProcessCreated"
   Register-ObjectEvent $ProcessWatcher "EventArrived" -SupportEvent $Identifier -Action
   {
      [void] (New-Event -SourceID "PowerShell.ProcessCreated" -Sender $Args[0] -EventArguments $Args[1].SourceEventArgs.NewEvent.TargetInstance)
   }
}