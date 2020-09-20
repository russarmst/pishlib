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

if [[ $(pl_mem system installed) -eq 4096 ]]; then
    echo 'Your Pi has 4GiB of system RAM.'
fi
```


## Table of Contents

- [pishlib](#pishlib)
  - [Introduction](#introduction)
  - [Table of Contents](#table-of-contents)
  - [Installation and Usage](#installation-and-usage)
  - [Contributing](#contributing)
  - [Functions](#functions)
    - [CPU functions](#cpu-functions)
      - [***pl_cpu frequency available***](#pl_cpu-frequency-available)
      - [***pl_cpu frequency min***](#pl_cpu-frequency-min)
      - [***pl_cpu frequency max***](#pl_cpu-frequency-max)
      - [***pl_cpu frequency current***](#pl_cpu-frequency-current)
      - [***pl_cpu governor current***](#pl_cpu-governor-current)
      - [***pl_cpu governor available***](#pl_cpu-governor-available)
      - [***pl_cpu governor_ondemand up_threshold***](#pl_cpu-governor_ondemand-up_threshold)
      - [***pl_cpu governor_ondemand down_threshold***](#pl_cpu-governor_ondemand-down_threshold)
      - [***pl_cpu temp current***](#pl_cpu-temp-current)
    - [Memory Functions](#memory-functions)
      - [***pl_mem system installed***](#pl_mem-system-installed)
      - [***pl_mem system total***](#pl_mem-system-total)
      - [***pl_mem system free***](#pl_mem-system-free)
      - [***pl_mem system used***](#pl_mem-system-used)
      - [***pl_mem system limit***](#pl_mem-system-limit)
      - [***pl_mem system ramdisk***](#pl_mem-system-ramdisk)
      - [***pl_mem system zswap***](#pl_mem-system-zswap)
      - [***pl_mem system swap***](#pl_mem-system-swap)
    - [GPU Functions](#gpu-functions)
      - [***pl_gpu memory total***](#pl_gpu-memory-total)
      - [***pl_gpu memory free***](#pl_gpu-memory-free)
      - [***pl_gpu memory used***](#pl_gpu-memory-used)
      - [***pl_gpu model_memory (256|512|1024)=xxx***](#pl_gpu-model_memory-2565121024xxx)
      - [***pl_gpu temperature current***](#pl_gpu-temperature-current)
      - [***pl_gpu frequency current***](#pl_gpu-frequency-current)
    - [Model functions](#model-functions)
      - [***pl_model attribute all***](#pl_model-attribute-all)
      - [***pl_model attribute generation***](#pl_model-attribute-generation)
      - [***pl_model attribute has_bt***](#pl_model-attribute-has_bt)
      - [***pl_model attribute has_csi***](#pl_model-attribute-has_csi)
      - [***pl_model attribute has_lan***](#pl_model-attribute-has_lan)
      - [***pl_model attribute has_wifi***](#pl_model-attribute-has_wifi)
      - [***pl_model attribute is_32bit***](#pl_model-attribute-is_32bit)
      - [***pl_model attribute is_64bit***](#pl_model-attribute-is_64bit)
      - [***pl_model attribute manufacturer***](#pl_model-attribute-manufacturer)
      - [***pl_model attribute memory***](#pl_model-attribute-memory)
      - [***pl_model attribute processor***](#pl_model-attribute-processor)
      - [***pl_model attribute revision***](#pl_model-attribute-revision)
      - [***pl_model attribute revision_code***](#pl_model-attribute-revision_code)
      - [***pl_model attribute type***](#pl_model-attribute-type)
      - [***pl_model print summary***](#pl_model-print-summary)
    - [Overclocking functions](#overclocking-functions)
      - [***pl_overclock frequency cpu_min***](#pl_overclock-frequency-cpu_min)
      - [***pl_overclock frequency cpu_max***](#pl_overclock-frequency-cpu_max)
      - [***pl_overclock frequency gpu_min***](#pl_overclock-frequency-gpu_min)
      - [***pl_overclock frequency gpu_max***](#pl_overclock-frequency-gpu_max)
      - [***pl_overclock frequnecy ram_min***](#pl_overclock-frequnecy-ram_min)
      - [***pl_overclock frequnecy ram_max***](#pl_overclock-frequnecy-ram_max)
      - [***pl_overclock voltage soc_min***](#pl_overclock-voltage-soc_min)
      - [***pl_overclock voltage soc_max***](#pl_overclock-voltage-soc_max)
      - [***pl_overclock voltage ram***](#pl_overclock-voltage-ram)
      - [***pl_overclock temp_limit hard***](#pl_overclock-temp_limit-hard)
      - [***pl_overclock temp_limit soft***](#pl_overclock-temp_limit-soft)
  - [Still to be implemented:](#still-to-be-implemented)
    - [GPIO functions](#gpio-functions)
    - [CSI Functions](#csi-functions)
    - [Wifi Functions](#wifi-functions)
    - [BT Functions](#bt-functions)
    - [Camera Functions](#camera-functions)
    - [Screen Functions](#screen-functions)
    - [Audio Functions](#audio-functions)
  - [Credits](#credits)


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
* Have you spotted a **typo or a correction** that is needed in the Documentation? File a Pull Request with your correction or a Github issue with details of what need to be changed. 
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

The functions are in the format of:

    <pishlib_modulename> <functionname> <action> <parameter>

Some functions parameters are optional others are mandatory. Parameters are in the format of either:
* paramter_value
* parameter_name=paramter_value

### CPU functions

#### ***pl_cpu frequency available***
Returns a list of the available CPU frequencies (in Hz) that the CPU frequency governor can switch between.

Example:
```shell
    echo "This Raspberry Pi can run at one of the following frequencies (in Hz) $(pl_cpu frequency available)."
