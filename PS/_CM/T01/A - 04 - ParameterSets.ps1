Function Get-DiskCheck {
    [cmdletbinding(DefaultParameterSetName = "name")]
    Param(
        [Parameter(
        Position = 0,
        Mandatory,
        HelpMessage = "Enter a computer name to check",
        ParameterSetName = "name",
        ValueFromPipeline
        )]
        [Alias("cn")]
        [ValidateNotNullorEmpty()]
        [string[]]$Computername,

        [Parameter(
        Mandatory,
        HelpMessage = "Enter the path to a text file of computer names",
        ParameterSetName = "file"
        )]
        [ValidateScript( {if (Test-Path $_) {
            $True
            }
            else {
            Throw "Cannot validate path $_"
            }
            }
        )]
        [ValidatePattern("\.txt$")]
        [string]$Path,

        [ValidateRange(10, 50)]
        [int]$Threshhold = 25,

        [ValidateSet("C:", "D:", "E:", "F:")]
        [string]$Drive = "C:",

        [switch]$Test
    )
}


Get-DiskCheck -Computername Hydra -Threshhold 30 -Test 
Get-DiskCheck -Path 'C:\work\MyTranscript.txt' -Threshhold 30
