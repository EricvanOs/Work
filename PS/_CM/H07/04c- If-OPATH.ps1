$a = 5

if ( $a -eq 4) {write-host '$a is 4'} else {write-host '$a is not 4 '}

$a = 4
$expression = $a -eq 4
if ( $expression) {write-host '$a is 4'} else {write-host '$a is not 4 '}

# of 

$expression = @'
    $a -eq 4
'@

$expression -is [string]

[bool]$expression -is [bool]

if ( [bool]$expression) {write-host '$a is 4'} else {write-host '$a is not 4 '}


# OPATH Queries
# see: https://techcommunity.microsoft.com/t5/security-compliance-and-identity/using-adaptive-policy-scopes-to-apply-m365-retention-to-shared/ba-p/3053641