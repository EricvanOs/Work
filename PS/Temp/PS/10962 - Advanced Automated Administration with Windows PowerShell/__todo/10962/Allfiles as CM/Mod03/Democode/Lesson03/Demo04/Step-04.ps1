# let's add a parameter that accepts a
# folder for the report files to go into


[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
    [string[]]$ComputerName,

    [Parameter(Mandatory=$True)]
    [string]$ReportFolderPath
)
PROCESS {

    foreach ($computer in $computername) {

        $frag1 = Get-AdatumOSInfo -ComputerName $computer |
                 ConvertTo-HTML -Fragment -As List -PreContent "<h2>Basic Info</h2>" |
                 Out-String

        $frag2 = Get-Service -ComputerName $computer |
                 Select-Object -Property Name,Status,DisplayName |
                 ConvertTo-HTML -Fragment -As Table -PreContent "<h2>Services</h2>" |
                 Out-String

        $style = Get-AdatumStyleSheet

    } # computer

} # process
