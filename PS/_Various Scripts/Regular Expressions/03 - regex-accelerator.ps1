# using [regex] accelerator for regular expressions

"What is your name?" -replace "?", " dude?"   #fails

"What is your name?" -replace [regex]::Escape("?")," dude?"

[regex]::Escape("?") 

"What is your name?" -replace "\?", " dude?" 



[regex]::Match('abc123','^a')  # slechts een group
[regex]::Match('abc123','^a(.+)') # twee groepen

[regex]::Match('abc123','^a(.+)').captures.groups
[regex]::Match('abc123','^a(.+)').captures.groups[1].value


# mag ook op deze wijze
'abc123' -match '^a(.+)'

$Matches[0]
$Matches[1]