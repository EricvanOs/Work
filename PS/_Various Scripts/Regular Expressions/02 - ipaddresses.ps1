$regex = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'


'192.168.82.12' -match $regex
'192.168.8212'  -match $regex  #false

'a192.168.82.12'  -match $regex #false word boundary \b
'a 192.168.82.12' -match $regex
