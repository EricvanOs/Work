# Remove the Addresses node for the computer



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

    }

}

Update-NetIPInventory -xml (Get-Content C:\inventory.xml) -verbose
