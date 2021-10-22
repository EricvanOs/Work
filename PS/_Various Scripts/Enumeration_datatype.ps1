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