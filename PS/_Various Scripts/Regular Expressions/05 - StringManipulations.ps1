$path = 'K:\_CM\_Various Scripts\Regular Expressions\'
Set-Location -Path $path

# make use of here-string
Set-Content -Path twitterData.txt -value @"
Lee, Steve-@Steve_MSFT,2992
Lee Holmes-13000 @Lee_Holmes
Staffan Gustafsson-463 @StaffanGson
Tribbiani, Joey-@Matt_LeBlanc,463400
"@

# extracting captured groups
Get-ChildItem -Path twitterData.txt |
    Select-String -Pattern "^(\w+) ([^-]+)-(\d+) (@\w+)" |
    Foreach-Object {
        $first, $last, $followers, $handle = $_.Matches[0].Groups[1..4].Value   # this is a common way of getting the groups of a call to select-string
        [PSCustomObject] @{
            FirstName = $first
            LastName = $last
            Handle = $handle
            TwitterFollowers = [int] $followers
        }
    }

#####
$firstLastPattern = "^(?<first>\w+) (?<last>[^-]+)-(?<followers>\d+) (?<handle>@.+)"
$lastFirstPattern = "^(?<last>[^\s,]+),\s+(?<first>[^-]+)-(?<handle>@[^,]+),(?<followers>\d+)"
Get-ChildItem twitterData.txt |
     Select-String -Pattern $firstLastPattern, $lastFirstPattern |
    Foreach-Object {
        # here we access the groups by name instead of by index
        $first, $last, $followers, $handle = $_.Matches[0].Groups['first', 'last', 'followers', 'handle'].Value
        [PSCustomObject] @{
            FirstName = $first
            LastName = $last
            Handle = $handle
            TwitterFollowers = [int] $followers
        }
    }



# using the context property
Get-ChildItem -Path twitterData.txt |
    Select-String -Pattern "Staffan" -Context 2,1 |
    Foreach-Object { $_.Context.PreContext[1], $_.Context.PostContext[0] }


#cleanup
Get-Item -Path $path\twitterData.txt | Remove-Item



#split operator

$text = "Description=The '=' character is used for assigning values to a variable"
$name, $value = $text -split "=", 2

@"
Name  =  $name
Value =  $value
"@

# filling variables
$name, $location, $occupation = "Spider Man,New York,Super Hero" -split ','

# if only location is of interest
$null, $location, $null = "Spider Man,New York,Super Hero" -split ','

# or using index(number)
$inputText = "x,Staffan,x,x,x,x,x,x,x,x,x,x,Stockholm,x,x,x,x,x,x,x,x,11,x,x,x,x"
$name, $location, $age = ($inputText -split ',')[1,12,21]

# even better create an object
$inputText = "x,Steve,x,x,x,x,x,x,x,x,x,x,Seattle,x,x,x,x,x,x,x,x,22,x,x,x,x"
$name, $location, $age = ($inputText -split ',')[1,12,21]
$output = [PSCustomObject] @{
    Name = $name
    Location = $location
    Age = [int] $age
}

$output | Get-Member

# creating seperate class
class PowerSheller {
    [string] $Name
    [string] $Location
    [int] $Age
    [int] $ShoeSize
}

$inputText = "x,Staffan,x,x,x,x,x,x,x,x,x,x,Stockholm,x,x,x,x,x,x,x,x,33,x,11d,x,x"
$name, $location, $age, $shoeSize = ($inputText -split ',')[1,12,21,23]
$output = [PowerSheller] @{
    Name = $name
    Location = $location
    Age = $age
    # ShoeSize is expressed in hex, with no '0x' because reasons 🙂
    # And yes, it's in millimeters.
    ShoeSize = [Convert]::ToInt32($shoeSize, 16)
}

$output | Get-Member

# positive lookahead assertion
$cmdline = "cl.exe /D Bar=1 /I SomePath /D Foo  /O2 /I SomeOtherPath /Debug a1.cpp a3.cpp a2.cpp"

$cmdline -split "\s+(?=[-/])"
<#
cl.exe
/D Bar=1
/I SomePath
/D Foo
/O2
/I SomeOtherPath
/Debug a1.cpp a2.cpp

# Breaking down the regex, by rewriting it with the x option:

(?x)      # ignore whitespace in the pattern, and enable comments after '#'
\s+       # one or more spaces
(?=[-/])  # only match the previous spaces if they are followed by any of '-' or '/'.

#>


# Splitting with a scriptblock
function SplitWhitespaceInMiddleOfText {
    param(
        [string]$Text,
        [int] $Index
    )
    if ($Index -lt 10 -or $Index -gt 40){
        return $false
    }
    $_ -match '\s'
}

$inputText = "Some text that only needs splitting in the middle of the text"
$inputText -split $function:SplitWhitespaceInMiddleOfText


# match operator
if ('a b c' -match '(\w) (?<named>\w) (\w)'){
    $matches
}

#  
"    10,Some text" -match '^\s+(\d+),(.+)'
$matches

# using named groups
"    10,Some text" -match '^\s+(?<num>\d+),(?<text>.+)'
 $matches


 # using a function
 function ParseMyString($text){
    if ($text -match '^\s+(\d+),(.+)') {
        [PSCustomObject] @{
            Number = [int] $matches[1]
            Text    = $matches[2]
        }
    }
    else {
        Write-Warning "ParseMyString: Input `$text` doesn't match pattern"
    }
}

ParseMyString "    10,Some text"

# using switch statement
class ParsedOutput {
    [int] $Number
    [string] $Text

    [string] ToString() { return "{0} ({1})" -f $this.Text, $this.Number }
}

$inputData =
    "Preamble line",
    "LastLineOfPreamble",
    "    10,Some Text",
    "    Some other text,20"

$inPreamble = $true
switch -regex ($inputData) {

    {$inPreamble -and $_ -eq 'LastLineOfPreamble'} { $inPreamble = $false; continue }

    "^\s+(?<num>\d+),(?<text>.+)" {  # this matches the first line of non-preamble input
        [ParsedOutput] @{
            Number = $matches.num
            Text = $matches.text
        }
        continue
    }

    "^\s+(?<text>[^,]+),(?<num>\d+)" { # this matches the second line of non-preamble input
        [ParsedOutput] @{
            Number = $matches.num
            Text = $matches.text
        }
        continue
    }
}

# regex accelerator
[regex]::match('a,b,c,', '(\w,)+').Groups[1].Captures

# parsing input data
class ParsedOutput2 {
    [int] $Number
    [string] $Text

    [string] ToString() { return "{0} ({1})" -f $this.Text, $this.Number }
}

$inputData =
    "    10,Some Text",
    "    Some other text,20"  # this text will not match

[regex] $pattern = "^\s+(\d+),(.+)"

foreach($d in $inputData){
    $match = $pattern.Match($d)
    if ($match.Success){
        $number, $text = $match.Groups[1,2].Value
        [ParsedOutput2] @{
            Number = $number
            Text = $text
        }
    }
    else {
        Write-Warning "regex: '$d' did not match pattern '$pattern'"
    }
}