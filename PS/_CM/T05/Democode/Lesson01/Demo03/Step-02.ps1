# Go through the computers



function Update-NetIPInventory {
    [CmdletBinding()]
    param(
        [xml]$xml
    )

    foreach ($computer in $xml.computers.computer) {


    }

}

Update-NetIPInventory -xml (Get-Content C:\inventory.xml)
