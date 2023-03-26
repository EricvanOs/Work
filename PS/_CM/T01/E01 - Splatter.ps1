# see: https://github.com/StartAutomating/Splatter

import-module -name splatter

$pid  #system variable of owner process

@{Id=$pid;Junk='Data'} | Get-Splat Get-Process    
# -or 
@{Id=$pid;Junk='Data'} | ?@ gps
# -or
@{Id=$pid;Junk='Data'} | & ${?@} gps


# splat information
$splat = @{id=$pid;foo='bar'} | Get-Splat Get-Process
# or
$splat = @{id=$pid;foo='bar'} | ?@ gps
$splat.Command, $splat.PercentFit, $splat.Unmapped


# merge
@{a='b'}, @{c='d'} | Merge-Splat


# find splat
@{id=$pid} | Find-Splat *-Process


# use-splat
# Gets the process, and then doesn't stop the process because Stop-Process is passed WhatIf
@{id=$pid;WhatIf=$true} | Use-Splat Get-Process,Stop-Process 
# or
@{id=$pid;WhatIf=$true} | .@ Get-Process,Stop-Process 