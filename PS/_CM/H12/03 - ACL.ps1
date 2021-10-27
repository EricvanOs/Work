#Create new folder
$newfolder = 'K:\testacl'
New-Item $newfolder -ItemType Directory

#view acl for new folder
$acl = Get-Acl $newfolder
$acl
$acl.AccessToString
$acl.Access

#View all properties and methods for an ACL
$acl | Get-Member

# Set the folder to disable inherited permissions
# and remove inherited permissions
$acl.SetAccessRuleProtection($true,$false)

#Create a new rule that gives JdeJong Full Control
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("JdeJong","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")

#Add the rule to the ACL
$acl.AddAccessRule($rule)

#Apply the new ACL
Set-ACL $newfolder -AclObject $acl

#Verify that permissions were modified
Get-Acl $newfolder | Format-List

# cleanup
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("pantheon\administrator","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
$acl.AddAccessRule($rule)
Set-ACL $newfolder -AclObject $acl
Remove-Item -Path $newfolder -Force