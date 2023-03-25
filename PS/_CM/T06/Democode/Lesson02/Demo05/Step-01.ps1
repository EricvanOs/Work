# Verify that the features are NOW  installed
# on the nodes we configured.

Invoke-Command -ScriptBlock {
    Get-WindowsFeature -Name print-server,fs-data-deduplication,bits
} -ComputerName LON-SVR1

# Four features should should show "Installed". 
# It may take several minutes for the installation to complete and servers to restart.

