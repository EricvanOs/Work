# The MOF files should now be in C:\FileAndPrint
# To start deploying those:

Start-DscConfiguration -Path C:\FileAndPrint -Wait -Verbose -Force

# The command will assume the MOF file names are computer names
# and try to deploy each file contained in the path.
# Remoting is used to deploy the files. After deploying
# the file, each node's Local Configuration Manager
# will start applying the file automatically.

# The command usually runs as a background job. Adding -wait
# lets us see it run interactively.

# You can also deploy just some of the files:
#
# PS C:\> Start-DscConfiguration -Path C:\FileAndPrint -ComputerName LON-SVR1
#
# That lets you send an updated configuration to just one computer.
