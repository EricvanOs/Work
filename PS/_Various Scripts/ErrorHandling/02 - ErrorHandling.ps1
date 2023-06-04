# Terminating Error
ThisCmdlet-DoesNotExist

$error.Count

$error[0]  # The last error

$error[0].Exception

$error[0].Exception.StackTrace


# ErrorAction
Get-ChildItem 'G:\FakeFolder' -ErrorAction Inquire

Get-ChildItem 'G:\FakeFolder' -ErrorAction SilentlyContinue  # be carefull, better don't use  


# Run an external process from PowerShell
robocopy.exe 'C:\DirectoryDoesNotExist' 'C:\NewDestination' '*.*' /R:0

$LASTEXITCODE  # if 0 then success else failure


# non-terminial error

$services =  'BITS','cyz','W32Time'

$services | Get-Service #ErrorAction= 'Continue' (default)

$services | Get-Service -ErrorAction SilentlyContinue

