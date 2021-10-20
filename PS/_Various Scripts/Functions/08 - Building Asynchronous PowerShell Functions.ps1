 # Remove-AzVM -Name MYVM -ResourceGroupName MYRG (standard function)

 # Make wrapper

function Remove-MyAzVM
{
    param (
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$ResourceGroupName
    )
    Remove-AzVm -Name $Name -ResourceGroupName $ResourceGroupName
}



# Make Scriptblock
$scriptBlock = {
    param ($Name,$ResourceGroupName)
    Remove-MyAzVm -Name $Name -ResourceGroupName $ResourceGroupName
    ## Other stuff here
}

# start as Job (asynchronously)
Start-Job -ScriptBlock $scriptBlock -ArgumentList @($VMName,$ResourceGroupName)

# start synchronously
& $scriptBlock -VMName $VMName -ResourceGroupName $ResourceGroupName
