$Path = 'K:\_CM\_Various Scripts\Manipulations'
Set-Location -Path $Path

1..100 | ForEach-Object { Add-Content -Path .\LineNumbers.txt -Value "This is line $_." }

Get-Content -Path .\LineNumbers.txt

Get-Content -Path .\LineNumbers.txt -TotalCount 5

(Get-Content -Path .\LineNumbers.txt -TotalCount 25)[-1]

 Get-Content -Path .\LineNumbers.txt -Tail 1

Set-Content -Path .\Stream.txt -Value 'This is the content of the Stream.txt file'
# Specify a wildcard to the Stream parameter to display all streams of the recently created file.
Get-Item -Path .\Stream.txt -Stream *

Get-Content -Path .\Stream.txt -Stream $DATA


# Use the Stream parameter of Add-Content to create a new Stream containing sample content.
Add-Content -Path .\Stream.txt -Stream NewStream -Value 'Added a stream named NewStream to Stream.txt'
# Use Get-Item to verify the stream was created.
Get-Item -Path .\Stream.txt -Stream *
Get-Content -Path .\Stream.txt -Stream NewStream


$raw = Get-Content -Path .\LineNumbers.txt -Raw
$lines = Get-Content -Path .\LineNumbers.txt
Write-Host "Raw contains $($raw.Count) lines."
Write-Host "Lines contains $($lines.Count) lines."


Get-Content -Path $Path\* -Filter *.txt

$byteArray = Get-Content -Path "$Path\LineNumbers.txt"  -Raw
Get-Member -InputObject $bytearray
$byteArray.Length
$byteArray[0..18]

# cleanup

Get-Item -Path $Path\*  -Include 'LineNumbers.txt','stream.txt' | Remove-Item