# 1
Get-SMBShare | Where-Object Name -like '*$*'

# 2
Get-PhysicalDisk | Where-Object -FilterScript { $PSItem.HealthStatus -eq 'Healthy' } | Select-Object -Property FriendlyName,OperationalStatus

# 3
Get-PhysicalDisk | Where-Object -FilterScript { $PSItem.HealthStatus -eq 'Healthy' } | 
    Select-Object -Property FriendlyName,OperationalStatus,DriveLetter,FileSystemLabel,DriveType,FileSystem | Format-List

# 4
Get-Verb | Where-Object { $_.Verb -like 'c*' } | Format-Wide