```

#### ***pl_cpu frequency min***
Returns the minimum frequency the cpu will run at when dynamic clocking is active.

Example:
```shell
    echo "When idle this Raspberry Pi runs at $(pl_cpu frequency min)Mhz."
```

Functions to set CPU frequnecies are available in the `pl_overclock` module.

#### ***pl_cpu frequency max***
Returns the maximum frequency the cpu will run at when dynamic clocking is active.

Example:
```shell
    echo "When busy this Raspberry Pi runs at $(pl_cpu frequency max)Mhz."
```

Functions to set CPU frequnecies are available in the `pl_overclock` module.

#### ***pl_cpu frequency current***
Returns the current frequency the cpu is running at.

Example:
```shell
    echo "When busy this Raspberry Pi runs at $(pl_cpu frequency current)Mhz."
```


#### ***pl_cpu governor current***
Returns the active CPU frequency governor as a string.

Example:
```shell
    echo "The active CPU frequency governor is $(pl_cpu governor current)."
```

When an optional govenor name is passed the CPU freq governor is set accordingly. The parameter should be one of those listed by `$(pl_cpu governor available)`. The list will usually include: `conservative`, `ondemand`, `performance`, `powersave`, `schedutil`, or `userspace`.

Example:
```shell
    gov=performance
    echo "Setting the CPU frequency governor to $gov."
    pl_cpu governor current=$gov
```

#### ***pl_cpu governor available***
Returns a list of available CPU frequency governors.

Example:
```shell
    echo "The active CPU frequency governor is $(pl_cpu governor available)."
```

#### ***pl_cpu governor_ondemand up_threshold***
Returns the curent up_threshold (% cpu utilisation) for the on demand govenor. When he average % CPU utilisation exceeds the up_threshold (in %) the CPU frequnecy governor switches to value of `pl_cpu frequency max`.

Example:
```shell
    echo "The CPU frequency governor up theshold is $(pl-cpu governor_ondemend get up_threshold)%."
```

When an optional integer parameter is passed the up_threshold is set accordingly.

Example:
```shell
    cpu_utilisation_percentage=80
    echo "The CPU frequency governor up theshold is being set to $cpu_utilisation_percentage%."
    pl_cpu governor_ondemand up_threshold=$cpu_utilisation_percentage
