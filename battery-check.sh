#!/bin/sh

perc=0

if [ "$(uname)" = "Linux" ] ; then
    if [ -f /sys/class/power_supply/AC/online ] ; then
        path=/sys/class/power_supply/AC/online
    elif [ -f /sys/class/power_supply/AC0/online ] ; then
        path=/sys/class/power_supply/AC0/online
    fi

    if [ $(cat $path) -eq 1 ] ; then
        echo "\\uf492" # charging
        exit
    fi

    perc=$(cat /sys/class/power_supply/BAT0/capacity)

else # BSD
    if [ $(apm -a) -eq 1 ] ; then
        echo "\\uf492" # charging
        exit
    fi

    perc=$(apm -l)

    if [ $perc -eq 99 ] ; then
        perc=100
    fi
fi

if [ $perc -gt 76 ] ; then 
    echo "\\uf240" # 76-100
elif [ $perc -gt 51 ] ; then 
    echo "\\uf241" # 51-76
elif [ $perc -gt 26 ] ; then
    echo "\\uf242" # 26-51
elif [ $perc -gt 10 ] ; then
    echo "\\uf243" # 6-25
elif [ $perc -gt 5 ] ; then
    echo "\\uf244" # 6-25
else 
    echo "\\uf244☠️ " # 0-5
fi 
