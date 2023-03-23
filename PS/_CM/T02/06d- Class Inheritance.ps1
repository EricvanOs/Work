
# Class inheritance
class Tree {
    [int]$Height
    [int]$Age
    [string]$Color

    Tree() {
        $this.Height = 1;
        $this.Age = 0
        $this.Color = "Green"
    }

    Tree([int]$Height, [int]$Age, [string]$Color) {
        $this.Height = $Height;
        $this.Age = $Age;
        $this.Color = $Color;
    }

    [void]Grow() {
        # Get a random height because plants and trees don't grow the same each year
        $heightIncrease = Get-Random -Min 1 -Max 5;
        $this.Height += $heightIncrease;
        $this.Age += 1
    }
}

class AppleTree : Tree {
    [string]$Species = "Apple"
}

$tree = [AppleTree]::new()
$tree


