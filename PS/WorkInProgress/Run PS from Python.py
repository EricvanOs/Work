import subprocess;
process=subprocess.Popen(["powershell","Get-ComputerInfo | select -ExpandProperty OsName"],stdout=subprocess.PIPE);
result=process.communicate()[0]
print ("Our current operating system is:- "+result.decode('utf-8'))

> Output:- Our current operating system is:- Microsoft Windows 11 Home




import subprocess;
process=subprocess.Popen(["powershell","calc.exe"]);
result=process.communicate()[0]
print (result)

import subprocess;
process=subprocess.Popen(["powershell","notepad.exe"]);
result=process.communicate()[0]
print (result)
