function MyArgumentCompleter{
    param ( $commandName,
            $parameterName,
            $wordToComplete,
            $commandAst,
            $fakeBoundParameters )

    $possibleValues = @{
        Fruits = @('Apple', 'Orange', 'Banana')
        Vegetables = @('Tomato', 'Squash', 'Corn')
    }

    if ($fakeBoundParameters.ContainsKey('Type')) {
        $possibleValues[$fakeBoundParameters.Type] | Where-Object {
            $_ -like "$wordToComplete*"
        }
    } else {
        $possibleValues.Values | ForEach-Object {$_}
    }
}

function Test-ArgumentCompleter {
[CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet('Fruits', 'Vegetables')]
        $Type,

        [Parameter(Mandatory=$true)]
        [ArgumentCompleter({ MyArgumentCompleter @args })]
        $Value
    )
}


$commandName = "Fruits"
Test-ArgumentCompleter  -Type Fruits -Value $commandName 


function MyArgumentCompleter {
    Param(
        [Parameter(Mandatory)]
        [ArgumentCompleter( {
            param ( $commandName,
                    $parameterName,
                    $wordToComplete,
                    $commandAst,
                    $fakeBoundParameters )
            # Perform calculation of tab completed values here.
        } )]
        $ParamName
    )
}


$commandName = 9
$fakeBoundParameters = 'yy'
MyArgumentCompleter -ParamName $commandast 