# special characters
# []().\^$|?*+{} must all be escaped using \ if want to use as regular characters
'[part]something[\part]' -match '\[[a-z]+\]([a-z]*?)\[\\[a-z]+\]'
$Matches


# greedy and lazy matches
'123456789' -match '(\d{4,})(\d*)'     # greedy
$Matches
'123456789' -match '(\d{4,}?)(\d*)'    # lazy
$Matches

# all variations
'123456789' -match '(\d{4,8})(\d{2,})'
$Matches
'123456789' -match '(\d{4,8}?)(\d{2,})'
$Matches
'123456789' -match '(\d{4,8})(\d{2,}?)'
$Matches
'123456789' -match '(\d{4,8}?)(\d{2,}?)'
$Matches

'123456789' -match '((?>\d{4,6}))(\d{2})'  # possessive behaviour, removes all backtracking for the parenthesized group, force greedy
$Matches
'123456789' -match '(?>\d{4,8})(\d{2})'  # will fail, first expression will take 8, nothing left for second expression


# Lookbehind uses the following syntax (?<=pattern) 
'My bill is £18.20'  -match '(?<=£)\d+\.\d+'    # 'My bill is £18.20'  -match '£(\d+\.\d+)'
'My bill is £    18.20'  -match '(?<=£\s*)\d+\.\d+'  # \s* whitespace 0 or more times
$Matches

# Remember have to escape the . then two decimals     (.dd) 0 or 1 times  -->   (\.\d{2})? 
'My bill is £    18.20'  -match '(?<=£\s*)\d+(\.\d{2})?'  # ? 0 or 1 time(s)
'My bill is  £  19'  -match '(?<=£\s*)\d+(\.\d{2})?'
$Matches
# Normally an expression ( ..... ) is captured, but (?: .... ) is non-capturing
'My bill is £    18.20' -match '(?<=£\s*)\d+(?:\.\d{2})?'
$Matches

# Lookahead uses the following syntax (?=pattern)
'The distance is 10 miles.' -match '\d+(?=\s*miles)'
$Matches
'The distance is 10 and a half miles.' -match '\d+(?=(\s*\w*)*\s*miles)'
$Matches


# Negative lookbehind (NOT a pattern before) uses the following syntax (?<!)
'The result is minus 10 dollar.' -match '(?<!minus\s*)\d{2}'
'The result is 10 dollar.' -match '(?<!minus\s*)\d{2}'
$Matches
'The result is minus 100 dollar.' -match '(?<!minus\s*)(\d+)'       # strange, look at the match 
'The result is minus 100 dollar.' -match '(?<!minus)(?:\s+(\d+))'   # the match (space \d \d \d)  ; don't capture spaces (?:), but capture digits (\d+)
'The result is 100 dollar' -match '(?<!minus)(?:\s+(\d+))'

# Negative lookahead (NOT a pattern after) uses the following syntax (?!)
'I have to pay 10$ today.' -match '\b\d+\b(?!\$)'    # $ should be escaped with \ --> \$
'I have to pay $10 today.' -match '\b\d+\b(?!\$)'
$Matches

