Set-Location -Path C:\Work\PS\_CM\T05

$sample = @"
<computers>
    <computer name="LON-DC1">
        <addresses>
            <ipaddress family="IPv4" adaptername="Ethernet" interfaceindex="0">192.168.12.4</ipaddress>
        </addresses>
    </computer>
    <computer name="LON-SVR1" />
</computers>
"@

# export file
$sample | out-file .\inventory.xml

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