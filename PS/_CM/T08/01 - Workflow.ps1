#requires -version 4.0

workflow Get-FolderSize {
    param(
        [String[]]$Path
    )

    # enumerate paths we have been given
    foreach -parallel ($folder in $path) {

        # get first-level child folders
        $childfolders = Get-ChildItem -Path $folder -Directory

        # enumerate child folder
        foreach -parallel ($childfolder in $childfolders) {

            # add the size of all files in the child folder hierarchy
            $size = Get-ChildItem -Path $childfolder.fullname -Recurse -File |
                    Measure-Object -Property length -Sum |
                    Select-Object -ExpandProperty Sum

            # empty trees will return nothing; make sure that becomes zero
            if ($size -eq $null) { $size = 0 }

            Write-Output -InputObject (
                New-Object -TypeName PSObject -Property @{'Path'=$childfolder.fullname;
                                                          'Size'=$size}
            )

        } #foreach childfolder

    } #foreach path

} #workflow

Get-FolderSize -Path c:\users

