﻿Set-Location -Path C:\work\PS\_CM\T02

$source = Get-Content -Path '.\Calculator.cs'
Add-Type -TypeDefinition "$source"

# Call a static method
[Calculator]::Add(4, 3)

[Calculator] | Get-Member -Static



