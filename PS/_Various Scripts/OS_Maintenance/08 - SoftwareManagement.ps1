# Software management

# Install an MSI package on a remote computer:
(Get-WMIObject -ComputerName TARGETMACHINE -List | 
  Where-Object -FilterScript {$_.Name -eq "Win32_Product"}).Install(\\MACHINEWHEREMSIRESIDES\path\package.msi)
  
# Upgrade an installed application with an MSI-based application upgrade package:
(Get-WmiObject -Class Win32_Product -ComputerName . -Filter "Name='name_of_app_to_be_upgraded'").Upgrade(\\MACHINEWHEREMSIRESIDES\path\upgrade_package.msi)

# Remove an MSI package from the current computer:
(Get-WmiObject -Class Win32_Product -Filter "Name='product_to_remove'" -ComputerName . ).Uninstall()
