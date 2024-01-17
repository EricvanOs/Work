param($ComputerName='.')

Get-CIMInstance -computername $computername Win32_Volume -filter "DriveType=3" | ForEach-Object {

    new-object PSObject -property @{

    UsageDate = $((Get-Date).ToString(“yyyy-MM-dd”))

    SystemName = $_.SystemName

    Label = $_.Label

    VolumeName = $_.Name

    Size = $([math]::round(($_.Capacity/1GB),2))

    Free = $([math]::round(($_.FreeSpace/1GB),2))

    PercentFree = $([math]::round((([float]$_.FreeSpace/[float]$_.Capacity) * 100),2))

}

} | Select-Object UsageDate, SystemName, Label, VolumeName, Size, Free, PercentFree
