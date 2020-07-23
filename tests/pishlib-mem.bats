#!/usr/bin/env bats
 
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source "${BATS_TEST_DIRNAME}/../pishlib-mem" >/dev/null 2>/dev/null

@test "pl-mem: returns int MB" {
  # mock internal function
  __pl-mem_total() {
    echo 1024
  }
  export -f __pl-mem_total

  run pl-mem
  assert_output 1024
}

@test "pl-mem eq: is true" {
  __pl-mem_total() {
    echo 1024
  }
  export -f __pl-mem_total

  run pl-mem eq 1024
  assert_success
}

@test "pl-mem eq: is false" {
  __pl-mem_total() {
    echo 1024
  }
  export -f __pl-mem_total

  run pl-mem eq 1023
  assert_failure
}

@test "pl-mem lt: is true" {
  __pl-mem_total() {
    echo 1024
  }
  export -f __pl-mem_total

  run pl-mem lt 1025
  assert_success

}

@test "pl-mem lt: is false" {
  __pl-mem_total() {
    echo 1024
  }
  export -f __pl-mem_total

  run pl-mem lt 1023
  assert_failure
}

@test "pl-mem gt: is true" {
  __pl-mem_total() {
    echo 1024
  }
  export -f __pl-mem_total

  run pl-mem gt 1023
  assert_success

}

@test "pl-mem gt: is false" {
  __pl-mem_total() {
    echo 1024
  }
  export -f __pl-mem_total

  run pl-mem gt 1025
  assert_failure
}

# is256m

@test "pl-mem is256m: is true" {
  __pl-mem_total() {
    echo 255
  }
  export -f __pl-mem_total

  run pl-mem is256m
  assert_success

}

@test "pl-mem is256m: is false (greater than)" {
  __pl-mem_total() {
    echo 257
  }
  export -f __pl-mem_total

  run pl-mem is256m
  assert_failure

}

# is512m

@test "pl-mem is512m: is true" {
  __pl-mem_total() {
    echo 511
  }
  export -f __pl-mem_total

  run pl-mem is512m
  assert_success

}

@test "pl-mem is512m: is false (less than)" {
  __pl-mem_total() {
    echo 255
  }
  export -f __pl-mem_total

  run pl-mem is512m
  assert_failure

}

@test "pl-mem is512m: is false (greater than)" {
  __pl-mem_total() {
    echo 513
  }
  export -f __pl-mem_total

  run pl-mem is512m
  assert_failure

}

# is1g

@test "pl-mem is1g: is true" {
  __pl-mem_total() {
    echo 1023
  }
  export -f __pl-mem_total

  run pl-mem is1g
  assert_success

}

@test "pl-mem is1g: is false (less than)" {
  __pl-mem_total() {
    echo 511
  }
  export -f __pl-mem_total

  run pl-mem is1g
  assert_failure

}

@test "pl-mem is1g: is false (greater than)" {
  __pl-mem_total() {
    echo 1025
  }
  export -f __pl-mem_total

  run pl-mem is1g
  assert_failure

}

# is2g

@test "pl-mem is2g: is true" {
  __pl-mem_total() {
    echo 2047
  }
  export -f __pl-mem_total

  run pl-mem is2g
  assert_success

}

@test "pl-mem is2g: is false (less than)" {
  __pl-mem_total() {
    echo 1023
  }
  export -f __pl-mem_total

  run pl-mem is2g
  assert_failure

}

@test "pl-mem is2g: is false (greater than)" {
  __pl-mem_total() {
    echo 2049
  }
  export -f __pl-mem_total

  run pl-mem is2g
  assert_failure

}

# is4g

@test "pl-mem is4g: is true" {
  __pl-mem_total() {
    echo 4095
  }
  export -f __pl-mem_total

  run pl-mem is4g
  assert_success

}

@test "pl-mem is4g: is false (less than)" {
  __pl-mem_total() {
    echo 2047
  }
  export -f __pl-mem_total

  run pl-mem is4g
  assert_failure

}

@test "pl-mem is4g: is false (greater than)" {
  __pl-mem_total() {
    echo 4097
  }
  export -f __pl-mem_total

  run pl-mem is4g
  assert_failure

}

# is8g

@test "pl-mem is8g: is true" {
  __pl-mem_total() {
    echo 8191
  }
  export -f __pl-mem_total

  run pl-mem is8g
  assert_success

}

@test "pl-mem is8g: is false (less than)" {
  __pl-mem_total() {
    echo 4095
  }
  export -f __pl-mem_total

  run pl-mem is8g
  assert_failure

}

@test "pl-mem is8g: is false (greater than)" {
  __pl-mem_total() {
    echo 8193
  }
  export -f __pl-mem_total

  run pl-mem is8g
  assert_failure

}

@test "pl-mem ramdisk: " {
  skip "Yet to be implemented"
}

@test "pl-mem zswap: " {
  skip "Yet to be implemented"
}

@test "pl-mem swap: " {
  skip "Yet to be implemented"
}