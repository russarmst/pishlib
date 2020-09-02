# pishlib

## Introduction
The aim of the **pi** **sh**ell **lib**rary (pishlib) is to be the Swiss Army Knife of shell scripting for the Pi range of computers by implementing elegant functions that make script writing easier, more robust and fun(?).

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
source /path/to/pishlib

if [[ $(pl_mem is 4096) ]]; then
    echo 'Your Pi has 4G of total system ram.'
fi
```


## Table of Contents

* [Installation and Usage](#Installation-and-Usage)
* [Contributing](#Contributing)
* [Functions](#Functions)
    - [Memory Functions](#Memory-Functions)
        + [pl_mem](#pl_mem)
        + [pl_mem limit](#pl_mem-limit)
        + [pl_mem lt](#pl_mem-lt)
        + [pl_mem le](#pl_mem-le)
        + [pl_mem gt](#pl_mem-gt) 
        + [pl_mem ge](#pl_mem-ge) 
        + [pl_mem eq](#pl_mem-eq)
        + [pl_mem is](#pl_mem-is)
        + [pl_mem ramdisk](#pl_mem-ramdisk) 
        + [pl_mem zswap](#pl_mem-zswap) 
        + [pl_mem swap](#pl_mem-swap) 
    - [GPU Functions](#gpu-Functions)
        + [pl_gpu_mem](#pl_gpu_mem) 
        + [pl_gpu_mem default](#pl_gpu_mem-deafult)
        + [pl_gpu_mem set](#pl_gpu_mem-set)
        + [pl_gpu_mem max](#pl_gpu_mem-max)
        + [pl_gpu_mem gt](#pl_gpu_mem-gt)
        + [pl_gpu_mem ge](#pl_gpu_mem-ge)
        + [pl_gpu_mem lt](#pl_gpu_mem-lt)
        + [pl_gpu_mem le](#pl_gpu_mem-le)
        + [pl_gpu_mem set256](#pl_gpu_mem-set256)
        + [pl_gpu_mem set512](#pl_gpu_mem-set512)
        + [pl_gpu_mem set1024](#pl_gpu_mem-set1024)
        + [pl_gpu_core temp](#pl_gpu_core-temp)
        + [pl_gpu_core speed](#pl_gpu_core-speed)
        + [pl_gpu_core oc](#pl_gpu_core-oc)
    - [CPU functions](#cpu-functions)
        + [pl_cpu id](#pl_cpu-id)
        + [pl_cpu max](#pl_cpu-max)
        + [pl_cpu min](#pl_cpu-min)
        + [pl_cpu ocd](#pl_cpu-ocd)
        + [pl_cpu oc](#pl_cpu-oc)
        + [pl_cpu gov](#pl_cpu-gov)
        + [pl_cpu temp](#pl_cpu-temp)
    - [Model Functions](#model-functions)
        + [pl_model](#pl_model)
        + [pl_model manufacturer](#pl_model-manufacturer)
        + [pl_model memory](#pl_model-memory)
        + [pl_model processor](#pl_model-processor)
        + [pl_model revision](#pl_model-revision)
        + [pl_model type](#pl_model-type)
        + [pl_model summary](#pl_model-summary)
        + [pl_model gt](#pl_model-gt)
        + [pl_model lt](#pl_model-lt)
        + [pl_model eq](#pl_model-eq)
        + [pl_model has_wifi](#pl_model-has_wifi)
        + [pl_model has_lan](#pl_model-has_lan)
        + [pl_model has_bt](#pl_model-has_bt)
        + [pl_model csi](#pl_model-csi)
        + [pl_model is32bit](#pl_model-is32bit)
        + [pl_model is64bit](#pl_model-is64bit)     

* [Credits](#Credits)
* [TODO](#Todo)


## Installation and Usage
Clone the project:
```shell
git clone https://github.com/russarmst/pishlib.git
```

pishlib is seperated into several different modules so you can source only those modules you require. The functions in some modules are dependent on the functions of other modules and these are handled automatically for your convenience.

To include just the memory functions add the following to your script:
```shell
source /path/to/pishlib_mem
```

To include all the pishlib functions in your script add the following:
```shell
source /path/to/pishlib
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

To clone the repo do the following:
```shell
git clone https://github.com/russarmst/pishlib.git
git submodule update --init --recursive
cd /path/to/pishlib
./test
```

## Functions
pishlib contains many functions to query, configure and control a Raspberry Pi from your script and are grouped by functionality.

