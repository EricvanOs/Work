function Write-Log {
    Param(
        [string]$Folder,
        [string]$File,
        [string]$Data
    )

    #Calculate full path for log files
    $logPath = Join-Path -Path $folder -ChildPath $file
    
    #Calculate time stamp for log entry
    $date = Get-Date
    $timeStamp = $date.ToShortDateString() + ' ' + $date.ToLongTimeString() + ' : '
    
    #Write data to log file
    $timeStamp + $data | Out-File $logPath -Append
}

Set-Location -Path C:\Work\PS\_CM

# test (2*)
Write-Log -Folder . -File TestLog.txt -Data "Test log data" 

Get-Content -Path .\TestLog.txt

# cleanup
Remove-Item -Path .\TestLog.txt

Set-Location -Path c:\
