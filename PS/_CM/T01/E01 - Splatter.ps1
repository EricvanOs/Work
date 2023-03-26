# see: https://github.com/StartAutomating/Splatter

import-module -name splatter

$pid  #system variable of owner process

@{Id=$pid;Junk='Data'} | Get-Splat Get-Process    
# -or 
@{Id=$pid;Junk='Data'} | ?@ gps
# -or
@{Id=$pid;Junk='Data'} | & ${?@} gps