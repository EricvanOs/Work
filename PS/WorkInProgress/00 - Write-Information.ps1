Function Get-Bits {
    [cmdletbinding()]
    Param(
    [Parameter(Position = 0, ValueFromPipeline)]
    [string[]]$Computername = $env:computername
    )
    Begin {
        $start = Get-Date
        $msg = "[$start] Starting $($myinvocation.MyCommand)"
        Write-Verbose $msg
        Write-Information $msg -Tags meta,begin
        $count = 0
        $errorcount = 0
        $PSBoundParameters | Out-String | Write-Verbose
        $cim = @{
            ClassName = 'Win32_Service'
            Filter = "name='bits'"
            ErrorAction = "Stop"
            Computername = ""
        }
    }
    Process {
        foreach ($computer in $Computername) {
        $count++
        $cim.Computername = $Computer
        Write-Information "Query $computer" -Tags process
        Try {
            Write-Host "Getting BITS from $computer" -ForegroundColor green
            Get-CimInstance @cim |
            Select-Object @{Name = "Computername";Expression = {$_.SystemName}},
            Name, State, StartMode
        }
        Catch {
            $errorcount++
            $msg = "Failed to query $computer. $($_.exception.message)"
            Write-Warning $msg
            Write-Information $msg -Tags process, error
        }
        }
    }
    End {
        $end = Get-Date
        $timespan = New-Timespan -start $start -end $end
        $sum = "Processed $count computer(s) with $errorcount error(s) in $timespan"
        Write-Information $sum -Tags meta,end
        $msg = "[$end] Ending $($myinvocation.MyCommand)"
        Write-Information $msg -Tags meta,end
        Write-Verbose $msg
    }
} 


$r = "apate","hydra","nothere" | Get-Bits -InformationVariable iv -Verbose
$iv | Select-Object -property TimeGenerated,MessageData,tags