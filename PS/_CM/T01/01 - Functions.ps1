# Make the script into an advanced function -
# add the function declaration and [CmdletBinding()] attribute

function Get-CorpCompSysInfo {
    [CmdletBinding()]
    Param(
        [string]$ComputerName
    )
    Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
}


# test
Get-CorpCompSysInfo -ComputerName localhost
Get-CorpCompSysInfo -ComputerName               # error
Get-CorpCompSysInfo -ComputerName xyz           # error


# infomation regarding function
(Get-Command Get-CorpCompSysInfo).Parameters
(Get-Command Get-CorpCompSysInfo).CmdletBinding
(Get-Command Get-CorpCompSysInfo).Definition
(Get-Command Get-CorpCompSysInfo).ResolveParameter('ComputerName')