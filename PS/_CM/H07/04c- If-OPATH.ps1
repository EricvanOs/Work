$a = 5

if ( $a -eq 4) {write-host '$a is 4'} else {write-host '$a is not 4 '}

$a = 4
$expression = $a -eq 4
if ( $expression) {write-host '$a is 4'} else {write-host '$a is not 4 '}

# $expression is not dynamic
$a = 5
if ( $expression) {write-host '$a is 4'} else {write-host '$a is not 4 '}


# solution, create a dynamic expandable string

$expression = @'
    $a -eq 4
'@


# test 
$a = 5

$ExpandedExpression = $ExecutionContext.InvokeCommand.ExpandString($expression)

#controle
$ExpandedExpression
Invoke-Expression $ExpandedExpression

# create OPATH expression and use it
$expression = @'
    $a -eq 4
'@

$a = 5


if ( Invoke-Expression $ExecutionContext.InvokeCommand.ExpandString($expression) ) {write-host '$a is 4'} else {write-host '$a is not 4 '}


# OPATH Queries
# see: https://techcommunity.microsoft.com/t5/security-compliance-and-identity/using-adaptive-policy-scopes-to-apply-m365-retention-to-shared/ba-p/3053641
# see: dynamic groups in AAD e.g. https://portal.azure.com/#view/Microsoft_AAD_IAM/GroupDetailsMenuBlade/~/DynamicGroupMembershipRule/groupId/e6108476-dbf0-43cd-9b36-0c314f35a736

