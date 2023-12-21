$a2 = Invoke-WebRequest -Uri 'https://learn.microsoft.com/en-us/training/modules/enable-containers-security/2-explore-containers'

$a2 | Get-Member

$a2.StatusCode

$a2.Content |  Out-File -FilePath 'c:\tmp\a2.html'



<html>
<body>
<!-- <content> -->


F9
crtl P
enter
enter
F9


F9
crl A
crtl C
word
crtl V
save as docx


# beter parsen html-file

$a2.BaseResponse

$a2.Headers

$a2.Images

$a2.




--------------
linkje save
open in firefox
CRTL+A ;; CRTL+C