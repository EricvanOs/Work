$documents_path = 'C:\Work\PS\_Various Scripts\Office'

$wordFormatPDF = 17
$word_app = New-Object -ComObject Word.Application
$word_app.visible = $false

# This filter will find .doc as well as .docx documents
Get-ChildItem -Path $documents_path -Filter *.doc? | ForEach-Object {

    $document = $word_app.Documents.Open($_.FullName)

    $pdf_filename = "$($_.DirectoryName)\$($_.BaseName).pdf"

    $document.SaveAs([ref] $pdf_filename, [ref] $wordFormatPDF)

    $document.Close()
}

$word_app.Quit()


#  cleanup

Get-ChildItem -Path $documents_path -Filter *.pdf | Remove-Item 


