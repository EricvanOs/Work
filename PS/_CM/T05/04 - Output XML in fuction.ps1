function Get-AdatumNetAdapterInfo {
    <#
    .SYNOPSIS
    Retrieves network adapter and IP address information.
    .DESCRIPTION
    This command combines information about each network adapter
    and all IP addresses bound to it. This uses CIM, so target computers
    must have WMF 3.0 or later installed, and WinRM must be enabled.
    .PARAMETER ComputerName
    One or more computer name. IP addresses are not acceptable. This
    parameter does not accept pipeline input.
    .EXAMPLE
    Get-AdatumNetAdapterInfo -ComputerName LON-DC1,LON-SVR1
    #>
        [CmdletBinding()]
        param(
            [Parameter(Mandatory=$True)]
            [string[]]$ComputerName
        )
        
        foreach ($computer in $computername) {
    
            Write-Verbose "Connecting to $computer"
            $session = New-CimSession -ComputerName $computer
    
            $adapters = Get-NetAdapter -CimSession $session
            foreach ($adapter in $adapters) {
                
                $addresses = Get-NetIPAddress -InterfaceIndex ($adapter.InterfaceIndex) -CimSession $session
                foreach ($address in $addresses) {
    
                    $properties = @{'ComputerName'=$computer;
                                    'AdapterName'=$adapter.Name;
                                    'InterfaceIndex'=$adapter.InterfaceIndex;
                                    'IPAddress'=$address.IPAddress;
                                    'AddressFamily'=$address.AddressFamily}
                    $output = new-object -TypeName PSObject -Property $properties
                    Write-Output $output
    
                } # addresses
            } # adapeters
        } # computers
    
        Write-Verbose "Closing session to $computer"
        $session | Remove-CimSession
    
} # function



# Alternate version uses a parameter
# to save the new XML directly to a file


function Update-NetIPInventory {
    [CmdletBinding()]
    param(
        [xml]$xml,
        [string]$OutputPath
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

    $xml.Save($OutputPath)

}

Set-Location -Path C:\work\ps\_CM\T05

Update-NetIPInventory -xml (Get-Content .\inventory.xml) -verbose -OutputPath C:\work\ps\_CM\T05\new-inventory.xml

