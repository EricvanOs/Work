# Importing and Exporting Data to various file formats
# Start by making some students

class Student {
    [string]$firstName=""
    [string]$lastName=""
    [int]$score=3
    [System.DateTime]$birthday
    Student ([string]$firstName,[string]$lastName,[int]$score,[int]$day,[int]$month,[int]$year) {
        $this.firstName = $firstName
        $this.lastName = $lastName
        $this.score = $score
        $this.birthday = (get-date -Minute 0 -Second 0 -Millisecond 0 -Hour 0 -Year $year -Day $day -Month $month)
    }
    Student ([string]$firstName,[string]$lastName,[int]$score,[int]$day,[int]$month) {
        $this.firstName = $firstName
        $this.lastName = $lastName
        $this.score = $score
        $this.birthday = (get-date -Minute 0 -Second 0 -Millisecond 0 -Hour 0 -Year 2003 -Day $day -Month $month)
    }
    Student ([string]$firstName,[string]$lastName,[int]$score,[System.DateTime]$birthday) {
        $this.firstName = $firstName
        $this.lastName = $lastName
        $this.score = $score
        $this.birthday = $birthday
    }
    Student ([string]$firstName,[string]$lastName) {
        $this.firstName = $firstName
        $this.lastName = $lastName
        $this.score = (Get-Random -Minimum 1 -Maximum 10)
        $this.birthday = (get-date -Minute 0 -Second 0 -Millisecond 0 -Hour 0 -Year 2003 -Day (Get-Random -Minimum 1 -Maximum 28) -Month (Get-Random -Minimum 1 -Maximum 12))
    }
    [string] GetFullName( ) {
        return ("{0} {1}" -f $this.firstName,$this.lastName)
    }
    [string] GetRapportLine( ) {
        return ("{0} {1} - {2}/10" -f $this.firstName,$this.lastName,$this.score)
    }
}
$students = @()
$students += new-object Student("Bob","Sinclair")
$students += new-object Student("Alice","Cooper")
$students += new-object Student("Freddie","Mercury")

# create PSDrive
New-PSDrive -Name 'L' -PSProvider FileSystem -Root 'C:\Work\PS\Temp'
Set-Location -Path L:

# Saving to csv
# Direct export to csv (but export by default to UTF8)
$csvpath = ".\students.csv"
$students | export-csv -path $csvpath -Delimiter "`t" -Encoding Unicode

#Convert to csv
$csvpathc = ".\students-convert.csv"
$students | ConvertTo-Csv -Delimiter ";" 
$students | ConvertTo-Csv -Delimiter "`t" | Out-File -FilePath $csvpathc

# Open excel
explorer $csvpath

#Convert Direct from csv
$importCSVStudents = Import-Csv -Delimiter "`t" -path $csvpath 
$importCSVStudents

#Convert from csv
$convertCSVStudents = get-content -path $csvpathc | convertfrom-csv -Delimiter "`t"
$students | Get-Member
$convertCSVStudents | Get-Member


# Convert to Json
$jsonpath = ".\students.json"
$students | convertto-json
$students | convertto-json | set-content -path $jsonpath


# Convert from Json
$jsonpath = ".\students.json"
$importedJsonStudents = get-content -path $jsonpath | convertfrom-json
$importedJsonStudents | Get-Member

#Convert back to a real student
function Convertto-Student {
process {
    new-object Student($_.firstName,$_.lastName,$_.score,$_.birthday)
}
}
$importedJsonStudents | convertto-student
$importedJsonStudents | convertto-student | Get-Member


# Convert to XML
$xmlpath = ".\students.xml"
$students | convertto-xml
$students | ConvertTo-Xml -As Stream
$students | ConvertTo-Xml -As Stream | set-content -path $xmlpath


# Convert from XML
$xmlpath = ".\students.xml"
[xml]$xmldocument = get-content -path $xmlpath
$xmldocument | Get-Member


# Convert to CLI XML
$xmlclipath = ".\students-cli.xml"
$students | Export-Clixml -path $xmlclipath


# Convert from CLI XML
$xmlclipath = ".\students-cli.xml"
$clistudents = Import-Clixml -Path $xmlclipath
$clistudents | Get-Member


# Adding a static class for converting back. Don't worry about squiggly red lines
class Student {
    [string]$firstName=""
    [string]$lastName=""
    [int]$score=3
    [System.DateTime]$birthday
    Student ([string]$firstName,[string]$lastName,[int]$score,[int]$day,[int]$month,[int]$year) {
        $this.firstName = $firstName
        $this.lastName = $lastName
        $this.score = $score
        $this.birthday = (get-date -Minute 0 -Second 0 -Millisecond 0 -Hour 0 -Year $year -Day $day -Month $month)
    }
    Student ([string]$firstName,[string]$lastName,[int]$score,[int]$day,[int]$month) {
        $this.firstName = $firstName
        $this.lastName = $lastName
        $this.score = $score
        $this.birthday = (get-date -Minute 0 -Second 0 -Millisecond 0 -Hour 0 -Year 2003 -Day $day -Month $month)
    }
    Student ([string]$firstName,[string]$lastName,[int]$score,[System.DateTime]$birthday) {
        $this.firstName = $firstName
        $this.lastName = $lastName
        $this.score = $score
        $this.birthday = $birthday
    }
    Student ([string]$firstName,[string]$lastName) {
        $this.firstName = $firstName
        $this.lastName = $lastName
        $this.score = (Get-Random -Minimum 1 -Maximum 10)
        $this.birthday = (get-date -Minute 0 -Second 0 -Millisecond 0 -Hour 0 -Year 2003 -Day (Get-Random -Minimum 1 -Maximum 28) -Month (Get-Random -Minimum 1 -Maximum 12))
    }
    [string] GetFullName( ) {
        return ("{0} {1}" -f $this.firstName,$this.lastName)
    }
    [string] GetRapportLine( ) {
        return ("{0} {1} - {2}/10" -f $this.firstName,$this.lastName,$this.score)
    }
    static [Student[]] ConvertFromSerialization([PSObject[]]$psostudents) {
        $students = @()
        foreach($s in $psostudents) {
            $students += new-object Student($s.firstName,$s.lastName,$s.score,$s.birthday)
        }
        return $students
    }
}

$students = @()
$students += new-object Student("Bob","Sinclair")
$students += new-object Student("Alice","Cooper")
$students += new-object Student("Freddie","Mercury")


# Convert Direct from csv
$importCSVStudents = [student]::ConvertFromSerialization((Import-Csv -Delimiter "`t" -path $csvpath))
$importCSVStudents | Get-Member


# Convert back from JSON Revised
$jsonpath = ".\students.json"
$importedJsonStudents = [student]::ConvertFromSerialization((get-content -path $jsonpath | convertfrom-json))
$importedJsonStudents | Get-Member

# Convert back CLI XML Revised
$xmlclipath = ".\students-cli.xml"
$clistudents = [student]::ConvertFromSerialization((Import-Clixml -Path $xmlclipath))
$clistudents | Get-Member

# cleanup
Get-ChildItem -Path .\student*.* | Remove-Item 
Set-Location K:
Remove-PSDrive -Name 'L'