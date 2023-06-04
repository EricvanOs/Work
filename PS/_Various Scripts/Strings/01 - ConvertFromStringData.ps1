# Convert a single-quoted here-string to a hash table
$Here = @'
Msg1 = The string parameter is required.
Msg2 = Credentials are required for this command.
Msg3 = The specified variable does not exist.
'@
ConvertFrom-StringData -StringData $Here


# Convert string data using a different delimiter
$StringData = @'
color|red
model|coupe
year|1965
condition|mint
'@
ConvertFrom-StringData -StringData $StringData -Delimiter '|'


# Convert a here-string containing a comment
ConvertFrom-StringData -StringData @'
Name = Disks.ps1

# Category is optional.

Category = Storage
Cost = Free
'@


# Convert a string to a hash table
ConvertFrom-StringData -StringData "Top = Red `nBottom = Blue"

