Param(
    # place parameters over here
)

$err1 = 0
 
Try { 

    #Place you're code over here
    3/0

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

