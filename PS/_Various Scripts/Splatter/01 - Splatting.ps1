# see: https://github.com/StartAutomating/Splatter

Import-Module -Name Splatter


@{Id=$pid;Junk='Data'} | Get-Splat Get-Process    
# -or 
@{Id=$pid;Junk='Data'} | ?@ gps
# -or
@{Id=$pid;Junk='Data'} | & ${?@} gps



@{FilePath = 'pwsh';ArgumentList = '-noprofile';PassThru=$true} | 
    Use-Splat Start-Process |
    Add-Member NoteProperty TimeOut 15 -PassThru | 
    Get-Splat Wait-Process, Stop-Process


@{a='b'}, @{c='d'} | Merge-Splat


# explaination

@{Id=$pid;Junk='Data'} | Get-Splat Get-Process  

$pid #system variable

get-process -id $pid

$Data = @{ID = $pid}
get-process @Data

$Data = @{
    ID = $pid
    Junk = 'Data'
}
get-process @Data #fails, too many parameters

get-help get-splat -ShowWindow

Get-Splat -Command Get-Process -Splat @{Id=$pid}
#or
@{Id=$pid} | Get-Splat Get-Process     
#or, discards superfluous parameters
@{Id=$pid;Junk='Data'} | Get-Splat Get-Process 

