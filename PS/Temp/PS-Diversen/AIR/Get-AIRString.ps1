function Get-AIRString {
<#
.SYNOPSIS
  Searching in air-strings made a little bit easier
.DESCRIPTION
  Extended search in air-strings
.PARAMETER line
  line as string to be searched
.PARAMETER part
  part which is needed according to separator
.PARAMETER separator
  saparator as a string separator
.PARAMETER StartOfString
  startOfString position number to start if negative then negative offset from endpoint to start
.PARAMETER NumberOfChars
  NumberOfChars number of characters to grab
.EXAMPLE
$entry = 'abcd 1234 xyz'
Get-AIRString2 -line $entry -part 1 -StartofString 2 
answer: bcd 1234 xyz
.EXAMPLE
$entry = 'abcd 1234 xyz'
Get-AIRString2 -line $entry -part 1 -StartofString 2 -NumberofChars 5
answer: bcd 1
.EXAMPLE
$entry = 'abcd 1234 xyz'
Get-AIRString2 -line $entry -part 1 -StartofString 8 -NumberofChars -2
answer: 34 x
.EXAMPLE
$entry = 'abcd 1234 xyz'
Get-AIRString2 -line $entry -part 1 -StartofString -3
answer: xyz
.EXAMPLE
$entry = 'abcd 1234 xyz'
Get-AIRString2 -line $entry -part 1 -StartofString -3 -NumberofChars 2
answer: xy
.EXAMPLE
$entry = 'abcd 1234 xyz'
Get-AIRString2 -line $entry -part 1 -StartofString -5 -NumberofChars -2
answer: 4 x
.EXAMPLE
$entry = 'abcd 1234 xyz'
Get-AIRString2 -line $entry -part 1
answer: abcd 1234 xyz
.EXAMPLE
$entry = 'abcd 1234 xyz'
Get-AIRString2 -line $entry -part 2 -separator ' '
answer: 1234
.EXAMPLE
$entry = 'abcd 1234 xyz'
Get-AIRString2 -line $entry -part 1 -NumberofChars 3
answer: abc
.EXAMPLE
$entry = 'abcd 1234 xyz'
Get-AIRString2 -line $entry -part 1 -NumberofChars -5
answer: abcd 123
#>
[CmdletBinding()]
Param(
[string] $line,
[int] $part,
[string] $separator = ';',
[int] $StartofString = 1,  # should be -ge 1 
[int] $NumberofChars = 0
)

if ($NumberofChars -eq 0 -and $StartofString -ge 1) {
    $NumberofChars = (($line -split $separator)[$part-1]).length - $StartofString + 1
    (($line -split $separator)[$part-1]).Substring($StartofString-1,$NumberofChars).Trim()
    }
elseif ($NumberofChars -gt (($line -split $separator)[$part-1]).length){
    $NumberofChars = (($line -split $separator)[$part-1]).length
    (($line -split $separator)[$part-1]).Substring($StartofString-1,$NumberofChars).Trim()
    }
elseif ($NumberofChars -lt 0 -and $StartofString -ge 1){
    $NumberofChars = (($line -split $separator)[$part-1]).length - $StartofString + $NumberofChars + 1
    (($line -split $separator)[$part-1]).Substring($StartofString-1,$NumberofChars).Trim()
    }
elseif ($StartofString -lt 0 -and $NumberofChars -eq 0){
    $StartofString2 = (($line -split $separator)[$part-1]).length + $StartofString + 1
    (($line -split $separator)[$part-1]).Substring($StartofString2-1,-$StartofString).Trim()
}
elseif ($StartofString -lt 0 -and $NumberofChars -gt 0) {
    $StartofString = (($line -split $separator)[$part-1]).length + $StartofString + 1
    (($line -split $separator)[$part-1]).Substring($StartofString-1,$NumberofChars).Trim()
}
elseif ($StartofString -lt 0 -and $NumberofChars -lt 0){
    $StartofString2 = (($line -split $separator)[$part-1]).length + $StartofString + 1
    (($line -split $separator)[$part-1]).Substring($StartofString2-1,-$StartofString+$NumberofChars).Trim()
}
else {
(($line -split $separator)[$part-1]).Substring($StartofString-1,$NumberofChars).Trim() 
    }
}

