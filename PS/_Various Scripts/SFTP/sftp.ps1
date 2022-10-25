# Capture credentials.
sftp2he.cursus@sftp2he.blob.core.windows.net

sLERvL3x2uxAfVgVX8snmmoQlCD/0dxU

$credential = Get-Credential

# Set the options to open the WinSCPSession with
$sessionOption = New-WinSCPSessionOption -HostName sftp2he.blob.core.windows.net -Protocol Scp -Credential $credential -GiveUpSecurityAndAcceptAnySshHostKey

# Open the session using the SessionOptions object.
# New-WinSCPSession sets the PSDefaultParameterValue of the WinSCPSession parameter for all other cmdlets to this WinSCP.Session object.
# You can set it to a variable if you would like, but it is only necessary if you will have more then one session open at a time.
New-WinSCPSession -SessionOption $sessionOption

# Use that session to create a new Directory.
New-WinSCPItem -Path './remoteDirectory' -ItemType Directory

# Upload a file to the directory.
Send-WinSCPItem -Path 'C:\localDirectory\localFile.txt' -Destination '/remoteDirectory/'

# Close and remove the session object.
Remove-WinSCPSession