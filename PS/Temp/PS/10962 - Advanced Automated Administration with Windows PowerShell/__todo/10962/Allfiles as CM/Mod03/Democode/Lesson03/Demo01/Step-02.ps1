# with the module saved in the correct location,
# we can now produce HTML fragments

$fragment1 = Get-CorpCompSysInfo -ComputerName LON-DC1 |
             ConvertTo-HTML -Fragment -PreContent "<h2>Computer System</h2>" -As List |
             Out-String

# ConvertTo-HTML produces an array of strings. What we will need later is a single string.
# So we use Out-String to process the array into a single string.

$fragment2 = Get-Process -ComputerName LON-DC1 |
             ConvertTo-HTML -Fragment -Property Name,ID,VM,PM,WS -PreContent "<h2>Processes</h2>" -As Table |
             Out-String


