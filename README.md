# pishlib

## Introduction
The aim of the **pi** **sh**ell **lib**rary (pishlib) is the Swiss Army Knife of shell scripting for the Pi range of computers by implementing elegant functions that make script writing easier, more robust and fun(?).

**Note:** For the time being this code should be regarded as Alpha where:
* changes to the code and function names may break scripts using it
* the code contains bugs
* changes to the code causes regressions

Why write this:
```shell
sys_mem=$(awk '/MemTotal/ {print $2}' /proc/meminfo)

if [[ $sys_mem -lt 4194304 ]] && [[ $sys_mem -gt 2097152 ]]; then
    echo 'Your Pi has 4G of total system ram.'
fi
```

when you can write this:
```shell
. /path/to/pishlib

if pl-sys-mem is4g; then
    echo 'Your Pi has 4G of total system ram.'
fi
```


## Table of Contents

* [Installation and Usage](#Installation-and-Usage)
* [Contributing](#Contributing)
* [Functions](#Functions)
    - [Memory Functions](#Memory-Functions)
        + [pl-sys_mem](#pl-sys_mem)
        + [pl-sys_mem lt xxxx](#pl-sys_mem-lt-xxxx)
        + [pl-sys_mem gt xxxx](#pl-sys_mem-gt-xxxx) 
        + [pl-sys_mem eq xxxx](#pl-sys_mem-eq-xxxx)
        + [pl-sys_mem isxxx[m|g]](#pl-sys_mem-isxxx[m|g])
        + [pl-sys_mem ramdisk](#pl-sys_mem-ramdisk) 
        + [pl-sys_mem zswap](#pl-sys_mem-zswap) 
        + [pl-sys_mem swap](#pl-sys_mem-swap) 
    - [GPU Functions](#gpu-Functions)
        + [pl-gpu_mem](#pl-gpu_mem) 
        + [pl-gpu_mem256](#pl-gpu_mem256) 
        + [pl-gpu_mem512](#pl-gpu_mem512)
        + [pl-gpu_mem1024](#pl-gpu_mem1024)
        + [pl-gpu_temp](#pl-gpu_temp)
    - [CPU functions](cpu-functions)
        + [pl-cpu_id](#pl-cpu_id)
        + [pl-cpu_max](#pl-cpu_max)
        + [pl-cpu_min](#pl-cpu_min)
        + [pl-cpu_ocd](#pl-cpu_ocd)
        + [pl-cpu_oc](#pl-cpu_oc)
        + [pl-cpu_gov](#pl-cpu_gov)
        + [pl-cpu_temp](#pl-cpu_temp)
* [Credits](#Credits)
* [TODO](#Todo)


## Installation and Usage
Clone the project:
```shell
git clone https://github.com/russarmst/pishlib.git
```

In your shell script add the following:
```shell
. /path/to/pishlib
```


## Contributing
If you have the time and the ability to contribute then your conributions will be gratefully recieved and credited to you. You can contribute in one of the following ways:
* Got an idea for a function to implement? Open a Github Issue for a **Feature Request**.
* Found a **bug**? Open a Github Issue for a Bug Notice.
* Have a Pi and some spare time? Spend some time **testing** and let us know if you find a bug.
* Desperate to have a feature implemented? If you have the ability file a Pull Request with your **feature implemented**.
* Want to donate some of your time? Pick an item off the Todo list, implement it and file a Pull Request.
* Have you spotted a **typo or a correction** that is needed in the Documentation? File a Pull Request with your correction or a Github issue with details of what need to be chnaged. 
* Spotted something that doens't quite make sense or could be implemeneted better? File a Github Issue for **Technical Review** and/or post a comment in the relevant Pull Request. 
* Do you kow how we might implement (in Bash) one of the functions on the Todo list? File a Github Issue for **Techincal Review** with details of the implementation.


## Functions
pishlib contains many functions to query and control a Raspberry Pi from your script and are grouped by functionality .

### Memory Functions
#### pl-sys_mem
Returns the amount of system memory as an intger in Mb.

Example:
```shell
echo "Your Pi has $(pl-sys_mem)Mb of system memory."
```

#### pl-sys_mem lt xxxx
Returns a boolean depending on the truthiness if the system memory is less than supplied integer (xxxx) in Mb.

Example:
```shell
if [[ pl-sys_mem lt 512 ]]; then
    echo "Your Pi doesn't have the meet the minimum amount of system memory to run this programme."
    exit
fi
```

#### pl-sys_mem gt xxxx
Returns a boolean depending on the truthiness if the system memory is greater than supplied integer (xxxx) in Mb.

Example:
```shell
if [[ pl-sys_mem gt 512 ]]; then
    echo "Your Pi meets the minimum amount of system memory to run this programme."
    exit
else
    echo "Your Pi doesn't have the meet the minimum amount of system memory to run this programme."
    exit
fi
```

#### pl-sys_mem eq xxxx
Returns a boolean depending on the truthiness if the system memory is equal to the supplied integer (xxxx) in Mb.

Example:
```shell
    if [[ pl-sys_mem eq 1024 ]]; then
        echo "Your Pi has 1024Mb of system memory."
```

#### pl-sys_mem isxxx[m|g]
Returns a boolean if the system memory is equal to xxx[m|g]. Valid values for xxx are 256m, 512m, 1g, 2g, 4g, or 8g.

Example:
```shell
    if [[ pl-sys_mem is1g ]]; then
        echo "Your Pi has 1024Mb of system memory."
```

#### pl-sys_mem ramdisk
Still todo. Intends to setup up a ramdisk for temporary files to preserve SD card life by preventing SD writes to ```/tmp```, ```/var/lock```, ```/var/log```, ```/var/run```, ```/var/spool/mqueue``` by deafult.

**Note:** The default sizes have been adapted from the [Debian Mailing List](https://lists.debian.org/debian-devel/2011/04/msg00615.html)

#### pl-sys_mem zswap
Still todo.

#### pl-sys_mem swap
Still todo.


### GPU Functions
#### pl-gpu_mem
Function to report or set the amount of memory (in megabytes) to reserve for the exclusive use of the GPU, the remaining memory is allocated to the ARM CPU.

```shell
pl-gpu_mem
```
Without a parameter pl-gpu_mem returns the current GPU memory allocation in megabytes. 

**Note:** if your distribution doesn't include the `vcgencmd` program (included with Raspberry Pi OS) or you haven't installed it, the amount of GPU Memory reported will that configured in `/boot/config.txt`. If the `gpu_mem` in `/boot/config.txt` has been changed since the last reboot, the amount of GPU Memory reported will be inaccurate until after the next reboot. With `vcgencmd` in the path the amount of GPU Memory reported will always be accurate. 

#### pl-gpu_mem xxx
Sets the GPU memory to the integer megabytes. Example:

```shell
pl-gpu_mem 128
```

#### pl-gpu_mem default
The GPU memory is set the following values:
| Pi Model         | gpu_mem default value |
|------------------|-----------------------|
| Pi 1             | 64 |
| Zero             | 64 |
| All other models | 76 |

Example:
```shell
pl-gpu_mem default
```

#### pl-gpu_mem max
The GPU memory is set to the recommended max value depending on the total system memory as follows:

| Total RAM      | gpu_mem recommended maximum |
|----------------|-----------------------------|
| 256MB          | 128 |
| 512MB          | 384 |
| 1GB or greater | 512 |

**Note:** The minimum value is 16, however this disables certain GPU features.

**Note:** On the Raspberry Pi 4 the 3D component of the GPU has its own memory management unit (MMU), and does not use memory from the gpu_mem allocation. Instead memory is allocated dynamically within Linux. This may allow a smaller value to be specified for gpu_mem on the Pi 4, compared to previous models.

Example:
```shell
pl-gpu_mem max
```

#### pl-gpu_mem gt xxx
Tests if the memory allocated to the GPU is **Greater Than** than xxx which should be an integer in Megabytes.

```shell
    min_gpu_mem=128
    if [[ pl-gpu_mem gt min_gpu_mem ]]; then
      echo "Your system has more than the minimum amount of GPU memory allocated."
    fi
```

#### pl-gpu_mem lt xxx
Tests if the memory allocated to the GPU is **Less Than** than xxx which should be an integer in Megabytes.

```shell
    min_gpu_mem=128
    if [[ pl-gpu_mem lt min_gpu_mem ]]; then
      echo "Your system has less than the minimum amount of GPU memory allocated."
      exit
    fi
```

#### pl-gpu_mem set256 xxx
Sets the GPU memory (in megabytes) to xxx which should be an integer in Megabytes for Raspberry Pis with 256MB of memory. (It is ignored if memory size is not 256MB). This inserts or overwrites gpu_mem_256=xxx in /boot/config.txt. This overrides the gpu_mem setting in /boot/config.txx.

Setting this will allow swapping the boot drive between Pis with different amounts of RAM without having to edit /boot/config.txt each time.

#### pl-gpu_mem set512 xxx
Sets the GPU memory (in megabytes) to xxx which should be an integer in Megabytes for Raspberry Pis with 512MB of memory. (It is ignored if memory size is not 512MB). This inserts or overwrites gpu_mem_512=xxx in /boot/config.txt. This overrides the gpu_mem setting in /boot/config.txx.

Setting this will allow swapping the boot drive between Pis with different amounts of RAM without having to edit config.txt each time.

#### pl-gpu_mem set1024 xxx
Sets the GPU memory (in megabytes) to xxx which should be an integer in Megabytes for Raspberry Pis with 1024MB of memory. (It is ignored if memory size is not 1024MB). This inserts or overwrites gpu_mem_1024=xxx in /boot/config.txt. This overrides the gpu_mem setting in /boot/config.txx.

Setting this will allow swapping the boot drive between Pis with different amounts of RAM without having to edit config.txt each time.


### pl-gpu_core temp
Returns the temperature of the GPU core as an integer in degrees centigrade.

Example:
```shell
    g_temp=$(pl-gpu_temp)
    echo "The GPU core is currently $g_temp degrees centigrade."
```


#### pl-gpu_core speed


#### pl-gpu_core oc

### CPU functions
#### pl-cpu_id
#### pl-cpu_max
#### pl-cpu_min
#### pl-cpu_ocd
#### pl-cpu_oc
#### pl-cpu_gov
#### pl-cpu_temp

### Model functions
#### pl-model_is4
#### pl-model_is3
#### pl-model_is2
#### pl-model_is1
#### pl-model_isa
#### pl-model_isb
#### pl-model isplus
#### pl-model_iscompute
#### pl-model_iszero
#### pl-model_greater
#### pl-model_less
#### pl-model_get
#### pl-model_has_bt
#### pl-model_has_wifi
#### pl-model_has_net
#### pl-model_hascsi
#### pl-model_is32bit
#### pl-model_is64bit

### GPIO functions

### CSI Functions

### Wifi Functions

### BT Functions

### Camera Functions

### Screen Functions

### Audio Functions


## Credits
* Russell Armstrong - original author and project maintainer

## TODO
* [ ] Memory functions:
    - [x] Identify how much total RAM the system has:
        + [x] **pl-mem_is256m**
        + [x] **pl-mem_is512m**
        + [x] **pl-mem_is1g**
        + [x] **pl-mem_is2g**
        + [x] **pl-mem_is4g**
        + [x] **pl-mem_is8g**
        + [x] **pl-mem_total**
        + [x] **pl-mem_greater**
        + [x] **pl-mem_less**
    - [ ] **pl-sys_mem rdisk**
        + [ ] complete spec'ing out function README.md
    - [ ] **pl-sys_mem zswap**
        + [ ] investigate zswap
        + [ ] spec out zswap
    - [ ] **pl-sys_mem swap**
        + [ ] investigate swapiness
        + [ ] spec out swapiness
* [ ] GPU functions:
    - [x] **pl-gpu_mem**
        + [x] insert table into README.md of default values for each pi model
        + [x] insert table into README.md of max recommended values for each pi model
        + [x] insert examples for each invocation
    - [ ] **pl-gpu_mem set256**
        + [ ] insert example for invocation
    - [ ] **pl-gpu_mem set512**
        + [ ] insert example for invocation
    - [ ] **pl-gpu_mem set1024**
        + [ ] insert example for invocation
    - [ ] **pl-gpu_temp**
* [ ] CPU functions:
    - [ ] Spec out functions in README.md
    - [ ] **pl-cpu_id**
    - [ ] **pl-cpu_max**
    - [ ] **pl-cpu_min**
    - [ ] **pl-cpu_ocd**
    - [ ] **pl-cpu_oc**
    - [ ] **pl-cpu_gov**
    - [ ] **pl-cpu_temp**
* [ ] GPIO functions:
    - [ ] Spec out functions in README.md
* [ ] Model functions:
    - [ ] **pl-model_is4**
    - [ ] **pl-model_is3**
    - [ ] **pl-model_is2**
    - [ ] **pl-model_is1**
    - [ ] **pl-model_isa**
    - [ ] **pl-model_isb**
    - [ ] **pl-model isplus**
    - [ ] **pl-model_iscompute**
    - [ ] **pl-model_iszero**
    - [ ] **pl-model_greater**
    - [ ] **pl-model_less**
    - [ ] **pl-model_get**
    - [ ] **pl-model_has_bt**
    - [ ] **pl-model_has_wifi**
    - [ ] **pl-model_has_net**
    - [ ] **pl-model_is32bit**
    - [ ] **pl-model_is64bit**
    - [ ] **pl-model_hascsi**
