# Add some simple CSS

$fragment1 = Get-CorpCompSysInfo -ComputerName LON-DC1 |
             ConvertTo-HTML -Fragment -PreContent "<h2>Computer System</h2>" -As List |
             Out-String

# ConvertTo-HTML produces an array of strings. What we will need later is a single string.
# So we use Out-String to process the array into a single string.

$fragment2 = Get-Process -ComputerName LON-DC1  |
             ConvertTo-HTML -Fragment -Property Name,ID,VM,PM,WS -PreContent "<h2>Processes</h2>" -As Table |
             Out-String

# Create a here-string with CSS
$style = @"
<style>
    body {
        background-color:#eee;
        color:#333;
        font-family:Segoe,Tahoma,Verdana,Arial;
        font-size:10pt;
    }
    th {
        color:white;
        font-weight:bold;
        background-color:black;
    }
</style>
"@

# Now we combine the fragments
ConvertTo-HTML -Title "Report for LON-DC1" -Head $style -Body "<h1>Report for LON-DC1</h1>",$fragment1,$fragment2 |
Out-File c:\lon-dc1.html
