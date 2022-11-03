# Install-Module -Name WinSCP 

Get-Command -Module WinSCP

# Capture credentials.
$Hostname = 'sftp2he.blob.core.windows.net'
$FTPUsername = 'sftp2he.cursus' 
$FTPPwd = 'sLERvL3x2uxAfVgVX8snmmoQlCD/0dxU'
$Password = ConvertTo-SecureString $FTPPwd -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($FTPUsername, $Password)


$sessionOption = New-WinSCPSessionOption -HostName $Hostname -Protocol Sftp -Credential $credential
$SshHostKeyFingerprint = Get-WinSCPHostKeyFingerprint -SessionOption $sessionOption -Algorithm SHA-256


# Set the options to open the WinSCPSession with
$sessionOption = New-WinSCPSessionOption -HostName $Hostname -Protocol Sftp -Credential $credential -SshHostKeyFingerprint  $SshHostKeyFingerprint

# Open the session using the SessionOptions object.
# New-WinSCPSession sets the PSDefaultParameterValue of the WinSCPSession parameter for all other cmdlets to this WinSCP.Session object.
# You can set it to a variable if you would like, but it is only necessary if you will have more then one session open at a time.
$WinSCPSession =  New-WinSCPSession -SessionOption $sessionOption 

# list items
Get-WinSCPChildItem -WinSCPSession $WinSCPSession

# Create a new Directory. (no rights)
New-WinSCPItem -Path './remoteDirectory' -ItemType Directory

# Upload a file to the directory (no rights)
Send-WinSCPItem -Path 'C:\localDirectory\localFile.txt' -Destination '/remoteDirectory/'

# get a file
Receive-WinSCPItem -WinSCPSession $WinSCPSession -RemotePath '/Folder2/ReadMe.txt' -LocalPath C:\Temp
# Close and remove the session object.

Remove-WinSCPSession -WinSCPSession $WinSCPSession


