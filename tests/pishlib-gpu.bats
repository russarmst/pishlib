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

@test "__pl-gpu_set 128: # gpu_mem=64 in /boot/config.txt." {
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  cat <<EOF > $BOOT_CONF_FILE
# gpu_mem=64
EOF
  run __pl-gpu_set 128
  assert_equal $(grep gpu_mem $BOOT_CONF_FILE) "gpu_mem=128"
  rm $BOOT_CONF_FILE
}

@test "__pl-gpu_set 128: gpu_mem does not exists in /boot/config.txt." {
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run __pl-gpu_set 128
  assert_equal $(grep gpu_mem $BOOT_CONF_FILE) "gpu_mem=128"
  rm $BOOT_CONF_FILE
}

