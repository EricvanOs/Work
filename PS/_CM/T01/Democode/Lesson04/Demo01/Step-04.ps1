# Now that the module is saved in the correct location,
# we can run the command as if it were a native shell command.

# This verifies that the original syntax works
# Highlight and run just this:
Get-CorpCompSysInfo -hostname LON-CL1,LON-DC1


# Now try pipeline binding by value
# Highlight and run just this:
"LON-CL1","LON-DC1" | Get-CorpCompSysInfo


# Add computer names to a text file and use that
# Highlight and run these two lines:
"LON-DC1","LON-CL1" | Out-File c:\computernames.txt -Force
Get-Content c:\computernames.txt | Get-CorpCompSysInfo


# Set up a CSV file that produces objects having
# a "computername" property, so that we can test
# pipeline binding by property name
# Highlight and run these four lines:
"ComputerName,Comment" | Out-File c:\computers.csv
"LON-DC1,N/A" | Out-File c:\computers.csv -Append
"LON-CL1,Client" | Out-File c:\computers.csv -Append
Import-CSV c:\computers.csv | Get-CorpCompSysInfo


