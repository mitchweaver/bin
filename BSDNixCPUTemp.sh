#!/bin/bash

if [ $(uname) == "Linux" ] ; then
    # this is a mess and needs converted to POSIX -- bash only atm
    a=`sed 's/.\{3\}$//' <<< cat /sys/class/thermal/thermal_zone0/temp`
    b=`sed 's/.\{3\}$//' <<< cat /sys/class/thermal/thermal_zone1/temp`

    avg=$(( (a + b) / 2))

    echo 🌡️ $avg°C
else # BSD

    # For some reason sysctl is only giving me 'cpu0'
    # on my machine. (ThinkPad T500) Is this normal?
    # If not, please find a fix and pull request.
    temp=$(sysctl -n hw.sensors.cpu0.temp0 | grep -Eo '^[^.]+')

    echo 🌡️ $temp°C
fi
