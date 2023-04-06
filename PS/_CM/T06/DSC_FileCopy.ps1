Configuration MyTestFileConfig
{
    # A Configuration block can have zero or more Node blocks
    Node "localhost"
    {
        # Resource Block

        # File is a built-in resource you can use to manage files and directories
        # This example ensures files from the source directory are present in the destination directory
        File MyFileExample
        {
            Ensure = "Present"                  # You can also set Ensure to "Absent"
            Type = "Directory"                  # Default is "File" but this tells it to look at entire folder
            Recurse = $true                     # Check all subfolders and content
            MatchSource = $true                 # Check for new files as part of the source
            SourcePath = "D:\Temp\Source"       # This is a path that has source files
            DestinationPath = "D:\Temp\Target"  # The path where we want to ensure the files are present
        }

    }
}


MyTestFileConfig -OutputPath 'C:\DSC\Configurations\'                 # Creates the MOF file to be used by DSC

Start-DscConfiguration -Path 'C:\DSC\Configurations\' -Wait -Verbose  # Applies the configuration

Get-DscConfiguration # Checks the current applied configuration


