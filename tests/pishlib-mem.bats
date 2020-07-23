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

  run pl-mem eq 1000
  assert_failure
}