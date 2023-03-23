Notepad

# Retrieve a reference to the instance of System.Diagnostics.Process that represents the running copy of Windows Notepad.
$note = Get-Process -Name Notepad

# Terminate the Windows Notepad process.
$note.kill()

$note | Get-Member


#Create a new instance of the System.Data.SqlClient.SqlConnection class. 
$conn = New-Object -TypeName System.Data.SqlClient.SqlConnection

# Display the members of the instance.
$conn | Get-Member

# Set the connection string 
$conn.ConnectionString = "Server=Echo;Database=AdventureWorks;Trusted_Connection=True;"

# Display a list of the connection's properties and their values.
$conn | Format-List -Property *