```

TODO: add ability to pass default as a parameter

#### ***pl_cpu governor_ondemand down_threshold***
Returns the curent down_threshold (% cpu utilisation) for the on demand govenor. When the average % CPU utilisation is below the down_threshold the CPU frequency governor switches to the to value of `pl_cpu frequency min`. When the average % CPU utilisation is between the down_threshold and up_threshold the CPU frequnecy governor switches to a frequency midway between the value `pl_cpu frequency min` and `pl_cpu frequency max`. The midway frequency is listed by `pl_cpu frequency available`.

Example:
```shell
    echo "The CPU frequency governor down theshold is $(pl_cpu governor_ondemand down_threshold)%."
```

When an integer (in %) is passed the CPU frequency governor down threshold is set accordingly.

Example:
```shell
    cpu_utilisation_percentage=40
    echo "The CPU frequency governor down theshold is being set to $cpu_utilisation_percentage%."
    pl_cpu governor_ondemand down_threshold=$cpu_utilisation_percentage
```

TODO: add ability to pass default as a parameter

#### ***pl_cpu temp current***
Returns the current CPU core temperature in degrees C.

Example:
```shell
    echo "The ARM core is running at $(pl_cpu temp current) degreee C.)
```

### Memory Functions

All pishlib memory functions report or compare memory in Mebibytes (MiB) and therefore where integer memory parameters are required they should also be in Mebibytes (MiB).

#### ***pl_mem system installed***
Returns the amount of RAM installed on the ARM SOC as an intger in Mebibytes (MiB).

Example:
```shell
echo "This Raspberry Pi has $(pl_mem system installed)MiB of RAM installed."
```

#### ***pl_mem system total***
Returns the amount of system memory available to the ARM CPU as an intger in Mebibytes (MiB). 

Example:
```shell
echo "This Raspberry Pi has $(pl_mem system installed)MiB of syetem memory."
```

#### ***pl_mem system free***
Returns the amount of free system memory available to the ARM CPU as an intger in Mebibytes (MiB). 

Example:
```shell
echo "This Raspberry Pi has $(pl_mem system free)MiB of free memory."
```

#### ***pl_mem system used***
Returns the amount of system memory in use by the ARM CPU as an intger in Mebibytes (MiB). 

Example:
```shell
echo "This Raspberry Pi is using $(pl_mem system used)MiB of memory."
```

#### ***pl_mem system limit***
This setting can force a Raspberry Pi to limit its memory capacity to less than that reported by `$(pl_mem system installed)`. Returns the current memeory limit.

Example:
```shell
echo "This Raspberry Pi has memory limited to $(pl_mem system limit)MiB out of $(pl_mem system total)MiB available."
```

When an integer is passed, in Mebibytes (MiB), the amount of system memory is limited accordingly. The value of the parameter can be a minimum of 128MiB, and a maximum of the total memory installed on the board.

TODO: implement total_mem https://www.raspberrypi.org/documentation/configuration/config-txt/memory.md


#### ***pl_mem system ramdisk***
TODO: setup up a ramdisk for temporary files to preserve SD card life by preventing SD writes to ```/tmp```, ```/var/lock```, ```/var/log```, ```/var/run```, ```/var/spool/mqueue``` by deafult.

**Note:** The default sizes have been adapted from the [Debian Mailing List](https://lists.debian.org/debian-devel/2011/04/msg00615.html)

#### ***pl_mem system zswap***
TODO: spec up and implement.

#### ***pl_mem system swap***
TODO: spec up and implement.


### GPU Functions

TODO: rename source file from pl_gpu_mem to pl_gpu

#### ***pl_gpu memory total***
Returns the amount of memory (in Mebibytes) which is reserved for the exclusive use of the GPU, the remaining memory is allocated to the ARM CPU.

Example:
```shell
    echo "This Raspberry Pi has $(pl_gpu memory total)MiB of GPU memory"
