function Get-FilewithDebug
{
    [cmdletbinding()]
    Param
    (
        [parameter(Mandatory)]
        [string]$path
    )

    Write-Verbose 'Starting script'
    Write-Debug "`$path is: $path"
    $return = Get-ChildItem -Path $path -Filter *.exe -Recurse -Force
    Write-Debug "`$return has $($return.count) items"
    $return
}


Get-FilewithDebug -path C:\Users\administrator.PANTHEON\Downloads -Verbose -Debug

# set-location C:\Work\PS\_CM\H07B
# Suspend, test variables, and exit to continue


$DebugPreference
Write-Debug "Cannot open file."
$DebugPreference = "Continue"
Write-Debug "Cannot open file."
$DebugPreference = "SilentlyContinue"