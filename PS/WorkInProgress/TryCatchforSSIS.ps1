Param(
[Int] $arg1 = 6, 
[Int] $arg2 = 0
)


$err1 = 0
 
Try { 

    #Place you're code over here
    [Double] $result = $arg1 / $arg2 

} 
Catch { 

    Write-Verbose 'Error in function'
    $err1 = 1

} 
Finally { 

    if($err1 -eq 1) 
    {         
       # Custom Exit Code:
       Write-Host "Failure:  $($Error[0])"
    } 
    Else 
    { 
       # No error
       Write-Host "Success"
    } 
} 

