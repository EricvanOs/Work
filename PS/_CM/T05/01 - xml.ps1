# This creates a sample XML file to work on.
# Review the structure of this and notice the
# differences between values within elements, 
# and the attributes of those elements.

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

$sample | out-file .\inventory.xml

