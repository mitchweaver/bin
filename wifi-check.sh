#!/bin/sh
#
# http://github.com/MitchWeaver/bin
#

# IP=$(ifconfig "$1" | grep 'status' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')

# if [ $(uname) == "Linux" ] ; then
#     SSID=$(iw dev $1 link | grep SSID: | awk -F '[ -]*' '$0=$NF')
# else # BSD
#     SSID=$(ifconfig iwn0 | grep nwid | sed -e 's/.*nwid*.\(.*\)chan.*/\1/')
# fi


ping -c 1 -D -L -n -q -s 1 -w 10 8.8.8.8 > /dev/null
[ $? -eq 0 ] &&
    echo "\\uf1eb" ||
    echo "\\uf467"
