function test {
    param(
        [string[]]$one,

        [int]$two,
        
        [switch]$three
    )
}
  
 Get-Help test -Full

 ### better

function test {
    param(
        [Parameter(Position=1)]
        [string[]]$one,

        [Parameter(Position=2)]
        [int]$two,
        
        [Parameter(Position=3)]
        [switch]$three
    )
 }
 
 
 Get-Help test -Full 
    