#!/usr/bin/env bats
 
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source "${BATS_TEST_DIRNAME}/../pishlib-gpu" #>/dev/null 2>/dev/null


@test "GPU 1. __pl-gpu_set 128: gpu_mem=64 in /boot/config.txt." {
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  cat <<EOF > $BOOT_CONF_FILE
gpu_mem=64
EOF
  run __pl-gpu_set 128
  assert_equal $(grep gpu_mem $BOOT_CONF_FILE) "gpu_mem=128"
  rm $BOOT_CONF_FILE
}

@test "GPU 2. __pl-gpu_set 128: # gpu_mem=64 in /boot/config.txt." {
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  cat <<EOF > $BOOT_CONF_FILE
# gpu_mem=64
EOF
  run __pl-gpu_set 128
  assert_equal $(grep gpu_mem $BOOT_CONF_FILE) "gpu_mem=128"
  rm $BOOT_CONF_FILE
}

@test "GPU 3. __pl-gpu_set 128: gpu_mem does not exists in /boot/config.txt." {
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run __pl-gpu_set 128
  assert_equal $(grep gpu_mem $BOOT_CONF_FILE) "gpu_mem=128"
  rm $BOOT_CONF_FILE
}


@test "GPU 4. __pl-gpu_get_mem: returns an integer from vcgencmd." {
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

@test "GPU 5. __pl-gpu_get_mem: returns an integer from /boot/config.txt." {
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

@test "GPU 6. __pl-gpu_get_mem: returns default integer for Pi 1 or Pi Zero." {
  # vcgencmd not available, gpu_mem not set in /boot/config.txt
  # next best option return default gpu_mem according to the model
  VCGENCMD=""
  pl-model() {
    echo 0 # Pi model is 1 or Zero
  }
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run __pl-gpu_get_mem
  assert_output "64"
  rm $BOOT_CONF_FILE
}

@test "GPU 7. __pl-gpu_get_mem: returns default integer for any model except for Pi 1 or Pi Zero." {
  # vcgencmd not available, gpu_mem not set in /boot/config.txt
  # next best option return default gpu_mem according to the model
  VCGENCMD=""
  pl-model() {
    echo 1 # Pi model is not 1 or Zero
  }
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run __pl-gpu_get_mem
  assert_output "76"
  rm $BOOT_CONF_FILE
}

@test "GPU 8. __pl-gpu_get_default_mem: Returns default integer for Pi 1 and Pi Zero." {
  pl-model() {
    echo 0 # Pi model is 1 or Zero
  }
  run __pl-gpu_get_default_mem
  assert_output "64"
}

@test "GPU 9. __pl-gpu_get_default_mem: Returns default integer for all models except Pi 1 and Pi Zero." {
  pl-model() {
    echo 1 # Pi model is not 1 or Zero
  }
  run __pl-gpu_get_default_mem
  assert_output "76"
}

@test "GPU 10. pl-gpu_mem: Returns int of GPU memory allocated" {
  run pl-gpu_mem
  assert_output --regexp '^[0-9]+$'
}
@test "GPU 11. pl-gpu_mem default: Sets gpu_mem in /boot/config.txt to int." {
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run pl-gpu_mem default
  run echo "$(grep gpu_mem $BOOT_CONF_FILE | sed 's/[^0-9]*//g')"
  assert_output --regexp '^[0-9]+$'
  rm $BOOT_CONF_FILE
}