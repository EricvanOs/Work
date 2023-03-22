# we will build this to look like an advanced function
# however, without the Function keyword, we can just
# run the script and pass parameters to it.

[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
    [string[]]$ComputerName
)
PROCESS {

    foreach ($computer in $computername) {



    } # computer

} # process
