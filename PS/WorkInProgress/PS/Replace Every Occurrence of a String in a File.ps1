
(Get-Content C:\Scripts\test.txt) -replace 'mystring', 'hello' | Set-Content C:\Scripts\test.txt




(Get-Content C:\Scripts\test.txt).Replace('mystring', 'hello') | Set-Content C:\Scripts\test.txt



$content = [System.IO.File]::ReadAllText("C:\Scripts\test.txt").Replace("mystring","hello")
[System.IO.File]::WriteAllText("C:\Scripts\test.txt", $content)



(Get-Content C:\Scripts\test.txt) | Foreach-Object {$_ -replace 'mystring','hello'} | Set-Content C:\Scripts\test.txt
