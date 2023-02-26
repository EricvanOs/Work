Set-Location -Path C:\Work\PS\Temp

# Add a note property to a PSObject
$A = Get-ChildItem .\MyTest.txt
$A | Add-Member -NotePropertyName Status -NotePropertyValue Done
$A | Get-Member
$A.Status


# Add an alias property to a PSObject
$A = Get-ChildItem .\MyTest.txt
$A | Add-Member -MemberType AliasProperty -Name Size -Value Length
$A.Size


# Add a StringUse note property to a string
$A = "A string"
$A = $A | Add-Member -NotePropertyMembers @{StringUse="Display"} -PassThru
$A.StringUse


# Add a script method to a FileInfo object
$A = Get-ChildItem .\MyTest.txt
$S = {[math]::Round(($this.Length / 1MB), 2)}
$A | Add-Member -MemberType ScriptMethod -Name "SizeInMB" -Value $S
$A.SizeInMB()


# Create a custom object
$Asset = New-Object -TypeName PSObject
$d = [ordered]@{Name="Server30";System="Server Core";PSVersion="4.0"}
$Asset | Add-Member -NotePropertyMembers $d -TypeName Asset
$Asset.PSObject.Properties | Select-Object Name, Value