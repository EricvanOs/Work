# Constructors
# When creating a class you can also create a constructor. The constructor is a special method that is called when you create an instance of the class.
class Tree {
    [int]$Height
    [int]$Age
    [string]$Color

    Tree() {
        $this.Height = 1
        $this.Age = 0
        $this.Color = "Green"
    }

    Tree([int]$Height, [int]$Age, [string]$Color) {
        $this.Height = $Height;
        $this.Age = $Age;
        $this.Color = $Color;
    }
}

$tree1 = [Tree]::New()
$tree2 = New-Object Tree 5, 2, "Red"

$tree1
$tree2