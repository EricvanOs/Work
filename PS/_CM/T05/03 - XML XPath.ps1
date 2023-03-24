$string = @"
<?xml version="1.0"?>
<cars>
    <car type="Saloon">
    <colour>Green</colour>
    <doors>4</doors>
    <transmission>Automatic</transmission>
    <engine>
        <size>2.0</size>
        <cylinders>4</cylinders>
    </engine>
    </car>
</cars>
"@

# The -XPath expression and the result are shown here:
Select-Xml -XPath '//car[colour="Green"]/engine' -Content $string | Select-Object -ExpandProperty Node

# A similar result can be achieved using the SelectNodes method of an XML document:
([Xml]$string).SelectNodes('//car[colour="Green"]/engine')


# namespaces being used
[Xml]$xml = @"
<?xml version="1.0"?>
<cars xmlns:c="http://example/cars">
    <car type="Saloon">
    <c:colour>Green</c:colour>
    <c:doors>4</c:doors>
    <c:transmission>Automatic</c:transmission>
    <c:engine>
        <size>2.0</size>
        <cylinders>4</cylinders>
    </c:engine>
    </car>
</cars>
"@

#  format-xml
$xml.Save([Console]::Out)
Select-Xml '//car/c:engine' -Namespace @{c='http://example/cars'} -Xml $xml

# modifying elements and attributes
[Xml]$xml = @"
<?xml version="1.0"?>
<items>
 <item name='Fridge'>
    <category>Appliancse</category>
 </item>
 <item name='Cooker'>
    <category>Appliances</category>
 </item>
</items>
"@

($xml.items.item | Where-Object name -eq 'Fridge').category = 'Appliances'
#test
$xml.Save([Console]::Out)


# be careful
[Xml]$xml = @"
<?xml version="1.0"?>
<list>
 <name>one</name>
 <name>two</name>
</list>
"@
# The first value may be changed if it is uniquely identified and selected:
$xml.list.SelectSingleNode('./name[.="one"]').'#text' = 'three'
#test
$xml.Save([Console]::Out)


# The following example shows a similar change being made to the value of an attribute:
[Xml]$xml = @"
<?xml version="1.0"?>
<list name='letters'>
    <name>1</name>
</list>
"@
$xml.SelectSingleNode('/list[@name="letters"]').SetAttribute('name','numbers')
#test
$xml.Save([Console]::Out)


# The @ symbol preceding name in the XPath expression denotes that the value type is an attribute. 
# If the attribute referred to by the SetAttribute method does not exist, it will be created.

[Xml]$xml = @"
<?xml version="1.0"?>
<list type='numbers'>
 <name>1</name>
</list>
"@
$newElement = $xml.CreateElement('name')
$newElement.InnerText = 2
$xml.list.AppendChild($newElement)
#test
$xml.Save([Console]::Out)


# merging two xml-files

[Xml]$xml = @"
<?xml version="1.0"?>
<list type='numbers'>
 <name>1</name>
</list>
"@

[Xml]$newNodes = @"
<root>
 <name>2</name>
 <name>3</name>
 <name>4</name>
</root>
"@

# Copying the name nodes requires each node to be selected in turn, imported into the original document, and added to the desired node:
foreach ($node in $newNodes.SelectNodes('/root/name')) {
 $newNode = $xml.ImportNode($node, $true)
 $null = $xml.list.AppendChild($newNode)
}
#test
$xml.Save([Console]::Out)
$xml.OuterXml


# Removing elements and attributes Elements may be removed from a document by selecting the node, then calling the
# RemoveChild method on the parent:
[Xml]$xml = @"
<?xml version="1.0"?>
<list type='numbers'>
 <name>1</name>
 <name>2</name>
 <name>3</name>
</list>
"@

$node = $xml.SelectSingleNode('/list/*[.="3"]')
$null = $node.ParentNode.RemoveChild($node)
#test
$xml.Save([Console]::Out)


# Attributes are also easy to remove from a document:
$xml.list.RemoveAttribute('type')
#test
$xml.Save([Console]::Out)


