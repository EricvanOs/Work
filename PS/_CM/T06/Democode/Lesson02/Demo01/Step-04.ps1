Set-WSManQuickConfig -Force
Set-DscLocalConfigurationManager -Path .\AdatumLCMConfig -ComputerName localhost
Get-DscLocalConfigurationManager

