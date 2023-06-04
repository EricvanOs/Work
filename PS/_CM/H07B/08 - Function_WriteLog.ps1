function Write-Log {
    Param(
        [string]$Folder,
        [string]$File,
        [string]$Data
    )

    #Create full path for log files
    $logPath = Join-Path -Path $folder -ChildPath $file
    
    #Create time stamp for log entry
    $date = Get-Date
    $timeStamp = $date.ToShortDateString() + ' ' + $date.ToLongTimeString() + ' : '
    
    #Write data to log file
    $timeStamp + $data | Out-File $logPath -Append
}

Set-Location -Path C:\Work\PS\_CM

# test 
Write-Log -Folder . -File TestLog.txt -Data "Test log data" 
Write-Log -Folder . -File TestLog.txt -Data "Test log data again" 

Get-Content -Path .\TestLog.txt

# cleanup
Remove-Item -Path .\TestLog.txt

Set-Location -Path C:\