### Memory Functions
All pishlib memory functions report or compare memory in Mebibytes (MiB) and therefore where integer memory parameters are required they should also be in Mebibytes (MiB).

#### pl_mem
Without parameters returns the amount of system memory as an intger in Mebibytes (MiB).

**Note: the amount of memory reported is that allocated to the ARM CPU. It will be less than the amount of RAM for the specific model of Raspberry Pi (`pl_model memory`) as a proportion of the RAM is allocated to the GPU.**

Example:
```shell
echo "Your Pi has $(pl_mem)MiB of system memory."
```

#### pl_mem limit
This is used to force a Raspberry Pi to limit its memory capacity. Pass the total amount of RAM, in Mebibytes (MiB), you wish the Pi to use.

This value of the parameter can between a minimum of 128MiB, and a maximum of the total memory installed on the board.

* [ ] TODO: implement total_mem https://www.raspberrypi.org/documentation/configuration/config-txt/memory.md

#### pl_mem lt
Returns a boolean depending on the truthiness if the system memory is less than the supplied integer in Mebibytes (MiB).

Example:
```shell
if [[ $(pl_mem lt 512) ]]; then
    echo "Your Pi doesn't have the meet the minimum amount of system memory to run this programme."
    exit
fi
```

#### pl_mem le
Returns a boolean depending on the truthiness if the system memory is less than or equal to the supplied integer Mebibytes (MiB).

Example:
```shell
if [[ $(pl_mem le 512) ]]; then
    echo "Your Pi doesn't have the meet the minimum amount of system memory to run this programme."
    exit
fi
```

#### pl_mem gt
Returns a boolean depending on the truthiness if the system memory is greater than supplied integer Mebibytes (MiB).

Example:
```shell
if [[ $(pl_mem gt 512) ]]; then
    echo "Your Pi meets the minimum amount of system memory to run this programme."
    exit
else
    echo "Your Pi doesn't have the meet the minimum amount of system memory to run this programme."
    exit
fi
```

#### pl_mem ge
Returns a boolean depending on the truthiness if the system memory is greater than or equal to supplied integer Mebibytes (MiB).

Example:
```shell
if [[ $(pl_mem ge 512) ]]; then
    echo "Your Pi meets the minimum amount of system memory to run this programme."
    exit
else
    echo "Your Pi doesn't have the meet the minimum amount of system memory to run this programme."
    exit
fi
```

#### pl_mem eq
Returns a boolean depending on the truthiness if the system memory is equal to the supplied integer Mebibytes (MiB).

**Note:  the amount of memory tested is that allocated to the ARM CPU. It will be less than the amount of RAM for the specific model of Raspberry Pi as a proportion of RAM is allocated to the GPU. If you want to test if a Raspberry Pi has a certain amount of memory it maybe more appropriate to use `pl_model memory`.**

Example:
```shell
    if [[ $(pl_mem eq 1024) ]]; then
        echo "Your Pi has 1024Mb of system memory."
```

#### pl_mem is
Returns a boolean if the system memory is equal to xxxx. The only sensible values for xxxx are 256, 512, 1024, 2048, 4096, or 8192.

Example:
```shell
    if [[ $(pl_mem is 1024) ]]; then
        echo "Your Pi has 1024kiB of memory."
```

#### pl_mem ramdisk
* [ ] Todo: setup up a ramdisk for temporary files to preserve SD card life by preventing SD writes to ```/tmp```, ```/var/lock```, ```/var/log```, ```/var/run```, ```/var/spool/mqueue``` by deafult.

