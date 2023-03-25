# Verify that the features are NOT currently installed
# on the node we plan to configure.

Invoke-Command -ScriptBlock {
    Get-WindowsFeature -Name print-server,fs-data-deduplication,bits
} -ComputerName LON-SVR1

