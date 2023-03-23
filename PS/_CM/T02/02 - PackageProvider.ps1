# RUN THIS AS ADMINISTRATOR, has already been done

# sometimes needed
Find-PackageProvider -Name nuget.org | Install-PackageProvider -Force

#Then we need to register the package source:
Register-PackageSource -Name nuget.org -Location https://www.nuget.org/api/v2 -ProviderName NuGet

# test registrations
Get-PackageSource

# Find and install package eg YamlDotNet, can take while
Find-Package -Name YamlDotNet -ProviderName NuGet | Install-Package

# installed at C:\Program Files\PackageManagement\NuGet\Packages\YamlDotNet.13.0.2