#!/bin/sh

IP=$(ifconfig "$1" | grep 'status' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')

if [ $IP ] ; then

    result="📶 ✔️"
else
    result="📶 ✖️"

fi

if [ $(uname) == "Linux" ] ; then
    SSID=$(iw dev $1 link | grep SSID: | awk -F '[ -]*' '$0=$NF')
else # BSD
    SSID=$(ifconfig iwn0 | grep nwid | sed -e 's/.*nwid*.\(.*\)chan.*/\1/')
fi

if [ $SSID ] ; then

    result="${result} - $SSID"

fi

echo $result
