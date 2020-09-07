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
    - [CPU functions](#cpu-functions)
        + [pl_cpu freq_min](#pl_cpu-freq_min)
        + [pl_cpu freq_max](#pl_cpu-freq_max)
        + [pl_cpu govenor](#pl_cpu-govenor)
        + [pl_cpu govenor_up_threshold](pl_cpu-govenor_up_threshold)
        + [pl_cpu govenor_down_threshold](pl_cpu-govenor_down_threshold)
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
    - [Overclocking functions](#overclocking-functions)
        + [pl_overclock cpu_freq](#pl_overclock-cpu_freq)
        + [pl_overclock cpu_freq_min](#pl_overclock-cpu_freq_min)
        + [pl_overclock gpu_freq](#pl_overclock-gpu_freq)
        + [pl_overclock gpu_freq_min](#pl_overclock-gpu_freq_min)
        + [pl_overclock over_voltage](#pl_overclock-over_voltage)
        + [pl_overclock over_voltage_min](#pl_overclock-over_voltage_min)
        + [pl_overclock over_voltage_sdram](#pl_overclock-over_voltage_sdram)
        + [pl_overclock sdram_freq](#pl_overclock-sdram_freq)
        + [pl_overclock sdram_freq_min](#pl_overclock-sdram_freq_min)
        + [pl_overclock temp_limit](#pl_overclock-temp_limit)
        + [pl_overclock temp_soft_limit](#pl_overclock-temp_soft_limit)
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

#### ***pl_mem***
Without parameters returns the amount of system memory as an intger in Mebibytes (MiB).

**Note: the amount of memory reported is that allocated to the ARM CPU. It will be less than the amount of RAM for the specific model of Raspberry Pi (`pl_model memory`) as a proportion of the RAM is allocated to the GPU.**

Example:
```shell
echo "Your Pi has $(pl_mem)MiB of system memory."
```

#### ***pl_mem limit***
This is used to force a Raspberry Pi to limit its memory capacity. Pass the total amount of RAM, in Mebibytes (MiB), you wish the Pi to use.

This value of the parameter can between a minimum of 128MiB, and a maximum of the total memory installed on the board.

* [ ] TODO: implement total_mem https://www.raspberrypi.org/documentation/configuration/config-txt/memory.md

#### ***pl_mem lt***
Returns a boolean depending on the truthiness of the system memory being less than the supplied integer in Mebibytes (MiB).

Example:
```shell
if [[ $(pl_mem lt 512) ]]; then
    echo "Your Pi doesn't have the meet the minimum amount of system memory to run this programme."
    exit
fi
```

#### ***pl_mem le***
Returns a boolean depending on the truthiness of the system memory being less than or equal to the supplied integer Mebibytes (MiB).

Example:
```shell
if [[ $(pl_mem le 512) ]]; then
    echo "Your Pi doesn't have the meet the minimum amount of system memory to run this programme."
    exit
fi
```

#### ***pl_mem gt***
Returns a boolean depending on the truthiness of the system memory being greater than supplied integer Mebibytes (MiB).

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

#### ***pl_mem ge***
Returns a boolean depending on the truthiness of the system memory being greater than or equal to supplied integer Mebibytes (MiB).

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

#### ***pl_mem eq***
Returns a boolean depending on the truthiness of the system memory being equal to the supplied integer Mebibytes (MiB).

**Note:  the amount of memory tested is that allocated to the ARM CPU. It will be less than the amount of RAM for the specific model of Raspberry Pi as a proportion of RAM is allocated to the GPU. If you want to test if a Raspberry Pi has a certain amount of memory it maybe more appropriate to use `pl_model memory`.**

Example:
```shell
    if [[ $(pl_mem eq 1024) ]]; then
        echo "Your Pi has 1024Mb of system memory."
```

#### ***pl_mem is***
Returns a boolean depending on the truthiness of the total memory installed on the board being equal to the supplied integer Mebibytes (MiB).  The only sensible values for the integer are 256, 512, 1024, 2048, 4096, or 8192.

Example:
```shell
    if [[ $(pl_mem is 1024) ]]; then
        echo "Your Pi has 1024kiB of memory."
```
* TODO: decide to keep this or move it to pl_model module?


#### ***pl_mem ramdisk***
* [ ] Todo: setup up a ramdisk for temporary files to preserve SD card life by preventing SD writes to ```/tmp```, ```/var/lock```, ```/var/log```, ```/var/run```, ```/var/spool/mqueue``` by deafult.

**Note:** The default sizes have been adapted from the [Debian Mailing List](https://lists.debian.org/debian-devel/2011/04/msg00615.html)

#### ***pl_mem zswap***
* [ ] Todo: spec up and implement.

#### ***pl_mem swap***
* [ ] Todo: spec up and implement.


### GPU Functions
#### ***pl_gpu_mem***
Function to report or set the amount of memory (in megabytes) to reserve for the exclusive use of the GPU, the remaining memory is allocated to the ARM CPU.

```shell
pl_gpu_mem
```
Without a parameter pl_gpu_mem returns the current GPU memory allocation in megabytes. 

**Note:** if your distribution doesn't include the `vcgencmd` program (included with Raspberry Pi OS) or you haven't installed it, the amount of GPU Memory reported will be that configured in `/boot/config.txt`. If `gpu_mem` in `/boot/config.txt` has been changed since the last reboot, the amount of GPU Memory reported will be inaccurate until after the next reboot. With `vcgencmd` in the path the amount of GPU Memory reported will always be accurate. If `gpu_mem` is not specified in `/boot/config.txt` then the default gpu_mem allocation is reported as 64Mb if RAM<1Gb or 76 if RAM>1Gb.


#### ***pl_gpu_mem default***
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


#### ***pl_gpu_mem set***
Sets `gpu_mem` in `/boot/config.txt` to the integer supplied as a parameter. The new configuration won't take affect until after the next reboot.

Example:
```shell
pl_gpu_mem set 128
```
**Note:** The new configuration won't take affect until after the next reboot.

**Note:** On the Raspberry Pi 4 the 3D component of the GPU has its own memory management unit (MMU), and does not use memory from the gpu_mem allocation. Instead memory is allocated dynamically within Linux. This may allow a smaller value to be specified for gpu_mem on the Pi 4, compared to previous models.


#### ***pl_gpu_mem max***
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

#### ***pl_gpu_mem gt***
Tests if the memory allocated to the GPU is **Greater Than** xxx which should be an integer in Megabytes.

```shell
    min_gpu_mem=128
    if [[ $(pl_gpu_mem gt min_gpu_mem) ]]; then
      echo "Your system has more than the minimum amount of GPU memory allocated."
    fi
```

#### ***pl_gpu_mem ge***
Tests if the memory allocated to the GPU is **Greater Than or Equal** to xxx which should be an integer in Megabytes.

```shell
    min_gpu_mem=128
    if [[ $(pl_gpu_mem ge min_gpu_mem) ]]; then
      echo "Your system has more than the minimum amount of GPU memory allocated."
    fi
```

#### ***pl_gpu_mem lt***
Tests if the memory allocated to the GPU is **Less Than** xxx which should be an integer in Megabytes.

```shell
    min_gpu_mem=128
    if [[ $(pl_gpu_mem lt min_gpu_mem) ]]; then
      echo "Your system has less than the minimum amount of GPU memory allocated."
      exit
    fi
```

#### ***pl_gpu_mem le***
Tests if the memory allocated to the GPU is **Less Than or Equal** to xxx which should be an integer in Megabytes.

```shell
    min_gpu_mem=128
    if [[ $(pl_gpu_mem le min_gpu_mem) ]]; then
      echo "Your system has less than the minimum amount of GPU memory allocated."
      exit
    fi
```

#### ***pl_gpu_mem [set256***|set512|set1024]
Sets the GPU memory (in megabytes) to xxx for Raspberry Pis with 256Mb|512Mb|1024Mb of memory. (It is ignored if memory size is not 256Mb|512Mb|1024Mb). This overrides the gpu_mem setting in /boot/config.txx.

Setting this will allow swapping the boot drive between Pis with different amounts of RAM without having to edit /boot/config.txt each time.

Example:
```shell
pl_gpu_mem set256 64
```

#### ***pl_gpu_core temp***
* [ ] TODO: to implement
#### ***pl_gpu_core speed***
* [ ] TODO: to implement

### CPU functions
#### ***pl_cpu freq_min***
Returns the minimum frequency the cpu will run at when dynamic clocking is active.

Example:
```shell
    echo "When idle this Raspberry Pi runs at $(pl_cpu freq_min)Mhz."
```

#### ***pl_cpu freq_max***
Returns the maximum frequency the cpu will run at when dynamic clocking is active.

Example:
```shell
    echo "When busy this Raspberry Pi runs at $(pl_cpu freq_min)Mhz."
```

#### ***pl_cpu govenor***
When no parameter is passed this function returns the active CPU frequency govenor as a string.

Example:
```shell
    echo "The active CPU frequency govenor is $(pl_cpu govenor)."
```

When a parameter is passed the govenor is set accordingly. The parameter should be `conservative`, `ondemand`, `performance`, `powersave`, `schedutil`, or `userspace`.     

Example:
```shell
    gov=ondemand
    echo "Setting the CPU frequency govenor to $gov."
    pl_cpu govenor gov
```

#### ***pl_cpu govenor_up_threshold***
The average % CPU utilisation needs to be more than the govenor_up_threshold (in %) before the CPU frequency is increased.

When no parameter is passed this function returns the up threshold for the CPU frquency govenor. 

Example:
```shell
    echo "The CPU frequency govenor up theshold is $(pl-cpu govenor_up_threshold)%."
```
When an integer (in %) is passed the CPU frequency govenor up threshold is set accordingly.

Example:
```shell
    cpu_utilisation_percentage=80
    echo "The CPU frequency govenor up theshold is being set to $cpu_utilisation_percentage%."
    pl_cpu govenor_up_threshold $cpu_utilisation_percentage
```

#### ***pl_cpu govenor_down_threshold***
The average % CPU utilisation needs to be less than the govenor_down_threshold (in %) before the CPU frequency is decreased.

When no parameter is passed this function returns the down threshold for the CPU frquency govenor. 

Example:
```shell
    echo "The CPU frequency govenor down theshold is $(pl-cpu govenor_down_threshold)%."
```
When an integer (in %) is passed the CPU frequency govenor down threshold is set accordingly.

Example:
```shell
    cpu_utilisation_percentage=80
    echo "The CPU frequency govenor down theshold is being set to $cpu_utilisation_percentage%."
    pl_cpu govenor_down_threshold $cpu_utilisation_percentage
```

#### ***pl_cpu temp***
Returns the current CPU core temperature in degrees C.


### Model functions

#### ***pl_model print_summary***
Pretty prints a summary of the Raspberry Pi model.

Example:
```shell
    pl_model print_summary
```

#### ***pl_model manufacturer***
Returns the manufacturer of the Raspberry Pi board as a string.

Example:
```shell
    echo "This Raspberry Pi was manufactured by $(pl_model manufacturer)"
```

#### ***pl_model memory***
Returns the amount of memory installed as an integer in Mb.

Example:
```shell
    echo "This Raspberry Pi has $(pl_model memory)Mb."
```

#### ***pl_model processor***
Returns the processor model as a string.

Example:
```shell
    echo "This Raspberry Pi has a $(pl_model processor) processor."
```

#### ***pl_model revision***
Returns the PCB revision number as an integer.

Example:
```shell
    echo "This Raspberry Pi is revision number $(pl_model revision)."
```

#### ***pl_model type***
Returns the Raspberry Pi model type as a string.

Example:
```shell
    echo "This Raspberry Pi is a $(pl_model type)."
```

#### ***pl_model summary***
Returns a summary of the Raspeberry Pi as a string in format of "<manufacturer>,<memory>,<processor>,<revision>,<type>".

The string can then be read into an array and values extracted as follows:

```shell
    summary="$(pl_model summary)" # summary is a string delimted by commas.
    IFS=',' read -ra summary_array <<< "$summary" # split comma delimted string into an array.
    manufacturer="{summary_array[0]}"
    memory="{summary_array[1]}"
    processor="{summary_array[2]}"
    pcb_revision="{summary_array[3]}"
    type="{summary_array[4]}"
```

#### ***pl_model gt***
TODO: implement function.

#### ***pl_model lt***
TODO: implement function.

#### ***pl_model eq***
TODO: implement function.

#### ***pl_model has_wifi***
TODO: implement function.

#### ***pl_model has_lan***
TODO: implement function.

#### ***pl_model has_bt***
TODO: implement function.

#### ***pl_model has_csi***
TODO: implement function.

#### ***pl_model is32bit***
TODO: implement function.

#### ***pl_model is64bit***
TODO: implement function.

### Overclocking functions
**WARNING:** Here be dragons. Using the functions contained in this module may lead to hardware damage, a void warrenty (a permanent warranty bit is set within the revision code on the SOC under some circumstances), a system that won't boot, a system that is unstable / produces silent calculation errors, or poor performance due to thermal throttling. Please ensure you have adequate cooling, a good quality power supply, understand what you are doing and have refered to https://www.raspberrypi.org/documentation/configuration/config-txt/overclocking.md and other relevant sources of information. The authors and maintainers of pishlib accept no liabilty for any damage caused.

Once the changes have been applied using these functions a reboot is required to apply them. 

#### ***pl_overclock cpu_freq***
Sets the maximum cpu frequency, in MHz.

Example:
```shell
    pl_overclock cpu_freq 1400"
```

#### ***pl_overclock cpu_freq_min***
Sets the mminimum cpu frequency, in MHz.

Example:
```shell
    pl_overclock cpu_freq_min 700"
```

#### ***pl_overclock gpu_freq***
Sets the maximum gpu frequency, in MHz. This sets the core_freq, h264_freq, isp_freq, v3d_freq and hevc_freq together.

Example:
```shell
    pl_overclock gpu_freq 500"
```

#### ***pl_overclock gpu_freq_min***
Sets the minimum gpu frequency, in MHz, used for dynamic clocking. This sets core_freq, h264_freq, isp_freq, v3d_freq and hevc_freq together

Example:
```shell
    pl_overclock gpu_freq_min 300"
```

#### ***pl_overclock over_voltage***
Sets the CPU/GPU core voltage. The value should be in the range -16 to 8 which corresponds to the range of 0.8V to 1.4V in 0.025V steps. Values above 6 are only allowed when `force_turbo=1`: this sets the warranty bit.

Example:
```shell
    pl_overclock over_voltage 3
```

#### ***pl_overclock over_voltage_min***
Sets the minimum voltage value used for dynamic frequency clocking. The value should be in the range -16 to 8 which corresponds to the range of 0.8V to 1.4V in 0.025V steps. Values above 6 are only allowed when `force_turbo=1`: this sets the warranty bit.

Example:
```shell
    pl_overclock over_voltage_min 0
```

#### ***pl_overclock over_voltage_sdram***
Sets the SDRAM voltage for the controller (over_voltage_sdram_c), I/O (over_voltage_sdram_i), and phy (over_voltage_sdram_p). All of these can be set individually in the boot config file. The value should be in the range -16 to 8 which corresponds to the range of 0.8V to 1.4V in 0.025V steps.

Example:
```shell
    pl_overclock over_voltage_sdram 2
```

#### ***pl_overclock sdram_freq***
Set the frequency of the SDRAM in MHz. SDRAM overclocking on Pi 4B is not currently supported.

Example:
```shell
    pl_overclock sdram_freq 450
```

#### ***pl_overclock sdram_freq_min***
Set the minimum frequency of the SDRAM in MHz, used for dynamic clocking. SDRAM overclocking on Pi 4B is not currently supported.

Example:
```shell
    pl_overclock sdram_freq_min 350
```

#### ***pl_overclock temp_limit***
Sets the temperature (in degrees celcius) at which thermal throttling will occur. The maximum value is limited to 85. 

Example:
```shell
    pl_overclock temp_limit 75
```

#### ***pl_overclock temp_soft_limit***
Applies to the **3A+/3B+** only. Sets the temperature (in degrees celcius) at which thermal throttling will occur. At this temperature, the clock speed is reduced from 1400Mhz to 1200Mhz. Defaults to 60, can be raised to a maximum of 70, but this may cause instability.

Example:
```shell
    pl_overclock temp_soft_limit 65
```


## Still to be implemented:
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
