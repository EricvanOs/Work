# only 1 match 
$url = 'https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers'
$url -match '{(\w+)}' 
$matches

# all matches
$string = "blah blah F12 blah blah F32 blah blah blah" 
$regexPattern = 'F\d\d' 
$all = $string | Select-String -Pattern $regexPattern -AllMatches
$all.Matches
$all.Matches[0].Value
$all.Matches[1].Value

# also possible in this way
$string = "blah blah F12 blah blah F32 blah blah blah" 
$mm = ([regex]'F\d\d').Matches($string);
$mm[0].Value
$mm[1].Value



$mm = ([regex]'{\w+}').Matches($url)
$mm[0].Value;
$mm[1].Value;


