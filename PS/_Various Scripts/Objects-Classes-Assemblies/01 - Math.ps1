[Math]::Abs(-10.6) 
[Math]::Pow(123, 2) 
[Math]::Sqrt(100)

[Math] | Get-Member -static 
[Math].GetMethods() # math is a static class

[Math].GetMethods() | Select-Object -Property name -Unique | Sort-Object -Property name



