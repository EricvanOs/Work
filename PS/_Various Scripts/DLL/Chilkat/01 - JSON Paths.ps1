$path = 'C:\Work\PS\_Various Scripts\DLL\Chilkat'

Set-Location $path


[Reflection.Assembly]::LoadFile("$path\chilkatdotnet47-9.5.0-x64\ChilkatDotNet47.dll")

$json = New-Object Chilkat.JsonObject
$json.EmitCompact = $false

# Assume the file contains the data as shown above..
$success = $json.LoadFile("$path\pathSample.json")
if ($success -ne $true) {
    $($json.LastErrorText)
    exit
}

# First, let's get the value of "cc1"
# The path to this value is: nestedObject.aaa.bb1.cc1
$($json.StringOf("nestedObject.aaa.bb1.cc1"))

# Now let's get number 18 from the nestedArray.
# It is located at nestedArray[1][2][1]
# (remember: Indexing is 0-based)
$("This should be 18: " + $json.IntOf("nestedArray[1][2][1]"))

# We can do the same thing in a more roundabout way using the 
# I, J, and K properties.  (The I,J,K properties will be convenient
# for iterating over arrays, as we'll see later.)
$json.I = 1
$json.J = 2
$json.K = 1
$("This should be 18: " + $json.IntOf("nestedArray[i][j][k]"))

# Let's iterate over the array containing the numbers 17, 18, 19, 20.
# First, use the SizeOfArray method to get the array size:
$sz = $json.SizeOfArray("nestedArray[1][2]")
# The size should be 4.
$("size of array = " + $sz + " (should equal 4)")

# Now iterate...

for ($i = 0; $i -le $sz - 1; $i++) {
    $json.I = $i
    $($json.IntOf("nestedArray[1][2][i]"))
}

# Let's use a triple-nested loop to iterate over the nestedArray:

# szI should equal 1.
$szI = $json.SizeOfArray("nestedArray")
for ($i = 0; $i -le $szI - 1; $i++) {
    $json.I = $i

    $szJ = $json.SizeOfArray("nestedArray[i]")
    for ($j = 0; $j -le $szJ - 1; $j++) {
        $json.J = $j

        $szK = $json.SizeOfArray("nestedArray[i][j]")
        for ($k = 0; $k -le $szK - 1; $k++) {
            $json.K = $k

            $($json.IntOf("nestedArray[i][j][k]"))
        }

    }

}

# Now let's examine how to navigate to JSON objects contained within JSON arrays.
# This line of code gets the value "kiwi" contained within "mixture"
$($json.StringOf("mixture.arrayA[2].fruit"))

# This line of code gets the color "yellow"
$($json.StringOf("mixture.arrayA[1].colors[0]"))

# Getting an object at a path:
# This gets the 2nd object in "arrayA"
$obj2 = $json.ObjectOf("mixture.arrayA[1]")
# This object's "animal" should be "plankton"
$($obj2.StringOf("animal"))

# Note that paths are relative to the object, not the absolute root of the JSON document.
# Starting from obj2, "purple" is at "colors[2]"
$($obj2.StringOf("colors[2]"))

# Getting an array at a path:
# This gets the array containing the colors red, green, blue:
$arr1 = $json.ArrayOf("mixture.arrayA[0].colors")
$szArr1 = $arr1.Size
for ($i = 0; $i -le $szArr1 - 1; $i++) {
    $([string]$i + ": " + $arr1.StringAt($i))
}

# The Chilkat JSON path uses ".", "[", and "]" chars for separators.  When a name
# contains one of these chars, use double-quotes in the path:
$($json.StringOf("`"name.with.dots`".grain"))
