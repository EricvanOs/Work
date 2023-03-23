# Make the script into an advanced function -
# add the function declaration and [CmdletBinding()] attribute

function Get-CorpCompSysInfo {
    [CmdletBinding()]
    Param(
        [string]$ComputerName
    )
    Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
}
