$StorageURL = "https://<storagename>.blob.core.windows.net/STORAGE_CONTINER/"
$FileName = "<filename>"
$SASToken = "st=2020-03-10T23%3A19%3A17Z&se=2020-03-11T23%3A19%3A17Z&sp=rl&sv=2018-03-28&sr=b&sig=RANDOMCHARS"

$blobUploadParams = @{
    URI = "{0}/{1}?{2}" -f $StorageURL, $FileName, $SASToken
    Method = "PUT"
    Headers = @{
        'x-ms-blob-type' = "BlockBlob"
        'x-ms-blob-content-disposition' = "attachment; filename=`"{0}`"" -f $FileName
        'x-ms-meta-m1' = 'v1'
        'x-ms-meta-m2' = 'v2'
    }
    Body = $Content
    Infile = $FileToUpload
}

# NOTE: Be sure to replace <storagename> found in line 1 and <filename> found in line 2.