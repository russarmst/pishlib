# pishlib

## Introduction
**pi** **sh**ell **lib**rary is a script containing helper functions for Bash (and others) shell scripts written for Rapsberry Pi computers.

## Table of Contents

* [Installation and Usage](#Installation-and-Usage)
* [Functions](#Functions)
    - [Memory Functions](#Memory-Functions)
        + [mem_is](#mem_is)
        + [mem_total](#mem_total)
        + [mem_greater](#mem_greater)
        + [mem_less](#mem_less) 
        + [mem_rdisk](#mem_rdisk) 
        + [mem_zswap](#mem_zswap) 
        + [mem_swap](#mem_swap) 
    - [GPU Functions](#GPU-Functions)
        + [gpu_mem](#gpu_mem) 
        + [gpu_mem256](#) 
        + [gpu_mem512](#gpu_mem512)
        + [gpu_mem1024](#gpu_mem1024)
    - [CPU functions](CPU-functions)
        + [cpu_id](#cpu_id)
        + [cpu_max](#cpu_max)
        + [cpu_min](#cpu_min)
        + [cpu_ocd](#cpu_ocd)
        + [cpu_oc](#cpu_oc)
        + [cpu_gov](#cpu_gov)
        + [cpu_temp](#cpu_temp)

## Installation and Usage
Clone the project:
```shell
git clone https://github.com/russarmst/pishlib.git
```

In your shell script add the following:
```shell
. /path/to/pishlib
```

## Functions
pishlib contains many functions to query and control a Raspberry Pi from your script.

### Memory Functions
#### mem_is
Suite of functions eg. mem_is256k, mem_is1m etc. which return 0 (true) if the Pi has xxx[k|m] memory otherwise returns 1 (false). Example:
```shell
if mem_is256k; then
    echo 'Your Pi has 256k of total system ram'
```

#### mem_total
Returns total system memory (less GPU memory allocated) in Kilobytes (Kb). Example:
```shell
sys_ram = mem_total

echo $sys_ram 
```

#### mem_greater
Returns 0 (true) if the total system ram (less GPU memory allocated) is greater than the supplied parameter, otherwise returns 1 (false). Example:
```shell
if mem_greater 256; then
    echo 'You have more than 256k of total system ram'
```

#### mem_less
Returns 0 (true) if the total system ram (less GPU memory allocated) is less than the supplied parameter, otherwise returns 1 (false). Example:
```shell
if mem_less 512; then
    echo 'You have less than 512k of total system ram'
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


## Contributing
If you have the time and the ability to contribute then your conributions will be gratefully recieved and credited to you. You can contribute in one of the following ways:
* Todo item implementation via GIthub Pull Request
* Feature requests via Github Issues
* Feature request implementation via Github Pull Requests
* Bug reports via Github Issues
* Additions and corrections to the Documentation and Examples via Github Pull Requests
* Technical review via Github Issues and/or comments in Pull Request. For example are default settings sane, does this methodology work on a particular model of Pi, does this have side effects that the user should be aware of etc.
* Techincal implementation details for functions ie. how would we achieve the desired functionality using bash.

## Credits
* Russell Armstrong - original author and project maintainer

## TODO
* [ ] Memory functions:
    - [ ] Identify how much total RAM the system has:
        + [x] **mem_is256k**
        + [x] **mem_is512k**
        + [x] **mem_is1m**
        + [x] **mem_is2m**
        + [x] **mem_is4m**
        + [x] **mem_is8m**
        + [ ] **mem_total**
        + [ ] **mem_greater**
        + [ ] **mem_less**
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