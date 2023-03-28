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