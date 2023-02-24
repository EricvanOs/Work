Set-Location -Path C:\Work

#Our source File:
$file = "C:\Work\SomeData.txt"

#Get the File-Name without path
$name = (Get-Item $file).Name

#The target URL with SAS Token
$storageaccount = 'storage2he'
$container = 'test'
$SASKey = 'sp=racwdl&st=2021-05-02T10:52:55Z&se=2026-05-02T18:52:55Z&spr=https&sv=2020-02-10&sr=c&sig=82%2BkNHUXSivZy2fLmt6TB2KqfPe2gi%2FK6TcQYttR7Xw%3D'
$uri = "https://$($storageaccount).blob.core.windows.net/$($container)/$($name)?$($SASkey)"

#Define required Headers
$headers = @{
    'x-ms-blob-type' = 'BlockBlob'
}

#Upload file
Invoke-RestMethod -Uri $uri -Method Put -Headers $headers -InFile $name

#Upload file again 
Invoke-RestMethod -Uri $uri -Method Put -Headers $headers -InFile $name # automatic override will take place

#Download file

#Delete file
Invoke-RestMethod -Uri $uri -Method Delete -Headers $headers -InFile $name   

