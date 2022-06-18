Function Clear-AllEventLogs{
<#
.SYNOPSIS
Clears all eventlogs on given computer.
.DESCRIPTION
Clears all eventlogs.
.PARAMETER computer
Default localhost otherwise remote computer.
.EXAMPLE
.Clear-AllEventLogs -Computer 'Cerberus'
.Clear-AllEventLogs 
#>
[CmdletBinding()]
Param(
    [Parameter()]
    [string]
    $Computer=$env:COMPUTERNAME
)

    if ($computer -eq $env:COMPUTERNAME)
    {
        $ErrorActionPreference = 'SilentlyContinue'
        $logs = Get-WinEvent -listlog * 
        foreach($log in $logs){
            [System.Diagnostics.Eventing.Reader.EventLogSession]::GlobalSession.ClearLog($log.LogName) 
        }
        [System.Diagnostics.Eventing.Reader.EventLogSession]::GlobalSession.ClearLog('Windows PowerShell') 
        [System.Diagnostics.Eventing.Reader.EventLogSession]::GlobalSession.ClearLog('System')
    }
    else
    {
        $ses = new-PSSession -ComputerName $computer
        invoke-command -session $ses -ScriptBlock{
            $ErrorActionPreference = 'SilentlyContinue'
            $logs = Get-WinEvent -listlog * 
            foreach($log in $logs){
                [System.Diagnostics.Eventing.Reader.EventLogSession]::GlobalSession.ClearLog($log.LogName) 
            }
            [System.Diagnostics.Eventing.Reader.EventLogSession]::GlobalSession.ClearLog('Windows PowerShell') 
            [System.Diagnostics.Eventing.Reader.EventLogSession]::GlobalSession.ClearLog('System') 
        }
        get-PSSession  | Remove-PSSession

    }
}



