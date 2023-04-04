# https://github.com/mkellerman/Invoke-CommandAs

# Execute Locally.
Invoke-CommandAs -ScriptBlock { Get-Process }

# Execute As System.
Invoke-CommandAs -ScriptBlock { Get-Process } -AsSystem

# Execute As a GMSA.
Invoke-CommandAs -ScriptBlock { Get-Process } -AsGMSA 'domain\gmsa$'

# Execute As Credential of another user.
Invoke-CommandAs -ScriptBlock { Get-Process } -AsUser $Credential

# Execute As Interactive session of another user.
Invoke-CommandAs -ScriptBlock { Get-Process } -AsInteractive 'username'


# You can execute all the same commands as above against a remote machine.
# Use -ComputerName/Credential or -Session to authenticate

# Execute Remotely using ComputerName/Credential.
Invoke-CommandAs -ComputerName 'VM01' -Credential $Credential -ScriptBlock { Get-Process }

# Execute Remotely using Session.
Invoke-CommandAs -Session $PSSession -ScriptBlock { Get-Process }

# Execute Remotely using PSSession and execute ScriptBlock as SYSTEM.
Invoke-CommandAs -Session $PSSession -ScriptBlock { Get-Process } -AsSystem

# Execute Remotely on multiple Computers at the same time.
Invoke-CommandAs -ComputerName 'VM01', 'VM02' -Credential $Credential -ScriptBlock { Get-Process }

# Execute Remotely as Job.
Invoke-CommandAs -Session $PSSession -ScriptBlock { Get-Process } -AsJob