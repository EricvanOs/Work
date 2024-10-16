﻿
#Set-ExecutionPolicy unrestricted -Force
#Enable-PSRemoting -Force

#uses https://www.powershellgallery.com/packages/xWebAdministration/2.4.0.0
Install-Module -Name xWebAdministration

Configuration HRWebsiteOnPremise
{
    param
    (
        # Target nodes to apply the configuration
        [string[]]$NodeName = 'localhost'
    )
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    # Import the module that defines custom resources
    Import-DscResource -Module xWebAdministration
    Node $NodeName
    {
        # Install the IIS role
        WindowsFeature IIS
        {
            Ensure          = "Present"
            Name            = "Web-Server"
        }
        #Install ASP.NET 4.5
        WindowsFeature ASPNet45
        {
          Ensure = “Present”
          Name = “Web-Asp-Net45”
        }
        # Stop the default website
        xWebsite DefaultSite
        {
            Ensure          = "Present"
            Name            = "Default Web Site"
            State           = "Stopped"
            PhysicalPath    = "C:\inetpub\wwwroot"
            DependsOn       = "[WindowsFeature]IIS"
        }
        # Copy the website content
        File WebContent
        {
            Ensure          = "Present"
            SourcePath      = "C:\Source\HRSite"
            DestinationPath = "C:\inetpub\HRSite"
            Recurse         = $true
            Type            = "Directory"
            DependsOn       = "[WindowsFeature]AspNet45"
        }
        # Create a new website
        xWebsite HRSite
        {
            Ensure          = "Present"
            Name            = "HRSite"
            State           = "Started"
            PhysicalPath    = "C:\inetpub\HRSite"
            DependsOn       = "[File]WebContent"
        }
    }
}

#Create the MOF
HRWebsite -NodeName localhost

#Apply the configuration
Start-DscConfiguration -Path .\HRWebsite -Wait -Verbose

#Test
$IE=new-object -com internetexplorer.application
$IE.navigate2("127.0.0.1")
$IE.visible=$true

#View the configuration
Get-DscConfiguration

#Remove if wanted but does not roll back the changes
Remove-DscConfigurationDocument -Stage Current
Remove-WindowsFeature -Name Web-Server
Remove-Item -Path C:\inetpub\*.* -Recurse -Force