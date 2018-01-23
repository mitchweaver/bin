#!/bin/bash

# todo: find a way to get this on linux
# if [ surface pro 3 ] ; then


if [ -z $(< /tmp/touchpad) ] || [ $(< /tmp/touchpad) -eq 1 ]; then

    xinput disable "Microsoft Surface Type Cover Touchpad"

    [ ! -z $(command -v notify-send) ] && 
        notify-send "Disabling the touchpad..."

    echo 0 > /tmp/touchpad

elif [ $(< /tmp/touchpad) -eq 0 ] ; then

    xinput enable "Microsoft Surface Type Cover Touchpad"

    [ ! -z $(command -v notify-send) ] && 
        notify-send "Enabling the touchpad..."

    echo 1 > /tmp/touchpad

fi


# fi
