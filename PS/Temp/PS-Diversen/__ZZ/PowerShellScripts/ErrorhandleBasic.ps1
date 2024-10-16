Param(
[Int] $arg1 = 6, 
[Int] $arg2 = 0
)

$err1 = 0

Try { 

    [Double] $result = $arg1 / $arg2 

} 
Catch { 

    Write-Host 'Error in function'
    $err1 = 1

} 
Finally { 

    if($err1 -eq 1) 
    {         
         ## Custom Exit Code:
        [Environment]::ExitCode = 99
    } 
    Else 
    { 
       Write-Output -InputObject $result
       [Environment]::ExitCode = 0
    } 
} 


[Environment]::ExitCode