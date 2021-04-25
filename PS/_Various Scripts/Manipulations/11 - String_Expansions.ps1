# String expansion
# When working with strings, you need to remember that using a double quote evaluates
# enclosed variables, that is variables are replaced with their values. For example:
$today = Get-Date
Write-Host "Today is $today"


#This behavior may sometimes cause issues especially if you need to use multiple variables in
#continuation, as in the following case where we want to combine $name, and underscore (_),
#$ts and .txt to create a timestamped filename.
$name = 'belle'
$ts = Get-Date -Format yyyy-MMM-dd
"$name_$ts.txt"  #incorrect

"$($name)_$($ts).txt" #correct

"${name}_${ts}.txt"   #correct

"{0}_{1}.txt" -f $name, $ts #correct


#A single quote, on the other hand, preserves the actual variable name and does not expand the value:
$today = Get-Date
Write-Host 'Today is $today'
