$output = ipconfig 
$output | Select-String 'IPv6 Address' | Select-Object -First 1
 

