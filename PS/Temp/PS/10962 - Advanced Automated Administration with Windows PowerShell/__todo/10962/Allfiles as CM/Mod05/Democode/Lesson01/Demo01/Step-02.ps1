# Highlight each line one at a time and press F8 to run
# This script will not work if you run the entire thing at once

# read the content and cast as xml
# Notice that Import-CliXML will not work because
# the file is not in CliXML format.
[xml]$xml = Get-Content C:\inventory.xml

# Display the XML document element
$xml

# Display the root <computers> element
$xml.computers

# Display the first computer
$xml.computers.computer[0]

# Display the first computer's <addresses> element
$xml.computers.computer[0].addresses

# display the <ipaddress> elements
$xml.computers.computer[0].addresses.ipaddress

