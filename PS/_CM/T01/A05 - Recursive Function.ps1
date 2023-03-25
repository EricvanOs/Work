function fibonacci($n) {
    if ($n -lt 2) {
      $n
    }
    else {
      (fibonacci ($n - 1)) + (fibonacci ($n - 2))
    }
}

# start values fibonacci(1) = 1, fibonacci(2) = 1
# 1,1,2,3,5,8,13,21

fibonacci (8)