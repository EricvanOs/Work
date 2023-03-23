# combine and output the fragments


[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
    [string[]]$ComputerName,

    [Parameter(Mandatory=$True)]
    [string]$ReportFolderPath
)
BEGIN {
    if (-not (Test-Path $ReportFolderPath)) {
        New-Item -Path $ReportFolderPath -ItemType Directory -ErrorAction Stop
    }
} # begin
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

        $reportfile = Join-Path -Path $ReportFolderPath -ChildPath "$computer.html"

        ConvertTo-HTML -Title "Report for $computer" `
                       -Head $style `
                       -Body "<h1>Report for $computer</h1>",$frag1,$frag2 |
        Out-File $reportfile

    } # computer

} # process