```

If a parameter is passed either as an integer (in Mebibytes), "default" or "max" the amount of GPU memory is set accordingly.

If "default" is passed the GPU memory is set accroding to the following table:
| Pi Model Memory  | gpu_mem default value |
|------------------|-----------------------|
| =< 1Gb           | 64                    |
| > 1Gb            | 76                    |

If "max" is passed the GPU memory is set accroding to the following table:
| Total RAM      | gpu_mem recommended maximum |
|----------------|-----------------------------|
| 256MB          | 128                         |
| 512MB          | 384                         |
| 1GB or greater | 512                         |

The new configuration won't take affect until after the next reboot.

Example:
```shell
    gpu_mem=76
    echo "Setting the amount of GPU memory to $gpu_mem."
    pl_gpu memory total=$gpu_mem
```

**Note:** if your distribution doesn't include the `vcgencmd` program (included with Raspberry Pi OS) or you haven't installed it, the amount of GPU Memory reported will be that configured in `/boot/config.txt`. If `gpu_mem` in `/boot/config.txt` has been changed since the last reboot, the amount of GPU Memory reported will be inaccurate until after the next reboot. With `vcgencmd` in the path the amount of GPU Memory reported will always be accurate. If `gpu_mem` is not specified in `/boot/config.txt` then the default gpu_mem allocation is reported as 64Mb if RAM<1Gb or 76Mb if RAM>1Gb.

**Note:** On the Raspberry Pi 4 the 3D component of the GPU has its own memory management unit (MMU), and does not use memory from the gpu_mem allocation. Instead memory is allocated dynamically within Linux. This may allow a smaller value to be specified for gpu_mem on the Pi 4, compared to previous models.

#### ***pl_gpu memory free***
Returns the amount of memory (in Mebibytes) which is free for the exclusive use of the GPU.

Example:
```shell
    echo "This Raspberry Pi has $(pl_gpu memory free)MiB of free GPU memory."
```

#### ***pl_gpu memory used***
Returns the amount of memory (in Mebibytes) which is being used by the GPU.

Example:
```shell
    echo "This Raspberry Pi is using $(pl_gpu memory used)MiB of GPU memory."
```


#### ***pl_gpu model_memory (256|512|1024)=xxx***
Sets the GPU memory (in megabytes) to xxx for Raspberry Pis with 256Mb|512Mb|1024Mb of memory. (It is ignored if memory size is not 256Mb|512Mb|1024Mb). This overrides the gpu_mem setting in /boot/config.txx.

Setting this will allow swapping the boot drive between Pis with different amounts of RAM without having to edit /boot/config.txt each time.

Example:
```shell
    pl_gpu model_mem 256=64
    pl_gpu model_mem 512=76
    pl_gpu model_mem 1024=98
```
TODO: to implement

#### ***pl_gpu temperature current***
Returns the current temperature of the GPU core in degrees centigrade.

Example:
```shell
    echo "The temperature of the GPU on this Raspberry Pi is $(pl_gpu temperature current) degrees Centigrade."
```

TODO: to implement

#### ***pl_gpu frequency current***
Returns the current frequency of the GPU core in Hz.

Example:
```shell
     echo "The frequency of the GPU on this Raspberry Pi is $(pl_gpu frequency current) Hz."
```

**Note:** Functions to set the frequency of the GPU core are in the pl_overclock module.

TODO: to implement

### Model functions

#### ***pl_model attribute all***
Returns a summary of the Raspeberry Pi as a string in format of `<generation>,<has_wifi>,<has_lan>,<has_bt>,<has_csi>,<is_32bit>,<is_64bit>,<manufacturer>,<memory>,<processor>,<revision>,<revision_code>,<type>`

The string can then be read into an array and values extracted as follows:

```shell
    summary="$(pl_model atribute all)" # summary is a string delimted by commas.
    IFS=',' read -ra summary_array <<< "$summary" # split comma delimted string into an array.
    generation="{summary_array[0]}"
    has_wifi="{summary_array[1]}"
    has_lan="{summary_array[2]}"
    ...
    revision="{summary_array[10]}"
    revision_code="{summary_array[11]}"
    type="{summary_array[12]}
