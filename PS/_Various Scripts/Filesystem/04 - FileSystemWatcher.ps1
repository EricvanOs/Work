enum EventName {
    Created
    Changed
    Deleted
    Renamed
}

function Invoke-FileSystemWatcher {
    [CmdletBinding()]
    param (
        [Parameter()]
        [System.IO.FileInfo] $Path,

        [Parameter()]
        [String] $filter = '*.*',

        [Parameter()]
        [System.IO.NotifyFilters] $NotifyFilters,

        [parameter()]
        [Switch] $Recurse,

        [parameter()]
        [Switch] $EnableRaisingEvents,

        [Parameter()]
        [EventName] $EventName,

        [Parameter()]
        [psobject] $MessageData,

        [Parameter()]
        [scriptblock] $Action
    )

    $watcher = [System.IO.FileSystemWatcher]::new()

    Write-Verbose -Message "[PROCESS] Building FileSystemWatcher with parameters"

    # Build the FileSystemWatcher class
    Switch ($PSBoundParameters) {
        { $_.ContainsKey('Path') } {
            $watcher.Path = $Path.FullName
        }
        { $_.ContainsKey('Filter') } {
            $watcher.Filter = $filter
        }
        { $_.ContainsKey('NotifyFilters') } {
            $watcher.NotifyFilter = $NotifyFilters
        }
        { $_.ContainsKey('Recurse') } {
            $watcher.IncludeSubdirectories = $Recurse.ToBool()
        }
        { $_.ContainsKey('Recurse') } {
            $watcher.EnableRaisingEvents = $EnableRaisingEvents.ToBool()
        }
    }

    Write-Verbose -Message "[PROCESS] Built FileSystemWatcher, registering Event"

    # Register the Event
    $ObjectEvent = @{
        InputObject      = $watcher
        EventName        = $EventName
        SourceIdentifier = "Watching: $($Path.FullName)"
        Action           = $Action
        MessageData      = $MessageData
    }
    $null = Register-ObjectEvent @ObjectEvent

    Write-Verbose -Message "[PROCESS] Event now registered"
}

$Path = 'K:\_CM\_Various Scripts\Filesystem'
Set-Location $Path

# Example | monitor directory size and alert to host  
$watcherEvent = @{
    Path                = "$Path\tmp"
    filter              = "*.*" 
    NotifyFilters       = 'LastWrite', 'DirectoryName' 
    Recurse             = $true
    MessageData         = "8mb" 
    EnableRaisingEvents = $true
    EventName           = 'Changed'
    Action              = {
        $Folder = (Get-ChildItem $Sender.Path -Recurse | 
                Measure-Object -Property Length -Sum -ErrorAction Stop).Sum

        if ($Folder -ge $Event.MessageData) {
            $limitOver = '{0:N2}MB' -f (($Folder - $Event.MessageData) / 1mb)
    
            $message = "[WARNING] [{0}] {1} has exceeded the limit of {2} by {3}" -f
            $Event.TimeGenerated,
            $Sender.Path,
            $Event.MessageData,
            $limitOver

            $message | Out-Host
        }
    }
}

Invoke-FileSystemWatcher @watcherEvent

Get-EventSubscriber | Where-Object{$_.SourceIdentifier -like "*$Path*"} | Unregister-Event


# Example | monitor directory and process file(s)  
$watcherEvent = @{
    Path                = "$Path\tmp"
    filter              = "*.*" 
    NotifyFilters       = 'LastWrite', 'DirectoryName' 
    Recurse             = $true
    MessageData         = "8mb" 
    EnableRaisingEvents = $true
    EventName           = 'Changed'
    Action              = {

        # Process data
        Get-ChildItem $Sender.Path -Recurse | Move-Item -Destination "$path\tmpx"    
        
    }
}

Invoke-FileSystemWatcher @watcherEvent

# unregister event

Get-EventSubscriber | Where-Object{$_.SourceIdentifier -like "*$Path\tmp*"} | Unregister-Event

#cleanup 

Get-ChildItem -Path "$Path\tmpx" | Remove-Item
