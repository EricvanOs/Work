# Create an ipaddress node for each IP address
# notice that we append each to the Addresses node,
# and then append it to the computer.

function Update-NetIPInventory {
    [CmdletBinding()]
    param(
        [xml]$xml
    )

    foreach ($computer in $xml.computers.computer) {
        Write-Verbose "Getting address info for $($computer.name)"
        $info = Get-AdatumNetAdapterInfo -ComputerName $computer.name

        if ($computer.hasChildNodes) {
            $addresses = $computer.SelectSingleNode('addresses')
            $computer.RemoveChild($addresses) | Out-Null
        }

        $addresses = $xml.CreateElement('element','addresses','')

        foreach ($item in $info) {
            $address = $xml.CreateElement('element','ipaddress','')
            $address.InnerText = $item.IPAddress

            $addresses.AppendChild($address) | Out-Null
        }

        $computer.AppendChild($addresses) | Out-Null
    }

}

Update-NetIPInventory -xml (Get-Content C:\inventory.xml) -verbose