```
TODO: check this unpacking works

#### ***pl_model attribute generation***
Returns the generation number as an integer. Currently the valid reposnses are `1`, `2`, `3`, or `4`.  

Example:
```shell
    echo "This Raspberry Pi is of generation $(pl_model generation)."
```

#### ***pl_model attribute has_bt***
Returns a boolean dependant on if the Raspberry Pi has Bluetooth.

Example:
```shell
    if [[ $(pl_model attribute has_bt) ]]; then
        echo "This Raspberry Pi has bluetooth."
    else
        echo "This Raspberry Pi doesn't have bluetooth."
    fi
```

TODO: implement function.

#### ***pl_model attribute has_csi***
Returns a boolean dependant on if the Raspberry Pi has a Camera Serial Interface.

Example:
```shell
    if [[ $(pl_model attribute has_csi) ]]; then
        echo "This Raspberry Pi has a Camera Serial Interface."
    else
        echo "This Raspberry Pi doesn't have a Camera Serial Interface."
    fi
```

TODO: implement function.

#### ***pl_model attribute has_lan***
Returns a boolean dependant on if the Raspberry Pi has an Ethernet port.

Example:
```shell
    if [[ $(pl_model attribute has_lan) ]]; then
        echo "This Raspberry Pi has an Ethernet port."
    else
        echo "This Raspberry Pi doesn't have an Ethernet port."
    fi
```

TODO: implement function.

#### ***pl_model attribute has_wifi***
Returns a boolean dependant on if the Raspberry Pi has a Wifi adapter.

Example:
```shell
    if [[ $(pl_model attribute has_wifi) ]]; then
        echo "This Raspberry Pi has a Wifi adapter."
    else
        echo "This Raspberry Pi doesn't have a Wifi adapter."
    fi
```

TODO: implement function.

#### ***pl_model attribute is_32bit***
Returns a boolean dependant on if the Raspberry Pi is running a 32bit OS.

Example:
```shell
    if [[ $(pl_model attribute is_32bit) ]]; then
        echo "This Raspberry Pi is running a 32bit OS."
    else
        echo "This Raspberry Pi isn't running a 32bit OS."
    fi
```

TODO: implement function.

#### ***pl_model attribute is_64bit***
Returns a boolean dependant on if the Raspberry Pi is running a 64bit OS.

Example:
```shell
    if [[ $(pl_model attribute is_64bit) ]]; then
        echo "This Raspberry Pi is running a 64bit OS."
    else
        echo "This Raspberry Pi isn't running a 64bit OS."
    fi
```

TODO: implement function.

#### ***pl_model attribute manufacturer***
Returns the manufacturer of the Raspberry Pi board as a string.

Example:
```shell
    echo "This Raspberry Pi was manufactured by $(pl_model attribute manufacturer)"
```

#### ***pl_model attribute memory***
Returns the amount of memory installed as an integer in Mb.

Example:
```shell
    echo "This Raspberry Pi has $(pl_model attribute memory)Mb installed."
```

#### ***pl_model attribute processor***
Returns the processor model as a string.

Example:
```shell
    echo "This Raspberry Pi has a $(pl_model attribute processor) processor."
```

#### ***pl_model attribute revision***
Returns the PCB revision number as an integer. 

Example:
```shell
    echo "This Raspberry Pi is revision number $(pl_model attribute revision)."
```

#### ***pl_model attribute revision_code***
Returns the revision code which is encoded on the SOC number as an integer. 

Example:
```shell
    echo "This Raspberry Pi has a revision code $(pl_model attribute revision_code)."
```

#### ***pl_model attribute type***
Returns the Raspberry Pi type type as a string. Valid respsonses could include `Compute`, `B`, `Zero` and others.

Example:
```shell
    echo "This Raspberry Pi is a type $(pl_model attribute type)."
