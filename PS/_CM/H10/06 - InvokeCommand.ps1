Get-Help *adapter*

Get-Help Get-NetAdapter

Invoke-Command -ComputerName sisyphus,hydra -ScriptBlock { Get-NetAdapter -Physical }


# membertype info

Get-Process | Get-Member

# Deserialized object (alle properties, maar geen methods (behalve gettype en tostring))
Invoke-Command -ComputerName hydra -ScriptBlock { Get-Process } | Get-Member

