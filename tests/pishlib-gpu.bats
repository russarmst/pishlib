#!/usr/bin/env bats
 
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source "${BATS_TEST_DIRNAME}/../pishlib-gpu" #>/dev/null 2>/dev/null


@test "GPU 1.0 pl_gpu frequency" {
  run pl_gpu frequency
  [[ $output =~ [1-9][0-9]+ ]]
}

@test "GPU 1.1. pl_gpu frequency: no vcgencmd" {
  VCGENCMD=""
  run pl_gpu frequency
  [[ $output = 1 ]]
}

@test "GPU 2. pl_gpu memory total" {
  run pl_gpu memory total
  [[ $output =~ [0-9]+ ]]
}

@test "GPU 3. pl_gpu memory total=128: blank config.txt" {
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run pl_gpu memory total=128
  assert_equal "$(grep gpu_mem $BOOT_CONF_FILE)" "gpu_mem=128"
  rm $BOOT_CONF_FILE
}

@test "GPU 4. pl_gpu memory total=8: insane setting, return 1." {
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run pl_gpu memory total=8
  [[ $output -eq 1 ]]
  rm $BOOT_CONF_FILE
}

@test "GPU 5. pl_gpu memory total=1024: insane setting, return 1." {
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run pl_gpu memory total=1024
  [[ $output -eq 1 ]]
  rm $BOOT_CONF_FILE
}

@test "GPU 6. pl_gpu memory total=128: gpu_mem already defined in config.txt" {
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  cat <<EOF > $BOOT_CONF_FILE
gpu_mem=76
EOF
  run pl_gpu memory total=128
  assert_equal $(grep gpu_mem $BOOT_CONF_FILE) "gpu_mem=128"
  rm $BOOT_CONF_FILE
}

@test "GPU 7. pl_gpu memory total=128: gpu_mem commented out in config.txt" {
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  cat <<EOF > $BOOT_CONF_FILE
# gpu_mem=76
EOF
  run pl_gpu memory total=128
  assert_equal $(grep gpu_mem $BOOT_CONF_FILE) "gpu_mem=128"
  rm $BOOT_CONF_FILE
}

@test "GPU 8. pl_gpu memory total=default: Pi mem < 1024" {
  # TODO: fake system memory size
  skip "Need to implement fake system memory size."
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run pl_gpu memory total=default
  assert_equal $(grep gpu_mem $BOOT_CONF_FILE) "gpu_mem=64"
  rm $BOOT_CONF_FILE
}

@test "GPU 9. pl_gpu memory total=default: Pi mem > 1024" {
  # TODO: fake system memory size
  skip "Need to implement fake system memory size."
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run pl_gpu memory total=default
  assert_equal $(grep gpu_mem $BOOT_CONF_FILE) "gpu_mem=76"
  rm $BOOT_CONF_FILE
}


@test "GPU 10. pl_gpu memory total=max: Pi mem = 256." {
  # TODO: fake system memory size
  skip "Need to implement fake system memory size."
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run pl_gpu memory total=max
  assert_equal $(grep gpu_mem $BOOT_CONF_FILE) "gpu_mem=128"
  rm $BOOT_CONF_FILE
}

@test "GPU 11. pl_gpu memory total=max: Pi mem = 512." {
  # TODO: fake system memory size
  skip "Need to implement fake system memory size."
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run pl_gpu memory total=max
  assert_equal $(grep gpu_mem $BOOT_CONF_FILE) "gpu_mem=384"
  rm $BOOT_CONF_FILE
}

@test "GPU 12. pl_gpu memory total=max: Pi mem > 512." {
  # TODO: fake system memory size
  skip "Need to implement fake system memory size."
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run pl_gpu memory total=max
  assert_equal $(grep gpu_mem $BOOT_CONF_FILE) "gpu_mem=512"
  rm $BOOT_CONF_FILE
}

@test "GPU 13. pl_gpu memory free" {
  run pl_gpu memory free
  [[ $output =~ [0-9]+ ]]
}

@test "GPU 14. pl_gpu memory used" {
  run pl_gpu memory used
  [[ $output =~ [0-9]+ ]]
}

@test "GPU 15. pl_gpu memory free: no vcgencmd" {
  VCGENCMD=""
  run pl_gpu memory free
  [[ $output =~ [0-9]+ ]]
}

@test "GPU 16. pl_gpu memory used: no vcgencmd" {
  VCGENCMD=""
  run pl_gpu memory used
  [[ $output =~ [0-9]+ ]]
}

@test "GPU 17. pl_gpu model_memory: Pi mem 256." {
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run pl_gpu model_memory 256=16
  assert_equal $(grep gpu_mem_256 $BOOT_CONF_FILE) "gpu_mem_256=16"
  rm $BOOT_CONF_FILE
}

@test "GPU 18. pl_gpu model_memory: Pi mem 512." {
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run pl_gpu model_memory 512=32
  assert_equal $(grep gpu_mem_512 $BOOT_CONF_FILE) "gpu_mem_512=32"
  rm $BOOT_CONF_FILE
}

@test "GPU 19. pl_gpu model_memory: Pi mem 1024." {
  touch ~/tmp_boot_conf.txt
  BOOT_CONF_FILE=~/tmp_boot_conf.txt # overide pishlib
  run pl_gpu model_memory 1024=64
  assert_equal $(grep gpu_mem_1024 $BOOT_CONF_FILE) "gpu_mem_1024=64"
  rm $BOOT_CONF_FILE
}

@test "GPU 20. pl_gpu temperature" {
  run pl_gpu temperature
  [[ "$output" =~ [0-9]+ ]]
  [[ "$output" -lt 90 ]]
  [[ "$output" -gt 1 ]]
}