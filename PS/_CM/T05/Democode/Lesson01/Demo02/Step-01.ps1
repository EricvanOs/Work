# Highlight each line one at a time and press F8 to run

# read the content and cast as xml
[xml]$xml = Get-Content C:\inventory.xml

# select the single <computer> node having
# the Name attribute of LON-DC1
# (This is an XPath query)
$node = $xml.SelectSingleNode('//computer[@name="LON-DC1"]')

# display the selected node
$node.InnerXml

# select all <ipaddress> nodes that
# follow the <computer> note having the
# Name attribute of LON-DC1. Notice that the
# XPath query follows the hierarchy of the XML.
$nodes = $xml.SelectNodes('//computer[@name="LON-DC1"]/addresses/ipaddress')
$nodes

