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

    echo "🔌 $perc%"
elif [ $perc -gt 20 ] ; then
    echo "⚡ $perc%"
elif [ $perc -gt 12 ] ; then
    echo "⚡ $perc% ❗"
else 
    echo "⚡ $perc% ☠️ ❗"

fi 
