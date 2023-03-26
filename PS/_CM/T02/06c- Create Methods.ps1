# Creating methods
class Tree {
    [int]$Height
    [int]$Age
    [string]$Color

    # Initialize the tree by setting default values
    Tree() {
        $this.Height = 1
        $this.Age = 0
        $this.Color = "Green"
    }

    # Create a constructor with parameters a.k.a. constructor overloading
    Tree([int]$Height, [int]$Age, [string]$Color) {
        $this.Height = $Height
        $this.Age = $Age
        $this.Color = $Color
    }

    [void]Grow() {
        # Get a random height because plants and trees don't grow the same each year
        $heightIncrease = Get-Random -Min 1 -Max 5;
        $this.Height += $heightIncrease;
        $this.Age += 1
    }
}

$tree = [Tree]::New()

# Let the tree grow for 10 years
for ($i = 0; $i -lt 10; $i++) {
    $tree.Grow()
    $tree
}