```

#### ***pl_model print summary***
Pretty prints a summary of the Raspberry Pi model.

Example:
```shell
    pl_model print summary
```

### Overclocking functions

**WARNING:** Here be dragons. Using the functions contained in this module may lead to hardware damage, a void warrenty (a permanent warranty bit is set within the revision code on the SOC under some circumstances), a system that won't boot, a system that is unstable / produces silent calculation errors, or poor performance due to thermal throttling. Please ensure you have adequate cooling, a good quality power supply, understand what you are doing and have refered to https://www.raspberrypi.org/documentation/configuration/config-txt/overclocking.md and other relevant sources of information. The authors and maintainers of pishlib accept no liabilty for any damage caused.

Once the changes have been applied using these functions a reboot is required to apply them. 

#### ***pl_overclock frequency cpu_min***
Sets the minimum cpu frequency, in MHz.

Example:
```shell
    pl_overclock frequency cpu_min=700"
```

#### ***pl_overclock frequency cpu_max***
Sets the maximum cpu frequency, in MHz.

Example:
```shell
    pl_overclock frequency cpu_max=1400"
```

#### ***pl_overclock frequency gpu_min***
Sets the minimum gpu frequency, in MHz. This sets the core_freq, h264_freq, isp_freq, v3d_freq and hevc_freq together.

Example:
```shell
    pl_overclock frequency gpu_min=300"
```

#### ***pl_overclock frequency gpu_max***
Sets the maximum gpu frequency, in MHz, used for dynamic clocking. This sets core_freq, h264_freq, isp_freq, v3d_freq and hevc_freq together

Example:
```shell
    pl_overclock frequency gpu_max=500"
```

#### ***pl_overclock frequnecy ram_min***
Set the minimum frequency of the SDRAM in MHz, used for dynamic clocking. SDRAM overclocking on Pi 4B is not currently supported.

Example:
```shell
    pl_overclock frequnecy ram_min=350
```



#### ***pl_overclock frequnecy ram_max***
Set the frequency of the SDRAM in MHz. SDRAM overclocking on Pi 4B is not currently supported.

Example:
```shell
    pl_overclock frequnecy ram_max=450
```

#### ***pl_overclock voltage soc_min***
Sets the minimum voltage value used for dynamic frequency clocking. The value should be in the range -16 to 8 which corresponds to the range of 0.8V to 1.4V in 0.025V steps. Values above 6 are only allowed when `force_turbo=1`: this sets the warranty bit.

Example:
```shell
    pl_overclock voltage soc_min=0
```

#### ***pl_overclock voltage soc_max***
Sets the CPU/GPU core voltage. The value should be in the range -16 to 8 which corresponds to the range of 0.8V to 1.4V in 0.025V steps. Values above 6 are only allowed when `force_turbo=1`: this sets the warranty bit.

Example:
```shell
    pl_overclock voltage soc_max=3
```


#### ***pl_overclock voltage ram***
Sets the SDRAM voltage for the controller (over_voltage_sdram_c), I/O (over_voltage_sdram_i), and phy (over_voltage_sdram_p). All of these can be set individually in the boot config file. The value should be in the range -16 to 8 which corresponds to the range of 0.8V to 1.4V in 0.025V steps.

Example:
```shell
    pl_overclock voltage ram=2
```


#### ***pl_overclock temp_limit hard***
Sets the temperature (in degrees celcius) at which thermal throttling will occur. The maximum value is limited to 85. 

Example:
```shell
    pl_overclock temp_limit hard=75
```

#### ***pl_overclock temp_limit soft***
Applies to the **3A+/3B+** only. Sets the temperature (in degrees celcius) at which thermal throttling will occur. At this temperature, the clock speed is reduced from 1400Mhz to 1200Mhz. Defaults to 60, can be raised to a maximum of 70, but this may cause instability.

Example:
```shell
    pl_overclock temp_limit soft=**65**
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
