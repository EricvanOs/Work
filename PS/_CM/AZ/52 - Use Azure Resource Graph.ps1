function Find-AzureVMFromComputerName
{

    Param (
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true)]
        [String[]]
        $ComputerName
    )

    Import-Module Az.ResourceGraph

    $statusGood = $true

    $GraphSearchQuery = @"
    Resources
        | where type =~ 'Microsoft.Compute/virtualMachines'
        | where properties.osProfile.computerName =~ '$ComputerName'
        | join (ResourceContainers | where type=='microsoft.resources/subscriptions' | project SubName=name, subscriptionId) on subscriptionId
        | project VMName = name, CompName = properties.osProfile.computerName, RGName = resourceGroup, SubName, SubID = subscriptionId
"@
    try {
        $VMresource = Search-AzGraph -Query $GraphSearchQuery
    }
    catch {
        $statusGood = $false
        Write-Error "Failure running Search-AzGraph, $_"
    }

    if($statusGood -and ($null -ne $VMresource))
    {
        $ValueObject= [PSCustomObject]@{"Status"="Success";"ComputerName"="$ComputerName";"VMName"="$($VMresource.VMName)";"ResourceGroup"="$($VMresource.RGName)";"Subscription"="$($VMResource.SubID)"}
        $ValueJSON = ConvertTo-Json($ValueObject)
    }
    elseif ($statusGood -and ($null -eq $VMresource))
    {
        $ValueJSON = "{`"Status`": `"Computer name not found`"}"
    }
    else
    {
        $ValueJSON = "{`"Status`": `"Failed`"}"
    }

    return $ValueJSON
}


# login and set context
Set-AzContext -SubscriptionId (Get-AzSubscription -TenantId ((Connect-AzAccount).Context.Tenant)).Id

# test
$computername = 'ion2he'
Find-AzureVMFromComputerName -ComputerName $computername


