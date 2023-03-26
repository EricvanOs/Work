# Passing a Function without Parameters

function MyFunction {
    Param($param)
    Write-Host "I'm calling: $(& $param)"
}
function Test {
    "Function Test"
}

MyFunction Test
MyFunction -param Test
MyFunction -param { Test }



# Passing a Function with Parameters
function MyFunction {
    Param($param)
    Write-Host "I'm calling: $(& $param @args)"
}
function Test {
    "Function Test with parameters: $args"
}

MyFunction Test a b
MyFunction -param Test a b
MyFunction -param { Test @args } a b
