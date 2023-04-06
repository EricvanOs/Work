Get-AppxPackage | where-Object{$_.PackageFullname -like "*builder*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*camera*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*windowscommunicationsapps*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*officehub*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*skypeapp*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*getstarted*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*zunemusic*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*windowsmaps*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*candy*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*messaging*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*zunevideo*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*onenote*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*people*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*twitter*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*sports*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*phone*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*sway*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*soundRecorder*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*photo*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*weather*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*skypeapp*"} | Remove-AppxPackage

Get-AppxPackage | where-Object{$_.PackageFullname -like "*photo*"} | Remove-AppxPackage
