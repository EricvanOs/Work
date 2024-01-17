function Get-FilewithDebug
{
    [cmdletbinding()]
    Param
    (
        [parameter(Mandatory)]
        [string]$path
    )

    Write-Output "Start of function" 
    Write-Verbose 'Starting script'
    Write-Debug "`$path is: $path"
    $return = Get-ChildItem -Path $path -Filter *.exe -Recurse -Force
    Write-Debug "`$return has $($return.count) items"
    Write-Output "End of function `r`n"
    $return
}

Set-Location -Path C:\Work\PS\_CM\T07


Get-FilewithDebug -path C:\Users\administrator.PANTHEON\Downloads -Verbose
Start-Sleep -Seconds 5
Get-FilewithDebug -path C:\Users\administrator.PANTHEON\Downloads -Debug
Start-Sleep -Seconds 5
Get-FilewithDebug -path C:\Users\administrator.PANTHEON\Downloads -Verbose -Debug


# run ps1-file 
