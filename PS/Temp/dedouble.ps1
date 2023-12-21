$directory = "C:\Your\Directory\Path" 

# Get all files in the directory
$files = Get-ChildItem -Path $directory

# Group files by content
$groupedFiles = $files | Group-Object -Property {
    Get-FileHash $_.FullName | Select-Object -ExpandProperty Hash
}

# Iterate through each group of files with the same content
foreach ($group in $groupedFiles) {
    if ($group.Count -gt 1) {
        Write-Host "Deleting duplicates for content hash: $($group.Name)"
        
        # Skip the first file in the group (keeping one copy)
        foreach ($file in $group.Group | Select-Object -Skip 1) {
            Remove-Item $file.FullName -Force
            Write-Host "Deleted: $($file.FullName)"
        }
    }
}
