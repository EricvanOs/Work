#Set the value for a variable
$logFile = 'K:\_CM\H07\Logs\log.txt'

#Test whether a variable contains specific text, niet de inhoud van de file!
$logFile.Contains('K:')
$logFile.Contains('D:')

#Insert text into a variable value
#Note that the original variable value is not modified
#Output must be caputured to update the value
$logFile.Insert(6,'\MyScript')
$logFile
$logFile=$logFile.Insert(6,'\MyScript')
$logFile

#Replace text in a variable value
$logFile.Replace('.txt','.htm')

#Split a string into parts based on a separator
$logFile.Split('\')
$logFile.Split('\') | Select-Object -Last 1

#Convert a string to upper or lowercase
#Parentheses are required for a method even when
#no value is specified
$logFile.ToUpper()
$logFile.ToLower()


$logFile | Get-Member -MemberType Method




