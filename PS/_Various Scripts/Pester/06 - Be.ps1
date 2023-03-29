
$actual="Actual value"
$actual | Should -Be "actual value" # Test will pass
$actual | Should -Be "not actual value"  # Test will fail

# Also compares an entire array for equality and throws if the array is not the same.

$array1 = @(1, 2, 3, 4, 'I am a string', (New-Object psobject -Property @{ IAm = 'An Object' }))
$array1 | Should -Be $array # Test will pass

$string = 'I am a string'
$array2 = @(1, 2, 3, 4, $string)
$arrayWithCaps = @(1, 2, 3, 4, $string.ToUpper())
$array2 | Should -Be $arrayWithCaps # Test will pass

# Comparisons will fail if the arrays have the same values, but not the same order.

[int32[]]$array3 = (1..10)
$arrayoutoforder = (1,10,2,3,4,5,6,7,8,9)
$array3 | Should -Be $arrayOutOfOrder # Test will fail

# https://pester.dev/docs/assertions/

$ErrorActionPreference = 'Stop' # default in Pester


