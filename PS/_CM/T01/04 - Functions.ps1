# This is our starting point
function Get-CorpCompSysInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,HelpMessage='Computer name to query')]
        [Alias('hostname')]
        [ValidatePattern('m\w+eus')]
        [string[]]$ComputerName
    )

    foreach ($computer in $computername) {
        Write-Verbose "Now connecting to $computer"
        Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $computer
    }

}

Get-CorpCompSysInfo -ComputerName epimetheus

# Add the pipeline input attributes
# let op ByValue en ByPropertyName
function Get-CorpCompSysInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,
                   HelpMessage='Computer name to query',
                   ValueFromPipeline=$True,
                   ValueFromPipelineByPropertyName=$True)]
        [Alias('hostname')]
        [ValidatePattern('m\w+eus')]
        [string[]]$ComputerName
    )

    foreach ($computer in $computername) {
        Write-Verbose "Now connecting to $computer"
        Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $computer
    }

}

Get-CorpCompSysInfo -ComputerName morpheus , epimetheus 
Get-CorpCompSysInfo -ComputerName morpheus , epimetheus -verbose
[array]$ComputerName = 'morpheus' , 'epimetheus' 
Get-CorpCompSysInfo -ComputerName $ComputerName

$ComputerName | Get-CorpCompSysInfo  # hmm, strange only one result

'morpheus' , 'epimetheus' | select-object @{n='ComputerName';e={($_)}} | Get-CorpCompSysInfo


########### Process block is needed
function Get-CorpCompSysInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,
                   HelpMessage='Computer name to query',
                   ValueFromPipeline=$True,
                   ValueFromPipelineByPropertyName=$True)]
        [Alias('hostname')]
        [ValidatePattern('m\w+eus')]
        [string[]]$ComputerName
    )
    PROCESS {
        foreach ($computer in $computername) {
            Write-Verbose "Now connecting to $computer"
            Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $computer
        }
    }
}

Get-CorpCompSysInfo -ComputerName morpheus , epimetheus 
Get-CorpCompSysInfo -ComputerName morpheus , epimetheus -verbose
[array]$ComputerName = 'morpheus' , 'epimetheus' 
Get-CorpCompSysInfo -ComputerName $ComputerName

$ComputerName | Get-CorpCompSysInfo 

'morpheus' , 'epimetheus' | select-object @{n='ComputerName';e={($_)}} | Get-CorpCompSysInfo