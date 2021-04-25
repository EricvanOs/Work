# This statement returns true because book contains the string "oo"
'book' -match 'oo'
'bok'  -match 'oo'   #false

# This expression returns true if the pattern matches big, bog, or bug.
'big' -match 'b[iou]g'
'bag' -match 'b[iou]g' #false

# This expression returns true if the pattern matches any 2 digit number.
42  -match '[0-9][0-9]'
2   -match '[0-9][0-9]' #false
421 -match '[0-9][0-9]'

# This expression returns true if it matches a server name.
# (Server-01 - Server-99).
'Server-01' -match 'Server-\d\d'
'Server-1'  -match 'Server-\d\d'  #false

# The pattern matches the first word character 'B'.
'Book' -match '\w'

# The pattern matches any 4 characters except the newline.
'a1\ ' -match '....'
'a1\'  -match '....'  #false

# The pattern uses both methods to match the space.
' - ' -match '\s- '

# This returns true for all account name strings even if the name is absent.
'ACCOUNT NAME:    Administrator' -match 'ACCOUNT NAME:\s*\w*'

# This returns true if it matches any server name.
'DC-01' -match '[A-Z]+-\d\d'

# This returns true for any server name, even ones without dashes.(but not with 2 dashes)
'SERVER01'   -match '[A-Z]+-?\d\d'
'SERVER-01'  -match '[A-Z]+-?\d\d'
'SERVER--01' -match '[A-Z]+-?\d\d'  #false

# This returns true if it matches any phone number.
'111-222-3333'  -match '\d{3}-\d{3}-\d{4}'
'1111-222-3333' -match '\d{3}-\d{3}-\d{4}'
'111-2222-3333' -match '\d{3}-\d{3}-\d{4}'  #false

# The pattern expects the 'h' to be followed by the end of the word.
'fishing' -match '^fish$'  #false

# This returns true and matches numbers with at least 2 digits of precision.
# The decimal point is escaped using the backslash.
'3.141' -match '3\.\d{2,}'

'The last logged on user was CONTOSO\jsmith' -match '(.+was )(.+)'
$Matches.0
$Matches


'Good Dog' -match 'Dog'
$Matches[0]
$Matches.Item(0)
$Matches.0


$string = 'The last logged on user was CONTOSO\jsmith'
$string -match 'was (?<domain>.+)\\(?<user>.+)'
$Matches
$Matches.domain
$Matches.user


$log = (Get-EventLog -LogName Security -Newest 1 -InstanceId 4799).message
$r = '(?s).*Account Name:\s*(?<N>.*).*Account Domain:\s*(?<D>[A-Z,0-9]*)'
# remark (?s) is also called  "single line mode" maw beschouw 't als een regel.
$log -match $r
$Matches



'John D. Smith' -replace '(\w+) (\w+)\. (\w+)', '$1.$2.$3@contoso.com'

'CONTOSO\Administrator' -replace '\w+\\(?<user>\w+)', 'FABRIKAM\${user}'

'Hello World' -replace '(\w+) \w+', '$1 Universe'

