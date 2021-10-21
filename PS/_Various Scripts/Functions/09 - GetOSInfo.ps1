function GetOSInfo 
{
 param 
 (
 [string]$name, 
 [string]$logfile
 )
 try {
 $continue = $True 
 $os = Get-WmiObject Win32_OperatingSystem `
 -computerName $name -ea 'Stop' 
 } catch {
 if ($logFile -ne '') {
 $name | Out-File $logfile -append 
 }
 $continue = $False
 }
 if ($continue) { 
 $bios = Get-WmiObject Win32_BIOS `
 -computername $name
 $obj = New-Object PSObject 
 $obj | Add-Member NoteProperty ComputerName $name
 $obj | Add-Member NoteProperty OSBuild ($os.buildnumber)
 $obj | Add-Member NoteProperty BIOSSerial ($bios.serialnumber)
 $obj | Add-Member NoteProperty LastBoot `
 ($os.ConvertToDateTime($os.lastbootuptime))
 Write-Output $obj 
 } 
}




<# 
.SYNOPSIS 
Retrieves key information from the specified computer(s) 
.DESCRIPTION
Get-OSInfo uses WMI to retrieve information from the 
Win32_OperatingSystem and Win32_BIOS classes. The result 
is a combined object, included translated date/time 
information for the computer's most recent restart. 
.PARAMETER computername 
The computer name, or names, to query.
Listing 25.1 Get-OSInfo and its supporting code, in a script module
Download from Wow! eBook <www.wowebook.com>
Lab solution 279
.PARAMETER logFailures
Include this parameter to have failed computer names 
logged to a file. Specify the filename as the value 
for this parameter. 
.EXAMPLE 
Assuming names.txt contains one computer name per line:
 Get-Content names.txt | Get-OSInfo -log c:\errors.txt 
.EXAMPLE 
Assuming the ActiveDirectory module is available, this 
example retrieves information from all computers in the 
domain:
 Get-ADComputer -filter * | Select -expand name |  Get-OSInfo 
.EXAMPLE 
Just use a single, manually-specified computer:
 Get-OSInfo -computername SERVER-R2 
#> 
function Get-OSInfo 
{
 [CmdletBinding()] 
 param 
 (
 [Parameter(Mandatory=$True,
 ValueFromPipeline=$True,
 ValueFromPipelineByPropertyName=$True)] 
 [Alias('host')] 
 [string[]]$computerName, 
 [string]$logFile = '' 
 )
 
 BEGIN 
 {
 if ($logFile -ne '') { 
 Remove-Item -Path $logFile -ErrorAction 'SilentlyContinue'
 }
 
 }
 
 PROCESS 
 {
 foreach ($name in $computername) { 
 GetOSInfo $name $logFile 
 }
 } 
}


Get-OSInfo