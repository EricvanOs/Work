Get-Help about_Regular_Expressions -ShowWindow

# Swapping Strings Using Regex
# Given Name : Chendrayan Venkatesan
# Required Output: Venkatesan , Chendrayan

'Chendrayan Venkatesan' -replace '([a-z]+)\s([a-z]+)' ,'$2, $1'

<#
Explanation: ([a-z]+) captures a-z characters in the string and \s is for white space. 
$2 is result of second captured value [Venkatesan] and $1 is for the first value [Chendrayan] 
#>

# Removing Digits from String
#Given Name : Chendrayan12345 Venkatesan
#Required Output: Chendrayan Venkatesan

'Chendrayan12345 Venkatesan' -replace '\d+'

# difference between greedy(default) and non-greedy (lazy)
#greedy
'Chendrayan12345 Venkatesan' -replace '\d+' ,'X'   # greedy match --> 12345
'Chendrayan12345 Venkatesan' -match '\d+'
$Matches
#non-greedy
'Chendrayan12345 Venkatesan' -replace '\d+?' ,'X'  # non-greedy (lazy)  match --> 1,2,3,4,5 (5-times)
'Chendrayan12345 Venkatesan' -match '\d+?'
$Matches