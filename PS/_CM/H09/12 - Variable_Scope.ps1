Function TestScope {
    Write-Host "At the start of the function `$a is $a"
    Read-Host "Press a key to continue"
    $a = ' -- Set at functionlevel (innerblock) --'
    Write-Host "After definition in the function `$a is $a"
    Read-Host "Press a key to continue"
    Write-Host "The script scope can still be accessed in a function: $script:a"
    Read-Host "Press a key to continue"
    Return($a)
}

# test outerblock variable
$a = ' -- Set at scriptlevel (outerblock) --'
Write-Host "In script before the function `$a is $a"

# run function to test
$functionVar=TestScope

#test again
Write-Host "In script after the function `$a is $a" # let op niet die ($a) in de functie werd gebruikt
Write-Host "The `$FunctionVar passed back from the function is $functionVar"