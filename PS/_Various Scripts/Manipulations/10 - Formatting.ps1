$header = 'Report for Today'
$myString = '{0}`n{1}' -f $header,('-' * $header.Length)
$myString 



$formatString = '{0,8:D4} {1:C}`n' 
$report = 'Quantity Price`n' 
$report += '---------------`n' 
$report += $formatString -f 50,2.5677 
$report += $formatString -f 3,9 
$report


