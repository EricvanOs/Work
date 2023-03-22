# Run Get-NetAdatumNetAdapterInfo for each
# computer


function Update-NetIPInventory {
    [CmdletBinding()]
    param(
        [xml]$xml
    )

    foreach ($computer in $xml.computers.computer) {
        Write-Verbose "Getting address info for $($computer.name)"
        $info = Get-AdatumNetAdapterInfo -ComputerName $computer.name

    }

}

Update-NetIPInventory -xml (Get-Content C:\inventory.xml) -verbose
