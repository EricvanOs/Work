# The enum statement is used to declare an enumeration

enum MediaTypes {
    unknown
    music = 10
    mp3
    aac
    ogg = 15
    oga = 15
    mogg = 15
    picture = 20
    jpg
    jpeg = 21
    png
    video = 40
    mpg
    mpeg = 41
    avi
    m4v
}

# see result
[MediaTypes].GetEnumNames()

# compare with
[MediaTypes].GetEnumValues()

# test again
[MediaTypes].GetEnumName(15)

# map each name to its value
[MediaTypes].GetEnumNames() | ForEach-Object {
  "{0,-10} {1}" -f $_,[int]([MediaTypes]::$_)
}

#########################
enum MySeasons
{
  Spring
  Summer
  Autumn
  Winter = 25
}


[MySeasons]$Season = [MySeasons]::Winter

# or
[MySeasons]$Season = [MySeasons] 'Winter'

# or
$Season = [MySeasons] 'Winter'

# fails, not really but stays empty
$ThisWillFail = [MySeasons]::Monday
$ThisWillFail 

# use in switch

switch ($Season)
{
    "Spring" {"It's Spring"; continue } 
    "Summer" {"It's Summer"; continue } 
    "Autumn" {"It's Autumn"; continue } 
    "Winter" {"It's Winter"; continue } 
}


$Season.GetType()

$Season -is [System.enum]

[Enum]::GetNames( [MySeasons] )

# This can also be used for any of the many built-in enums:
[Enum]::GetNames([Microsoft.Powershell.ExecutionPolicy])
[Enum]::GetNames([System.DayOfWeek])
[Enum]::GetNames([System.Security.AccessControl.FileSystemRights])
[Enum]::GetNames([System.Security.AccessControl.RegistryRights])


[System.Enum]::GetValues([MySeasons]) |
Foreach-Object { [PSCustomObject]@{ValueName = $_; IntValue = [int]$_ } }


# use in validation set
[Parameter(Mandatory=$False)]
[ValidateSet('Spring','Summer','Autumn','Winter')]
[string]$NewSeason

