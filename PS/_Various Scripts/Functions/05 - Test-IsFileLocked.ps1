function Test-IsFileLocked
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Files
    )

    Process
    {
        # Foreach loop to accept arrays either from pipeline or Files parameter
        foreach ($file in $Files)
        {
            $Locked = $false

            try
            {
                # Try to open file
                $Test = [System.IO.File]::Open($file, 'Open', 'ReadWrite', 'None')

                # Close file and dispose object if succeeded
                $Test.Close()
                $Test.Dispose()
            }
            catch
            {
                # File is locked!
                $Locked =  $true
            }

            # Write file status to pipeline
            $Locked
        }
    }
}

# Get-ChildItem $path -Recurse -filter "*EDI*" | WHERE {($_.LastWriteTime -le $(Get-Date).AddDays(-$oldTime)) -and !(Test-IsFileLocked -Files $_.FullName)} | Remove-Item -Force

