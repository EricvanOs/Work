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

# use vscode
# add breakpoint at row 9,16 and 25(click/Toggle Break Point (F9))
# start with debugging (F5)

Set-Location -Path C:\Work\PS\_CM

Write-Log -Folder . -File TestLog.txt -Data "Test log data" 

Get-Content -Path .\TestLog.txt
# cleanup
Remove-Item -Path .\TestLog.txt

Set-Location -Path c:\
