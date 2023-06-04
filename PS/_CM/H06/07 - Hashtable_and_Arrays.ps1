$hashtable = @{
    Name = "Document"
    PSProvider = "FileSystem"
    Root = "C:\Users\victo\Documents"
}

$array = @("Document", "FileSystem", "C:\Users\victo\Documents")
$array

$hashtable.Values | Out-string 
$hashtable.GetEnumerator() |Foreach-Object{ $_ | Out-String }

$LogNameKeys = @{
    LogName = @("System", "Application", "Security")
}
#Convert the hashtable to a string
$LogNameKeys.Values | Out-String  


