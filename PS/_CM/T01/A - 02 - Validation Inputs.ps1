function Test-ValidateNotNull {
    [CmdletBinding()]
    param (
        [ValidateNotNull()]
        $Parameter1
    )
}

Test-ValidateNotNull -Parameter1 $null
Test-ValidateNotNull -Parameter1 one

# ValidateNotNullOrEmpty extends ValidateNotNull to disallow empty arrays and empty strings:
function Test-ValidateNotNullOrEmpty {
    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [String]$Parameter1,

        [ValidateNotNullOrEmpty()]
        [Object[]]$Parameter2
    )
}

Test-ValidateNotNullOrEmpty -Parameter1 ''

# ValidateCount is used to test the size of an array supplied to a parameter. 
# The attribute expects a minimum and maximum length for the array.
function Test-ValidateCount {
    [CmdletBinding()]
    param (
        [ValidateCount(1, 1)]
        [String[]]$Parameter1
    )
}

Test-ValidateCount 'one'
Test-ValidateCount 'one','two'

<#
ValidateCount may also be applied to parameters that accept more advanced array types,
such as [System.Collections.ArrayList] or [System.Collections.Generic.List[String]]
#>


# ValidateDrive may be used to test the drive letter provided for a parameter that accepts a
# path. ValidateDrive handles both relative and absolute paths. A relative path is resolved
# to a full path before it is tested against the supplied drive letters. When using the
# ValidateDrive attribute, the parameter type must be String. The parameter cannot be
# omitted:

function Test-ValidateDrive {
    [CmdletBinding()]
    param (
        [ValidateDrive('D')]
        [String]$Parameter1
    )
}

Test-ValidateDrive -Parameter1 'C:'

# ValidateLength can be applied to a String parameter or a parameter that contains an 
# array of strings. Each string will be tested against the minimum and maximum length:
function Test-ValidateLength {
    [CmdletBinding()]
    param (
        [ValidateLength(2, 6)]
        [String[]]$Parameter1
    )
}

Test-ValidateLength -Parameter1 'test'
Test-ValidateLength -Parameter1 'testing'
Test-ValidateLength -Parameter1 't'

# ValidatePattern is used to test that a string, or the elements in an array of strings,
# matches the supplied pattern:
Function Format-PhoneNumber {
    [OutputType([string])]
    param (
        [ValidatePattern('\(?(?<areaCode>\d{3})\)?(-| )?(?<first>\d{3})(-| )?(?<second>\d{4})')]
        [string]$PhoneNumber
    )
    $regex = '\(?(?<areaCode>\d{3})\)?(-| )?(?<first>\d{3})(-| )?(?<second>\d{4})'
    $phoneNumber -match $regex | Out-Null
    Write-Output "($($Matches.areaCode))-$($Matches.first)-$($Matches.second)"
}

Format-PhoneNumber -PhoneNumber 123-456-6789
Format-PhoneNumber -PhoneNumber 123


# see : https://docs.microsoft.com/en-us/dotnet/api/system.text.regularexpressions.regexoptions?view=netframework-4.7.2
# Multiple options may be included as a comma-separated list, for example:
# [ValidatePattern('^Hello', Options = 'IgnoreCase, Multiline')]
# By default, the IgnoreCase option is set. If you want to make a pattern case-sensitive, the
# options can be set to None:
# [ValidatePattern('^Hello', Options = 'None')]
function Test-ValidatePattern {
    [CmdletBinding()]
    param (
        [ValidatePattern('^[A-Z]\S+ [A-Z]\S+\.', Options = 'None')]
        [String]$Greeting
    )
}

Test-ValidatePattern -Greeting 'OK MARC.'
Test-ValidatePattern -Greeting 'Ok marc.' # No error handling

# better version
function Test-ValidatePattern {
    [CmdletBinding()]
    param (
        [ValidatePattern(
        '^[A-Z]\S+ [A-Z]\S+\.',
        Options = 'None',
        ErrorMessage = 'The greeting and name must begin with a capital letter.'
        )]
        [String]$Greeting
    )
}

Test-ValidatePattern -Greeting 'OK MARC.'
Test-ValidatePattern -Greeting 'Ok marc.'


# ValidateRange tests whether a value, or an array of values, fall within a specified range. 
function Test-ValidateRange {
    [CmdletBinding()]
    param (
        [ValidateRange(1, 20)]
        [Int]$Parameter1
    )
}

Test-ValidateRange -Parameter1 21

# ValidateScript executes an arbitrary block of code against each of the arguments for a parameter.
# ValidateScript is to test whether a path exists, for example:
function Test-ValidateScript {
    [CmdletBinding()]
    param (
        [ValidateScript( { Test-Path $_ -PathType Leaf } )]
        [String]$Path
    )
}

# In PowerShell Core, ValidateScript gains an optional ErrorMessage parameter 
function Test-ValidateScript {
    [CmdletBinding()]
    param (
        [ValidateScript(
        { Test-Path $_ -PathType Leaf },
        ErrorMessage = 'The path supplied must exist and must be a file'
        )]
        [String]$Path
    )
}


# In Windows PowerShell, throw may be used within the script 
function Test-ValidateScript {
    [CmdletBinding()]
    param (
        [ValidateScript({
        if (Test-Path $_ -PathType Leaf) {
            $true
        } else {
            throw 'The path supplied must exist and must be a file'
        }
        })]
        [String]$Path
    )
}


# ValidateSet tests whether the specified argument, or each of an array of arguments, exists in a set of possible values:
function Test-ValidateSet {
    [CmdletBinding()]
    param (
        [ValidateSet('One', 'Two', 'Three')]
        [String]$Value
    )
}

# The set of values must be hardcoded in the attribute, it cannot be derived from a variable or another command. B
function Test-ValidateSet {
    [CmdletBInding()]
    param (
        [ValidateSet('One', 'Two', 'Three', IgnoreCase = $false)]
        [String]$Value
    )
}


# AllowNull is used to permit explicit use of $null as a value for a Mandatory parameter:
function Test-AllowNull {
    [CmdletBinding()]
        param (
        [Parameter(Mandatory)]
        [AllowNull()]
        [Object]$Parameter1
    )
}

function Test-AllowEmptyString {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [String]$Parameter1
    )
}


# AllowEmptyCollection, as the name suggests, allows an empty array to be assigned to a mandatory parameter:
function Test-AllowEmptyCollection {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [Object[]]$Parameter1
    )
}
Test-AllowEmptyCollection -Parameter1 @()