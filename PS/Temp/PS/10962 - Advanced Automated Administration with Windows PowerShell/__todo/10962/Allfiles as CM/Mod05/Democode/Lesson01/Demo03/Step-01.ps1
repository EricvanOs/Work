# Set up the function



function Update-NetIPInventory {
    [CmdletBinding()]
    param(
        [xml]$xml
    )

}

Update-NetIPInventory -xml (Get-Content C:\inventory.xml)
