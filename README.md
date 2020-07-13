# pishlib

## Introduction
The aim of the **pi** **sh**ell **lib**rary (pishlib) is the Swiss Army Knife of shell scripting for the Pi range of computers by implementing elegant functions that make script writing easier, more robust and fun(?).

Why write this:
```shell
sys_mem = $(cat /proc/meminfo |grep MemTotal | awk '{print $2}')

if [[ $sys_mem -lt 4194304 ]] && [[ $sys_mem -gt 2097152 ]]; then
    echo 'Your Pi has 4G of total system ram.'
fi
```

when you can write this:
```shell
. /path/to/pishlib

if mem_is4g; then
    echo 'Your Pi has 4G of total system ram.'
fi
```


## Table of Contents

* [Installation and Usage](#Installation-and-Usage)
* [Contributing](#Contributing)
* [Functions](#Functions)
    - [Memory Functions](#Memory-Functions)
        + [pl-mem_is](#pl-mem_is)
        + [pl-mem_total](#pl-mem_total)
        + [pl-mem_greater](#pl-mem_greater)
        + [pl-mem_less](#pl-mem_less) 
        + [pl-mem_rdisk](#pl-mem_rdisk) 
        + [pl-mem_zswap](#pl-mem_zswap) 
        + [pl-mem_swap](#pl-mem_swap) 
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
#### pl-mem_is
Suite of functions eg. mem_is256m, mem_is1g etc. which return 0 (true) if the Pi has xxx[m|g] memory otherwise returns 1 (false). Example:
```shell
if mem_is256m; then
    echo 'Your Pi has 256k of total system ram'
fi
```

#### pl-mem_total
Returns total system memory (less GPU memory allocated) in Megabytes (Mb). Example:
```shell
sys_ram = $(mem_total)
echo $sys_ram 
```

#### pl-mem_greater
Returns 0 (true) if the total system ram (less GPU memory allocated) is greater than the supplied parameter, otherwise returns 1 (false). Example:
```shell
if [[ $(mem_greater 512) ]]; then
    echo 'Your Pi has more than 512kB of system memory.'
else
    echo 'Your Pi has less than 512kB of system memory.'
fi
```

#### pl-mem_less
Returns 0 (true) if the total system ram (less GPU memory allocated) is less than the supplied parameter, otherwise returns 1 (false). Example:
```shell
if [[ $(mem_less 512) ]]; then
    echo 'Your Pi has less than 512kB of system memory.'
else
    echo ' Your Pi has more than 512kB of system memory.'
fi
```

#### pl-mem_rdisk
Setups up a ramdisk for temporary files to preserve SD card life by preventing SD writes to ```/tmp```, ```/var/lock```, ```/var/log```, ```/var/run```, ```/var/spool/mqueue``` by deafult.

**Note:** The default sizes have been adapted from the [Debian Mailing List](https://lists.debian.org/debian-devel/2011/04/msg00615.html)

#### pl-mem_zswap

#### pl-mem_swap

### GPU Functions
#### pl-gpu_mem
Function to report or set the amount of memory (in megabytes) to reserve for the exclusive use of the GPU, the remaining memory is allocated to the ARM CPU.

```shell
pl-gpu_mem
```
Without a parameter pl-gpu_mem returns the current GPU memory allocation in megabytes. 

**Note:** if your distribution doesn't include the `vcgencmd` program (included with Raspberry Pi OS) or you haven't installed it, the amount of GPU Memory reported will that configured in `/boot/config.txt`. If the `gpu_mem` in `/boot/config.txt` has been changed since the last reboot, the amount of GPU Memory reported will be inaccurate until after the next reboot. With `vcgencmd` in the path the amount of GPU Memory reported will always be accurate. 

```shell
pl-gpu_mem 128
```

Sets the GPU memory to the integer megabytes.

```shell
pl-gpu_mem default
```

The GPU memory is set the following values:

| Pi Model         | gpu_mem default value |
|------------------|-----------------------|
| Pi 1             | 64 |
| Zero             | 64 |
| All other models | 76 |


```shell
pl-gpu_mem max
```

The GPU memory is set to the recommended max value depending on the total system memory as follows:

| Total RAM      | gpu_mem recommended maximum |
|----------------|-----------------------------|
| 256MB          | 128 |
| 512MB          | 384 |
| 1GB or greater | 512 |

**Note:** The minimum value is 16, however this disables certain GPU features.

**Note:** On the Raspberry Pi 4 the 3D component of the GPU has its own memory management unit (MMU), and does not use memory from the gpu_mem allocation. Instead memory is allocated dynamically within Linux. This may allow a smaller value to be specified for gpu_mem on the Pi 4, compared to previous models.

#### pl-gpu_mem256
Sets the GPU memory (in megabytes) to the supplied parameter (integer) for Raspberry Pis with 256MB of memory. (It is ignored if memory size is not 256MB). This overrides gpu_mem.

Setting gpu_mem256, gpu_mem512, and gpu_mem1024 will allow swapping the boot drive between Pis with different amounts of RAM without having to edit config.txt each time.

#### pl-gpu_mem512
Sets the GPU memory (in megabytes) to the supplied parameter (integer) for Raspberry Pis with 512MB of memory. (It is ignored if memory size is not 512MB). This overrides gpu_mem.

Setting gpu_mem256, gpu_mem512, and gpu_mem1024 will allow swapping the boot drive between Pis with different amounts of RAM without having to edit config.txt each time.

#### pl-gpu_mem1024
Sets the GPU memory (in megabytes) to the supplied parameter (integer) for Raspberry Pis with 1024MB or greater of memory. (It is ignored if memory size is not 1024MB). This overrides gpu_mem.

Setting gpu_mem256, gpu_mem512, and gpu_mem1024 will allow swapping the boot drive between Pis with different amounts of RAM without having to edit config.txt each time.

#### pl-gpu_temp

### CPU functions
#### pl-cpu_id
#### pl-cpu_max
#### pl-cpu_min
#### pl-cpu_ocd
#### pl-cpu_oc
#### pl-cpu_gov
#### pl-cpu_temp

### GPIO functions

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
    - [ ] **pl-mem_rdisk**
        + [ ] complete spec'ing out function README.md
    - [ ] **pl-mem_zswap**
        + [ ] investigate zswap
        + [ ] spec out zswap
    - [ ] **pl-mem_swap**
        + [ ] investigate swapiness
        + [ ] spec out swapiness
* [ ] GPU functions:
    - [x] **pl-gpu_mem**
        + [x] insert table into README.md of default values for each pi model
        + [x] insert table into README.md of max recommended values for eachpi model
        + [x] insert examples for each invocation
    - [ ] **pl-gpu_mem256**
        + [ ] insert example for invocation
    - [ ] **pl-gpu_mem512**
        + [ ] insert example for invocation
    - [ ] **pl-gpu_mem1024**
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