**Note:** The default sizes have been adapted from the [Debian Mailing List](https://lists.debian.org/debian-devel/2011/04/msg00615.html)

#### pl_mem zswap
* [ ] Todo: spec up and implement.

#### pl_mem swap
* [ ] Todo: spec up and implement.


### GPU Functions
#### pl_gpu_mem
Function to report or set the amount of memory (in megabytes) to reserve for the exclusive use of the GPU, the remaining memory is allocated to the ARM CPU.

```shell
pl_gpu_mem
```
Without a parameter pl_gpu_mem returns the current GPU memory allocation in megabytes. 

**Note:** if your distribution doesn't include the `vcgencmd` program (included with Raspberry Pi OS) or you haven't installed it, the amount of GPU Memory reported will be that configured in `/boot/config.txt`. If `gpu_mem` in `/boot/config.txt` has been changed since the last reboot, the amount of GPU Memory reported will be inaccurate until after the next reboot. With `vcgencmd` in the path the amount of GPU Memory reported will always be accurate. If `gpu_mem` is not specified in `/boot/config.txt` then the default gpu_mem allocation is reported as 64Mb if RAM<1Gb or 76 if RAM>1Gb.


#### pl_gpu_mem default
The GPU memory is set the following values:
| Pi Model Memory  | gpu_mem default value |
|------------------|-----------------------|
| =< 1Gb           | 64                    |
| > 1Gb            | 76                    |

The new configuration won't take affect until after the next reboot.

Example:
```shell
pl_gpu_mem default
```


#### pl_gpu_mem set
Sets `gpu_mem` in `/boot/config.txt` to the integer supplied as a parameter. The new configuration won't take affect until after the next reboot.

Example:
```shell
pl_gpu_mem set 128
```
**Note:** The new configuration won't take affect until after the next reboot.

**Note:** On the Raspberry Pi 4 the 3D component of the GPU has its own memory management unit (MMU), and does not use memory from the gpu_mem allocation. Instead memory is allocated dynamically within Linux. This may allow a smaller value to be specified for gpu_mem on the Pi 4, compared to previous models.


#### pl_gpu_mem max
The GPU memory is set to the recommended max value depending on the total system memory as follows:

| Total RAM      | gpu_mem recommended maximum |
|----------------|-----------------------------|
| 256MB          | 128 |
| 512MB          | 384 |
| 1GB or greater | 512 |

Example:
```shell
pl_gpu_mem max
```

#### pl_gpu_mem gt
Tests if the memory allocated to the GPU is **Greater Than** xxx which should be an integer in Megabytes.

```shell
    min_gpu_mem=128
    if [[ $(pl_gpu_mem gt min_gpu_mem) ]]; then
      echo "Your system has more than the minimum amount of GPU memory allocated."
    fi
```

#### pl_gpu_mem ge
Tests if the memory allocated to the GPU is **Greater Than or Equal** to xxx which should be an integer in Megabytes.

```shell
    min_gpu_mem=128
    if [[ $(pl_gpu_mem ge min_gpu_mem) ]]; then
      echo "Your system has more than the minimum amount of GPU memory allocated."
    fi
```

#### pl_gpu_mem lt
Tests if the memory allocated to the GPU is **Less Than** xxx which should be an integer in Megabytes.

```shell
    min_gpu_mem=128
    if [[ $(pl_gpu_mem lt min_gpu_mem) ]]; then
      echo "Your system has less than the minimum amount of GPU memory allocated."
      exit
    fi
```

#### pl_gpu_mem le
Tests if the memory allocated to the GPU is **Less Than or Equal** to xxx which should be an integer in Megabytes.

```shell
    min_gpu_mem=128
    if [[ $(pl_gpu_mem le min_gpu_mem) ]]; then
      echo "Your system has less than the minimum amount of GPU memory allocated."
      exit
    fi
```

#### pl_gpu_mem [set256|set512|set1024]
Sets the GPU memory (in megabytes) to xxx for Raspberry Pis with 256Mb|512Mb|1024Mb of memory. (It is ignored if memory size is not 256Mb|512Mb|1024Mb). This overrides the gpu_mem setting in /boot/config.txx.

Setting this will allow swapping the boot drive between Pis with different amounts of RAM without having to edit /boot/config.txt each time.

Example:
```shell
pl_gpu_mem set256 64
```

#### pl_gpu_core temp
* [ ] TODO: to implement
#### pl_gpu_core speed
* [ ] TODO: to implement
#### pl_gpu_core oc
* [ ] TODO: to implement

### CPU functions
#### pl-cpu id
#### pl-cpu max
#### pl-cpu min
#### pl-cpu ocd
#### pl-cpu oc
#### pl-cpu gov
#### pl-cpu temp

### Model functions
#### pl_model
Prints a summary of the Raspberry Pi attributes.

#### pl_model manufacturer
Returns the manufacturer of the Raspberry Pi board as a string.

#### pl_model memory
Returns the amount of memory installed as an integer in Mb.

#### pl_model processor
Returns the 

#### pl_model revision
#### pl_model type
#### pl_model summary
#### pl_model gt
#### pl_model lt
#### pl_model eq
#### pl_model has_wifi
#### pl_model has_lan
#### pl_model has_bt
#### pl_model has_csi
#### pl_model is32bit
#### pl_model is64bit

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
