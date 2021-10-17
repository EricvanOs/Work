Set-Location -Path 'K:\_Various Scripts\Pester'    

Invoke-Pester -Output Detailed .\Get-Planet.Tests.ps1

Invoke-Pester -Output Detailed .\Get-Planet.Tests_2.ps1

Invoke-Pester -Output Detailed .\Get-Planet.Tests_3.ps1