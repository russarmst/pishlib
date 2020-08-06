#!/usr/bin/env bats
 
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source "${BATS_TEST_DIRNAME}/../pishlib-mem" >/dev/null 2>/dev/null

@test "MEM 1. pl-mem: returns int MB" {
  # mock internal function
  __pl-mem_total() {
    echo 1024
  }
  export -f __pl-mem_total

  run pl-mem
  assert_output 1024
}

@test "MEM 2. pl-mem eq: is true" {
  __pl-mem_total() {
    echo 1024
  }
  export -f __pl-mem_total

  run pl-mem eq 1024
  assert_success
}

@test "MEM 3. pl-mem eq: is false" {
  __pl-mem_total() {
    echo 1024
  }
  export -f __pl-mem_total

  run pl-mem eq 1023
  assert_failure
}

@test "MEM 4. pl-mem lt: is true" {
  __pl-mem_total() {
    echo 1024
  }
  export -f __pl-mem_total

  run pl-mem lt 1025
  assert_success

}

@test "MEM 5. pl-mem lt: is false" {
  __pl-mem_total() {
    echo 1024
  }
  export -f __pl-mem_total

  run pl-mem lt 1023
  assert_failure
}

@test "MEM 6. pl-mem gt: is true" {
  __pl-mem_total() {
    echo 1024
  }
  export -f __pl-mem_total

  run pl-mem gt 1023
  assert_success

}

@test "MEM 7. pl-mem gt: is false" {
  __pl-mem_total() {
    echo 1024
  }
  export -f __pl-mem_total

  run pl-mem gt 1025
  assert_failure
}

# is256m

@test "MEM 8. pl-mem is256m: is true" {
  __pl-mem_total() {
    echo 255
  }
  export -f __pl-mem_total

  run pl-mem is256m
  assert_success

}

@test "MEM 9. pl-mem is256m: is false (greater than)" {
  __pl-mem_total() {
    echo 257
  }
  export -f __pl-mem_total

  run pl-mem is256m
  assert_failure

}

# is512m

@test "MEM 10. pl-mem is512m: is true" {
  __pl-mem_total() {
    echo 511
  }
  export -f __pl-mem_total

  run pl-mem is512m
  assert_success

}

@test "MEM 11. pl-mem is512m: is false (less than)" {
  __pl-mem_total() {
    echo 255
  }
  export -f __pl-mem_total

  run pl-mem is512m
  assert_failure

}

@test "MEM 12. pl-mem is512m: is false (greater than)" {
  __pl-mem_total() {
    echo 513
  }
  export -f __pl-mem_total

  run pl-mem is512m
  assert_failure

}

# is1g

@test "MEM 13. pl-mem is1g: is true" {
  __pl-mem_total() {
    echo 1023
  }
  export -f __pl-mem_total

  run pl-mem is1g
  assert_success

}

@test "MEM 14. pl-mem is1g: is false (less than)" {
  __pl-mem_total() {
    echo 511
  }
  export -f __pl-mem_total

  run pl-mem is1g
  assert_failure

}

@test "MEM 15. pl-mem is1g: is false (greater than)" {
  __pl-mem_total() {
    echo 1025
  }
  export -f __pl-mem_total

  run pl-mem is1g
  assert_failure

}

# is2g

@test "MEM 16. pl-mem is2g: is true" {
  __pl-mem_total() {
    echo 2047
  }
  export -f __pl-mem_total

  run pl-mem is2g
  assert_success

}

@test "MEM 17. pl-mem is2g: is false (less than)" {
  __pl-mem_total() {
    echo 1023
  }
  export -f __pl-mem_total

  run pl-mem is2g
  assert_failure

}

@test "MEM 18. pl-mem is2g: is false (greater than)" {
  __pl-mem_total() {
    echo 2049
  }
  export -f __pl-mem_total

  run pl-mem is2g
  assert_failure

}

# is4g

@test "MEM 19. pl-mem is4g: is true" {
  __pl-mem_total() {
    echo 4095
  }
  export -f __pl-mem_total

  run pl-mem is4g
  assert_success

}

@test "MEM 20. pl-mem is4g: is false (less than)" {
  __pl-mem_total() {
    echo 2047
  }
  export -f __pl-mem_total

  run pl-mem is4g
  assert_failure

}

@test "MEM 21. pl-mem is4g: is false (greater than)" {
  __pl-mem_total() {
    echo 4097
  }
  export -f __pl-mem_total

  run pl-mem is4g
  assert_failure

}

# is8g

@test "MEM 22. pl-mem is8g: is true" {
  __pl-mem_total() {
    echo 8191
  }
  export -f __pl-mem_total

  run pl-mem is8g
  assert_success

}

@test "MEM 23. pl-mem is8g: is false (less than)" {
  __pl-mem_total() {
    echo 4095
  }
  export -f __pl-mem_total

  run pl-mem is8g
  assert_failure

}

@test "MEM 24. pl-mem is8g: is false (greater than)" {
  __pl-mem_total() {
    echo 8193
  }
  export -f __pl-mem_total

  run pl-mem is8g
  assert_failure

}

@test "MEM 25. pl-mem ramdisk: " {
  skip "Yet to be implemented"
}

@test "MEM 26. pl-mem zswap: " {
  skip "Yet to be implemented"
}

@test "MEM 27. pl-mem swap: " {
  skip "Yet to be implemented"
}