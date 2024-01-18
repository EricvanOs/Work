function Test-Remainder {
    param(
        [Parameter(Mandatory, Position=0)]
        [string]$NamedParameter,

        [Parameter(Position=1, ValueFromRemainingArguments)]
        [string[]]$Remaining
    )

    "Found $($Remaining.Count) Remaining elements"

    for ($i = 0; $i -lt $Remaining.Count; $i++) {
        "${i}: $($Remaining[$i])"
    }
}


Test-Remainder first one,two
Test-Remainder -NamedParameter first -Remaining one,two