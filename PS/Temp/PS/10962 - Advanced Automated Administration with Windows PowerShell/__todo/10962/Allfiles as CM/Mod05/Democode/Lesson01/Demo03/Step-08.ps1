# Save the final XML



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
            $address.InnerText = $item.IPAddress | Out-Null

            $family = $xml.CreateAttribute('family')
            $index = $xml.CreateAttribute('interfaceindex')
            $adapt = $xml.CreateAttribute('adaptername')

            $address.SetAttributeNode($family) | Out-Null
            $address.SetAttributeNode($index) | Out-Null
            $address.SetAttributeNode($adapt) | Out-Null

            $address.family = [string]$item.AddressFamily
            $address.interfaceindex = [string]$item.InterfaceIndex
            $address.adaptername = [string]$item.AdapterName

            $addresses.AppendChild($address) | Out-Null
        }

        $computer.AppendChild($addresses) | Out-Null
    }

    Write-Output $xml.OuterXML

}

Update-NetIPInventory -xml (Get-Content C:\inventory.xml) -verbose | Out-File c:\new-inventory.xml
