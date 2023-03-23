function Get-CorpCompSysInfo {
    [CmdletBinding()]
    Param(


        [string]$ComputerName
    )
    Write-Verbose "Now connecting to $ComputerName"
    Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
}


##########
# Define parameter as mandatory

function Get-CorpCompSysInfo {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]

        [string]$ComputerName
    )
    Write-Verbose "Now connecting to $ComputerName"
    Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
}

Get-CorpCompSysInfo 

#########
# Provide a help message
function Get-CorpCompSysInfo {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,HelpMessage='Computer name to query')]

        [string]$ComputerName
    )
    Write-Verbose "Now connecting to $ComputerName"
    Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
}


Get-CorpCompSysInfo 

###########
# Add an alias


function Get-CorpCompSysInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True,HelpMessage='Computer name to query')]
        [Alias('hostname')]
        [string]$ComputerName
    )
    Write-Verbose "Now connecting to $ComputerName"
    Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
}


Get-CorpCompSysInfo -hostname hydra

#######################
# Notice that a comma separates parameters
# and that parameter attributes are per-parameter
function Get-CorpCompSysInfo {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,HelpMessage='Computer name to query')]
        [Alias('hostname')]
        [string]$ComputerName,

        [Parameter(HelpMessage='This is for example only')]
        [int]$AnotherParameter
    )
    Write-Verbose "Now connecting to $ComputerName"
    Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
}

Get-CorpCompSysInfo -ComputerName Hydra -AnotherParameter 3 -Verbose

