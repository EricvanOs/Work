Function SquareRoot {
    [cmdletbinding()]
    Param(
    [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
    [int[]]$Value
    )

    Begin {
    Write-Verbose "[BEGIN ] Starting: $($MyInvocation.Mycommand)"
    } #begin

    Process {
    foreach ($item in $value) {
        [pscustomobject]@{
        Value = $item
        SquareRoot = [math]::Sqrt($item)
        }
        }
    } 
    #process
    End {
    Write-Verbose "[END ] Ending: $($MyInvocation.Mycommand)"
    } #end
}

# The command is written so that the user can pipe in a list of numbers or pass the list with the parameter.
$n = 1..1000
Measure-Command {$n | SquareRoot}
Measure-Command {SquareRoot $n }

# In this simple comparison we scored 52ms vs 38ms respectively. Let’s see the difference with varying
# sets of numbers between using the pipeline and using the parameter.
10,100,500,1000,5000,10000 | ForEach-Object {
$n = 1..$_
$pipe = (Measure-Command {$n | squareroot}).totalMilliseconds
$param = (Measure-Command {squareroot $n}).TotalMilliseconds
[pscustomobject]@{
ItemCount = $_
PipelineMS = $pipe
ParameterMS = $param
PctDiff = 100 - (($param/$pipe) * 100 -as [int])
}
}
