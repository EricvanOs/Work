Function Get-TMComputerStatus {
    Param(
    [string[]]$Computername,
    [string]$ErrorLogFilePath,
    [switch]$ErrorAppend
    )
    foreach ($computer in $Computername) {
        $OS = Get-CimInstance win32_operatingsystem -computername $computer |
        Select-Object -property CSName,TotalVisibleMemorySize,FreePhysicalMemory, NumberOfProcesses, @{Name="PctFreeMemory";Expression = {($_.freephysicalmemory/($_.TotalVisibleMemorySize))*100}}, @{Name="Uptime";Expression = { (Get-Date) - $_.lastBootUpTime}}
        $cpu = Get-CimInstance win32_processor -ComputerName $computer |
        Select-Object -Property LoadPercentage
        $vol = Get-Volume -CimSession $computer -DriveLetter C |
        Select-Object -property @{Name = "PctFreeC";Expression = {($_.SizeRemaining/$_.size)*100 }},$os,$cpu,$vol
        } #foreach $computer
    } #Get-TMComputerStatus
    
 #### again, restructure to accept pipeline input
Function Get-TMComputerStatus {
    [cmdletbinding()]
    Param(
    [Parameter(ValueFromPipeline=$True)]
    [string[]]$Computername,
    [string]$ErrorLogFilePath,
    [switch]$ErrorAppend
    )

    BEGIN {}

    PROCESS {
        foreach ($computer in $Computername) {
            $OS = Get-CimInstance win32_operatingsystem -computername $computername |
            Select-Object -property CSName,TotalVisibleMemorySize,FreePhysicalMemory,
            NumberOfProcesses,
            @{Name="PctFreeMemory";Expression = {($_.freephysicalmemory/`
            ($_.TotalVisibleMemorySize))*100}},
            @{Name="Uptime";Expression = { (Get-Date) - $_.lastBootUpTime}}
            $cpu = Get-CimInstance win32_processor -ComputerName $computername |
            Select-Object -Property LoadPercentage
            $vol = Get-Volume -CimSession $computername -DriveLetter C |
            Select-Object -property @{Name = "PctFreeC";Expression = `
            {($_.SizeRemaining/$_.size)*100 }}
            #TODO: Clean up output
            $os,$cpu,$vol
        } #foreach $computer
    }
    
    END {}
} 