#!/usr/bin/env bats
 
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source "${BATS_TEST_DIRNAME}/../pishlib-gpu" #>/dev/null 2>/dev/null

@test "pl-gpu_mem: returns int MB" {
  # mock internal function
  __pl-gpu_get_mem() {
    echo 128
  }
  export -f __pl-gpu_get_mem

  run pl-gpu_mem
  assert_output 128
}

@test "pl-gpu_mem default: set default gpu_mem for Pi 1 and Pi Zero." {
  __pl-gpu_get_default_mem() {
    echo 64
  }
  export -f __pl-gpu_get_default_mem

  run pl-gpu_mem default
  g_mem=$(grep gpu_mem /boot/config.txt | sed 's/[^0-9]*//g')
  assert_output 64
}