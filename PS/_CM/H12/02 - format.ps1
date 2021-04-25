#An index number indicates which item is used for replacement
'File name: {0} File size: {1}' -f 'Test.txt',20023.34587
'File name: {1} File size: {0}' -f 'Test.txt',20023.34587

# maw {0} en {1} zijn de index numbers 
# zelfs dit mag (onzin in dit geval)
'File name: {0} File size: {0}' -f 'Test.txt',20023.34587


#You can define alignment for the items, maw {index,alignment}
'File name: {0,-15} File size: {1,12}' -f 'Test.txt',20023.34587


#You can use different format strings
'File name: {0,-15} File size: {1,12:f2}' -f 'Test.txt',  20023.34587
'File name: {0,-15} File size: {1,12:n2}' -f 'Test1.txt', 20023.34587
'File name: {0,-15} File size: {1,12:c}'  -f 'Test12.txt',20023.34587

#You can also build custom date/time formats
#The same index number is used multiple times
'{0,2:hh}:{0,2:mm}' -f (Get-Date)