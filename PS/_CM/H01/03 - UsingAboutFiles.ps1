# 1
Get-Help about*

# 2
Get-Help about_aliases 
Get-Help about_Aliases -ShowWindow


# bijzondere tekens met ` (backtick)
Get-Help about_Special_Characters 
"a`vb"   # v vertical tab, let op backtick ipv single quote

'abc' + 'def'

'abc' + "`t"  + 'def'

'abc' + "`r`n"  + 'def'
'abc' + '`r`n'  + 'def'  #werkt niet

# strings

'abc' + 'def'
"abc" + "def"
$a = 'def'
'abc' + '$a'
'abc' + "$a"
"abc$a"
"abc`$a"