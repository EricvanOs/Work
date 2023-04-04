#Requires -Version 6.0

# Require that AzureRM.Netcore (version 0.12.0 or greater) is installed.
#Requires -Modules @{ ModuleName="AzureRM.Netcore"; ModuleVersion="0.12.0" }


# Require that AzureRM.Netcore (only version 0.12.0) is installed.
#Requires -Modules @{ ModuleName="AzureRM.Netcore"; RequiredVersion="0.12.0" }


# Requires that AzureRM.Netcore (version 0.12.0 or lesser) is installed.
#Requires -Modules @{ ModuleName="AzureRM.Netcore"; MaximumVersion="0.12.0" }


# Require that any version of AzureRM.Netcore and PowerShellGet is installed.
#Requires -Modules AzureRM.Netcore, PowerShellGet


#Requires -Assembly path\to\foo.dll

#Requires -Assembly "System.Management.Automation, Version=3.0.0.0,Culture=neutral, PublicKeyToken=31bf3856ad364e35"


#Requires -PSEdition Core

#Requires -RunAsAdministrator
