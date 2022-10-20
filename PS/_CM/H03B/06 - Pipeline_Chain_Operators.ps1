# Pipeline_Chain_Operators
<#
The && operator : left-hand pipeline succeeded --> the right-hand pipeline executes
                : left-hand pipeline failed    --> stop
    
The || operator : left-hand pipeline succeeded --> stop
		    : left-hand pipeline failed    --> the right-hand pipeline executes  
#>

#examples

#both
Write-Output 'First' && Write-Output 'Second'

# only the first
Write-Error 'Bad' && Write-Output 'Second'

# only the first
Write-Output 'First' || Write-Output 'Second'

#only the second
Write-Error 'Bad' || Write-Output 'Second'