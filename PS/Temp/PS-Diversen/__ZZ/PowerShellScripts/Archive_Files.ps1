$csvPath = "\\cyg7041\EvalData\*.*"
$ArchivePath = "\\cyg7041\EvalData\Archive"

Move-Item -Path $csvPath -Destination $ArchivePath -Force -Confirm:$false