$params = @{
    ClassName = 'Win32_OperatingSystem'
    ComputerName = 'Hydra'
    Verbose = $True
}

Get-CimInstance @params
Get-CimInstance @params -Verbose:$false


# Output as custom object

$ComputerName = 'Hydra','Epimetheus'

foreach ($computer in $Computername) {
    $params = @{
    Classname = "Win32_OperatingSystem"
    Computername = $computer
    }
    $OS = Get-CimInstance @params
    $params.ClassName = "Win32_Processor"
    $cpu = Get-CimInstance @params
    $params.className = "Win32_logicalDisk"
    $vol = Get-CimInstance @params -filter "DeviceID='c:'"
    $props = @{
        Computername = $os.CSName
        TotalMem = $os.TotalVisibleMemorySize
        FreeMem = $os.FreePhysicalMemory
        Processes = $os.NumberOfProcesses
        PctFreeMem = ($os.FreePhysicalMemory/$os.TotalVisibleMemorySize)*100
        Uptime = (Get-Date) - $os.lastBootUpTime
        CPULoad = $cpu.LoadPercentage
        PctFreeC = ($vol.FreeSpace/$vol.size)*100
    }
    $obj = New-Object -TypeName PSObject -Property $props
    Write-Output $obj 
}


