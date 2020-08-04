#!/usr/bin/env bats
 
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source "${BATS_TEST_DIRNAME}/../pishlib-gpu" #>/dev/null 2>/dev/null


@test "__pl-gpu_set 128: gpu_mem=64 in /boot/config.txt." {
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  cat <<EOF > $BOOT_CONF_FILE
gpu_mem=64
EOF
  run __pl-gpu_set 128
  assert_equal $(grep gpu_mem $BOOT_CONF_FILE) "gpu_mem=128"
  rm $BOOT_CONF_FILE
}

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


@test "__pl-gpu_get_mem: returns an integer from vcgencmd." {
    touch ~/tmp_boot_conf.txt
    BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
    cat <<EOF > $BOOT_CONF_FILE
# gpu_mem=76
EOF
  VCGENCMD() {
    echo "gpu=76M"
  }
  run __pl-gpu_get_mem
  assert_output "76"
}

@test "__pl-gpu_get_mem: returns an integer from /boot/config.txt." {
  VCGENCMD="" # vcgencmd not available, next best option is config.txt
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  cat <<EOF > $BOOT_CONF_FILE
gpu_mem=76
EOF
  run __pl-gpu_get_mem
  assert_output "76"
  rm $BOOT_CONF_FILE
}

@test "__pl-gpu_get_mem: returns an integer default for Pi1 or Pi Zero." {
  # vcgencmd not available, gpu_mem not set in /boot/config.txt
  # next best option return default gpu_mem according to the model
  VCGENCMD=""
  pl-model() {
    if [[ $1 -eq "is1" ]]; then
      return 0
    elif [[ $1 -eq "isZero" ]]; then
      return 0
    fi
  }
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run __pl-gpu_get_mem
  assert_output "76"
  rm $BOOT_CONF_FILE
}

@test "__pl-gpu_get_mem: returns an integer default for any model except for Pi1 or Pi Zero." {
  # vcgencmd not available, gpu_mem not set in /boot/config.txt
  # next best option return default gpu_mem according to the model
  VCGENCMD=""
  pl-model() {
    if [[ $1 -eq "is1" ]]; then
      return 1
    elif [[ $1 -eq "isZero" ]]; then
      return 1
    fi
  }
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run __pl-gpu_get_mem
  assert_output "76"
  rm $BOOT_CONF_FILE
}