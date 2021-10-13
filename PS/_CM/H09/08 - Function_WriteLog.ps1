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

# test (2*)
New-PSDrive -Name K -Root C:\Work\PS -PSProvider FileSystem  

Write-Log -Folder k:\_cm -File TestLog.txt -Data "Test log data" 

# cleanup
Remove-Item -Path K:\_cm\TestLog.txt

Set-Location -Path c:\
Remove-PSDrive K