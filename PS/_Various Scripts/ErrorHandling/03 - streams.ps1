What Exactly Are Streams
<#
The output from a given command can be directed into different streams, think of channels, that can be acted upon later. 
By default, output that is not explicitly redirected will go to the success stream. 
So what exactly are the available streams?

  1  Success (Output)
  2  Error
  3  Warning
  4  Verbose
  5  Debug
  6  Information

The * Stream
#>

<#
    >, sends a specified stream to a file
    >>, appends a specified stream to a file
    >&1, redirects the specified stream to the success stream
   2>&1, redirects also errors to success stream
#>

​# Retrieve both the C:\ directory and then a Fakepath relative to the current directory
# Success output will be directed test.txt
# If an error is encountered, direct that to the success stream, and then to test.txt
Set-Location -Path K:\Temp
Get-ChildItem "C:\","Fakepath" 2>&1 > .\test.txt
Get-Content -Path .\test.txt
Remove-Item -Path .\test.txt


# Redirect Write-Host output to the log.txt file
Write-Host "Log Text" 6>> .\log.txt
Get-Content -Path .\log.txt
# Redirect the Write-Information output to the log.txt file
Write-Information "Log Text" -InformationAction 'Continue' 6>> .\log.txt
Get-Content -Path .\log.txt


#Redirect All Script Output to a File
Get-Service -Name xyz,bits *> log.txt
Get-Content -Path .\log.txt
Remove-Item -Path .\log.txt

# Only redirects output stream data
 Get-ChildItem > $null
# Truly redirect all output to $null
Get-Childitem *> $null

