function Get-WebPageImages($url, $folder) {
    Import-Module BitsTransfer
    if (-not (Test-Path $folder)) { New-Item -Path $folder -ItemType Directory}

    $ie = New-Object -COMObject InternetExplorer.Application
    $ie.Navigate($url)
    while ($ie.Busy) { Start-Sleep -Milliseconds 400 }
    $sources = $ie.document.getElementsByTagName('img') | Select-Object -ExpandProperty src 
    $destinations = $sources | ForEach-Object { "$folder\$($_.Split('/')[-1])" }
    $displayname = $url.Split('/')[-1]
    $ie.Quit()
    Start-BitsTransfer $sources $destinations -Prio High -Display $displayname
}

# To start downloading the images, use it like this:
Get-WebPageImages 'http://www.powershell.com' 'd:\webimages'



$edge = Start-Process  -FilePath microsoft-edge:// 