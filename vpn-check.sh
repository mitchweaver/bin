#!/bin/sh

# http://github.com/MitchWeaver/bin

RUNNING=0

if [ $(uname) == "Linux" ] ; then

    if [ $(pidof openvpn) ] ; then
       RUNNING=1
    fi

else # BSD
    if [ $(pgrep openvpn) ] ; then
        RUNNING=1
    fi

fi


if [ $RUNNING -eq 1 ] ; then
    echo "VPN: ✔️"
else
    echo "VPN: ✖️"
fi
