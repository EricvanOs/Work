# now we add our fragment code



[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
    [string[]]$ComputerName
)
PROCESS {

    foreach ($computer in $computername) {

        $frag1 = Get-AdatumOSInfo -ComputerName $computer |
                 ConvertTo-HTML -Fragment -As List -PreContent "<h2>Basic Info</h2>"

        $frag2 = Get-Service -ComputerName $computer |
                 Select-Object -Property Name,Status,DisplayName |
                 ConvertTo-HTML -Fragment -As Table -PreContent "<h2>Services</h2>"

    } # computer

} # process
