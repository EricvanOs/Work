# Create a class
class Tree {
    [int]$Height
    [int]$Age
    [string]$Color
}

$tree1 = new-object Tree
$tree2 = [Tree]::new()

$tree1.Height = 10
$tree1.Age = 5
$tree1.Color = "Red"

$tree2.Height = 20
$tree2.Age = 10
$tree2.Color = "Green"

$tree1
$tree2

$tree1 | Get-Member
$tree1 | Get-Member -Static

