#!/bin/sh

plugged=0
perc=0

if [ $(uname) == "Linux" ] ; then
    perc=$(cat /sys/class/power_supply/BAT0/capacity)
    if [ $(cat /sys/class/power_supply/AC/online) -eq 1 ] ; then
        plugged=1
    fi
else # BSD
    perc=$(apm -l)

    if [ $perc -eq 99 ] ; then
        perc=100
    fi

    if [ $(apm -a) -eq 1 ] ; then
        plugged=1
    fi
fi

if [ $plugged -eq 1 ] ; then
    echo "\\uf492" # charging
elif [ $perc -gt 76 ] ; then 
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
