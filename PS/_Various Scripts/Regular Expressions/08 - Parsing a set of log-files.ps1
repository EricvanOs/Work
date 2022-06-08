$path = '\\morpheus\c$\inetpub\logs\LogFiles\W3SVC1'

get-childitem -path $path -filter *.log 
    | select-object -First 10
    | select-string -pattern "\s40[0-9]\s" 
    | format-table Filename,LineNumber,Line -wrap



get-childitem -path $path -filter *.log 
    | select-object -first 60
    | Select-string -pattern "10\.0;[\w\W]+\+Gecko" 
    | format-table Filename,LineNumber,Line -wrap


