### Debug

---
#### set default audio device on ubuntu 18.04
[https://askubuntu.com/questions/1038490/how-do-you-set-a-default-audio-output-device-in-ubuntu-18-04/1038492](https://askubuntu.com/questions/1038490/how-do-you-set-a-default-audio-output-device-in-ubuntu-18-04/1038492)

``` bash
pactl list short sinks                                             # get list of devices
pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo  # set default device
# append `set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo` to /etc/pulse/default.pa

```

---

#### check if console supports 24bit - truecolor
`bash testcase-truecolors.sh`  

----

### Common bugs

#### Low cpu frequency after suspending laptop
###### (dell latitude e6430 / i5-3320m)

#### diagnosis
``` bash
watch -n 1 -d "cat /proc/cpuinfo | grep -i Mhz"
```
shows too low frequency (less than 1200 for my cpu)
``` bash
sudo modprobe msr
sudo rdmsr -a 0x19a
```
returns something other than `0`

##### temporary solution:
you have to set register `0x19a` to `0` with `wrmsr -a 0x19a 0x0`  

##### permanent solution:

``` bash
sudo cp 10_fix_low_cpu_frequency /lib/systemd/system-sleep/
sudo chmod +x /lib/systemd/system-sleep/10_fix_low_cpu_frequency
sudo echo 'msr' >> /etc/modules
```

#### Fix mouse wheel scrolling speed systemwide
``` bash
sudo apt-get install imwheel
```

add following lines to `~/.imwheelrc'` or clone from this repo
``` bash
".*"
None,      Up,   Button4, 3
None,      Down, Button5, 3
Control_L, Up,   Control_L|Button4
Control_L, Down, Control_L|Button5
Shift_L,   Up,   Shift_L|Button4
Shift_L,   Down, Shift_L|Button5
```
execute on autostart
``` bash
imwheel --kill --buttons "4 5"
```

