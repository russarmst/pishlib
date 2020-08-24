#!/usr/bin/env bats
 
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source "${BATS_TEST_DIRNAME}/../pishlib-mem" >/dev/null 2>/dev/null

arrange_256mb() {
  __pl_get_mem_as_kb() {
    echo 262144
  }
}

arrange_512mb() {
  __pl_get_mem_as_kb() {
    echo 524288
  }
}

arrange_1gb() {
  __pl_get_mem_as_kb() {
    echo 1048576
  }
}

arrange_2gb() {
  __pl_get_mem_as_kb() {
    echo 2097152
  }
}

arrange_4gb() {
  __pl_get_mem_as_kb() {
    echo 4194304
  }
}

arrange_8gb() {
  __pl_get_mem_as_kb() {
    echo 8388608
  }
}

@test "Mem 1. 256mb: 'pl-mem' returns 256" {
  arrange_256mb
  run pl_mem
  assert_oupput 256
}

@test "Mem 2. 512mb: 'pl-mem' returns 512" {
  arrange_512mb
  run pl_mem
  assert_oupput 512
}

@test "Mem 3. 1gb: 'pl-mem' returns 1024" {
  arrange_1gb
  run pl_mem
  assert_oupput 1024
}

@test "Mem 4. 2gb: 'pl-mem' returns 2048" {
  arrange_2gb
  run pl_mem
  assert_oupput 2048
}

@test "Mem 5. 4gb: 'pl-mem' returns 4096" {
  arrange_4gb
  run pl_mem
  assert_oupput 4096
}

@test "Mem 6. 8gb: 'pl-mem' returns 8192" {
  arrange_8gb
  run pl_mem
  assert_oupput 8192
}

