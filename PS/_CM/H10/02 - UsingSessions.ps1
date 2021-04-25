# 1
$dc = New-PSSession -ComputerName sisyphus

# 2
$all = New-PSSession -ComputerName sisyphus,tantalus

# 3
Get-PSSession

# 4
$dc

# 5
Enter-PSSession -Session $dc


# 6
Get-Process

# 7
Exit-PSSession

# 8
Get-PSSession
Get-PSSession -Id $dc.Id |  Remove-PSSession   
# of $dc | remove-pssession


# 9
Invoke-Command -Session $all -ScriptBlock { Get-Service | Where-object { $_.Status -eq 'Running' }}

# 
Get-PSSession

#  remove all sessions
Get-PSSession | Remove-PSSession





