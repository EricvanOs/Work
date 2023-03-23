# import xml-file
[xml]$xml = Get-Content .\inventory.xml

# XML document element
$xml

# root <computers> element
$xml.computers

# first computer
$xml.computers.computer[0]

# first computer's <addresses> element
$xml.computers.computer[0].addresses

# <ipaddress> elements
$xml.computers.computer[0].addresses.ipaddress

