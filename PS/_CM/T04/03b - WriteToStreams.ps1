function Write-ToStreams
{
    [cmdletbinding()]
    Param()
    Begin
    {
        $VerbosePreference = 'Continue'
        $DebugPreference = 'Continue'
    }
    Process
    {
        Write-Host "This is written to host" -ForegroundColor Green
        Write-Output "This is written to Success output"
        Write-Error "This is an error"
        Write-Warning "This is a warning message"
        Write-Verbose "This is verbose output"
        Write-Debug "This is a debug message"
    }
}


## test
Set-Location -Path 'C:\work\PS\_CM\T04'

Write-ToStreams

# write verbose output (stream/pipeline) to file
Write-ToStreams 4> .\verbose.txt
Get-Content -Path .\verbose.txt

<#
1  Success (Output)
2  Error
3  Warning
4  Verbose
5  Debug
6  Information

The * Stream
#>

# capture all streams
Write-ToStreams *> .\All.txt
Get-Content -Path .\All.txt

# write verbose and success to variable(s)
$VerboseMessage = $($Output = Write-ToStreams) 4>&1
$VerboseMessage
$Output

# cleanup
Remove-Item .\All.txt,.\verbose.txt