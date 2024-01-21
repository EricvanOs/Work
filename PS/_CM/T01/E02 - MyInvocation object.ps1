function Get-MyComputerDate {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,
                    HelpMessage='Computer name to set state for',
                    ValueFromPipeline=$True,
                    ValueFromPipelineByPropertyName=$True)]
        [Alias('hostname')]
        [string[]]$ComputerName
    )
Begin {
    Write-Verbose "[$((Get-Date).TimeofDay) BEGIN ] Starting $($myinvocation.mycommand)"
} #begin
Process {
    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Processing $computername"
}
End {
    Write-Verbose "[$((Get-Date).TimeofDay) END ] Ending $($myinvocation.mycommand)"
} #end
}

# test
Get-MyComputerDate -ComputerName Amphitrite -Verbose

$MyInvocation | Select-Object -Property *