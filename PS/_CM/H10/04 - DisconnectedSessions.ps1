# 1
$dc = New-PSSession -ComputerName sisyphus

# 2
Disconnect-PSSession -Session $dc

# 3
Get-PSSession -ComputerName sisyphus

# 4
Get-PSSession -ComputerName sisyphus | Connect-PSSession

# 5
$dc 
# confirm that the session is available

# 6
Remove-PSSession -Session $dc






