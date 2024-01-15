function test {
    param(
        [string[]]$one,

        [int]$two,
        
        [switch]$three
    )
}

test 'A' 7 $true 
Get-Help test -Full

### if I want other parameter positions

function test {
    param(
        [Parameter(Position=1)]
        [string[]]$one,

        [Parameter(Position=0)]
        [int]$two,
        
        [Parameter(Position=2)]
        [switch]$three
    )
}

test 'A' 7 $true  # error
test  7  'A' $true
Get-Help test  -ShowWindow
    