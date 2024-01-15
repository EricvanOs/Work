function Get-Fibonacci($n) {
    if ($n -le 2) {
      1
    }
    else {
      (Get-Fibonacci ($n - 1)) + (Get-Fibonacci ($n - 2))
    }
}

# start values fibonacci(1) = 1, fibonacci(2) = 1
# 1,1,2,3,5,8,13,21


Get-Fibonacci (1)
Get-Fibonacci (2)
Get-Fibonacci (3)
Get-Fibonacci (4)
Get-Fibonacci (5)


(Get-Fibonacci (21)) / (Get-Fibonacci (20))  # golden ratio     (1+ [math]::sqrt(5))/2