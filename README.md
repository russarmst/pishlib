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
        + [mem_is](#mem_is)
        + [mem_total](#mem_total)
        + [mem_greater](#mem_greater)
        + [mem_less](#mem_less) 
        + [mem_rdisk](#mem_rdisk) 
        + [mem_zswap](#mem_zswap) 
        + [mem_swap](#mem_swap) 
    - [GPU Functions](#gpu-Functions)
        + [gpu_mem](#gpu_mem) 
        + [gpu_mem256](#) 
        + [gpu_mem512](#gpu_mem512)
        + [gpu_mem1024](#gpu_mem1024)
    - [CPU functions](cpu-functions)
        + [cpu_id](#cpu_id)
        + [cpu_max](#cpu_max)
        + [cpu_min](#cpu_min)
        + [cpu_ocd](#cpu_ocd)
        + [cpu_oc](#cpu_oc)
        + [cpu_gov](#cpu_gov)
        + [cpu_temp](#cpu_temp)
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
#### mem_is
Suite of functions eg. mem_is256m, mem_is1g etc. which return 0 (true) if the Pi has xxx[m|g] memory otherwise returns 1 (false). Example:
```shell
if mem_is256m; then
    echo 'Your Pi has 256k of total system ram'
fi
```

#### mem_total
Returns total system memory (less GPU memory allocated) in Megabytes (Mb). Example:
```shell
sys_ram = $(mem_total)
echo $sys_ram 
```

#### mem_greater
Returns 0 (true) if the total system ram (less GPU memory allocated) is greater than the supplied parameter, otherwise returns 1 (false). Example:
```shell
if [[ $(mem_greater 512) ]]; then
    echo 'Your Pi has more than 512kB of system memory.'
else
    echo 'Your Pi has less than 512kB of system memory.'
fi
```

#### mem_less
Returns 0 (true) if the total system ram (less GPU memory allocated) is less than the supplied parameter, otherwise returns 1 (false). Example:
```shell
if [[ $(mem_less 512) ]]; then
    echo 'Your Pi has less than 512kB of system memory.'
else
    echo ' Your Pi has more than 512kB of system memory.'
fi
```

#### mem_rdisk
Setups up a ramdisk for temporary files to preserve SD card life by preventing SD writes to ```/tmp```, ```/var/lock```, ```/var/log```, ```/var/run```, ```/var/spool/mqueue``` by deafult.

**Note:** The default sizes have been adapted from the [Debian Mailing List](https://lists.debian.org/debian-devel/2011/04/msg00615.html)

#### mem_zswap

#### mem_swap

### GPU Functions
#### gpu_mem
Function to report or set the amount of memory (in megabytes) to reserve for the exclusive use of the GPU: the remaining memory is allocated to the ARM CPU.

Without a parameter gpu_mem returns the current GPU memory allocation in megabytes.

With an integer as the parameter (in megabytes) sets the GPU memory to the integer.

With `default` as the parameter sets the GPU memory to default value for the Raspberry Pi model.

With `max` as the parameter sets the GPU memory to recommended max value for the Raspberry Pi model.

**Note:** The minimum value is 16, however this disables certain GPU features.

**Note:** On the Raspberry Pi 4 the 3D component of the GPU has its own memory management unit (MMU), and does not use memory from the gpu_mem allocation. Instead memory is allocated dynamically within Linux. This may allow a smaller value to be specified for gpu_mem on the Pi 4, compared to previous models.

#### gpu_mem256
Sets the GPU memory (in megabytes) to the supplied parameter (integer) for Raspberry Pis with 256MB of memory. (It is ignored if memory size is not 256MB). This overrides gpu_mem.

Setting gpu_mem256, gpu_mem512, and gpu_mem1024 will allow swapping the boot drive between Pis with different amounts of RAM without having to edit config.txt each time.

#### gpu_mem512
Sets the GPU memory (in megabytes) to the supplied parameter (integer) for Raspberry Pis with 512MB of memory. (It is ignored if memory size is not 512MB). This overrides gpu_mem.

Setting gpu_mem256, gpu_mem512, and gpu_mem1024 will allow swapping the boot drive between Pis with different amounts of RAM without having to edit config.txt each time.

#### gpu_mem1024
Sets the GPU memory (in megabytes) to the supplied parameter (integer) for Raspberry Pis with 1024MB of memory. (It is ignored if memory size is not 1024MB). This overrides gpu_mem.

Setting gpu_mem256, gpu_mem512, and gpu_mem1024 will allow swapping the boot drive between Pis with different amounts of RAM without having to edit config.txt each time.

### CPU functions
#### cpu_id
#### cpu_max
#### cpu_min
#### cpu_ocd
#### cpu_oc
#### cpu_gov
#### cpu_temp

### GPIO functions

### Model functions
#### model_is4
#### model_is3
#### model_is2
#### model_is1
#### model_isa
#### model_isb
#### model isplus
#### model_iscompute
#### model_iszero
#### model_greater
#### model_less
#### model_get
#### model_has_bt
#### model_has_wifi
#### model_has_net
#### model_hascsi
#### model_is32bit
#### model_is64bit

## Credits
* Russell Armstrong - original author and project maintainer

## TODO
* [ ] Memory functions:
    - [x] Identify how much total RAM the system has:
        + [x] **mem_is256m**
        + [x] **mem_is512m**
        + [x] **mem_is1g**
        + [x] **mem_is2g**
        + [x] **mem_is4g**
        + [x] **mem_is8g**
        + [x] **mem_total**
        + [x] **mem_greater**
        + [x] **mem_less**
    - [ ] **mem_rdisk**
        + [ ] complete spec'ing out function README.md
    - [ ] **mem_zswap**
        + [ ] investigate zswap
        + [ ] spec out zswap
    - [ ] **mem_swap**
        + [ ] investigate swapiness
        + [ ] spec out swapiness
* [ ] GPU functions:
    - [ ] **gpu_mem**
        + [ ] insert table into README.md of default values for each pi model
        + [ ] insert table into README.md of max recommended values for eachpi model
        + [ ] insert examples for each invocation
    - [ ] **gpu_mem256**
        + [ ] insert example for invocation
    - [ ] **gpu_mem512**
        + [ ] insert example for invocation
    - [ ] **gpu_mem1024**
        + [ ] insert example for invocation
    - [ ] **gpu_temp**
* [ ] CPU functions:
    - [ ] Spec out functions in README.md
    - [ ] **cpu_id**
    - [ ] **cpu_max**
    - [ ] **cpu_min**
    - [ ] **cpu_ocd**
    - [ ] **cpu_oc**
    - [ ] **cpu_gov**
    - [ ] **cpu_temp**
* [ ] GPIO functions:
    - [ ] Spec out functions in README.md
* [ ] Model functions:
    - [ ] **model_is4**
    - [ ] **model_is3**
    - [ ] **model_is2**
    - [ ] **model_is1**
    - [ ] **model_isa**
    - [ ] **model_isb**
    - [ ] **model isplus**
    - [ ] **model_iscompute**
    - [ ] **model_iszero**
    - [ ] **model_greater**
    - [ ] **model_less**
    - [ ] **model_get**
    - [ ] **model_has_bt**
    - [ ] **model_has_wifi**
    - [ ] **model_has_net**
    - [ ] **model_is32bit**
    - [ ] **model_is64bit**
    - [ ] **model_hascsi**
