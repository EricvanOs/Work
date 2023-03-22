# This creates a sample XML file to work on.
# Review the structure of this and notice the
# differences between values within elements, 
# and the attributes of those elements.

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

$sample | out-file c:\inventory.xml

