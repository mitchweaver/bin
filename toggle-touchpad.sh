#!/usr/bin/env bash

# todo: find a way to get this on linux
# if [ surface pro 3 ] ; then
# touchpad="Microsoft Surface Type Cover Touchpad"
# fi

case "$(uname)" in

    Linux)
        touchpad="SynPS/2 Synaptics TouchPad"

        notify='notify-send -t 1000 -u low'

        if [ -z $(< /tmp/touchpad) ] || [ $(< /tmp/touchpad) -eq 1 ]; then

            xinput disable "$touchpad"

            [ ! -z "$(command -v notify-send)" ] && 
                $notify "Disabling the touchpad..."

            echo 0 > /tmp/touchpad

        elif [ $(< /tmp/touchpad) -eq 0 ] ; then

            xinput enable "$touchpad"

            [ ! -z "$(command -v notify-send)" ] && 
                $notify "Enabling the touchpad..."

            echo 1 > /tmp/touchpad

        fi
        ;;

    OpenBSD)

        notify='notify-send -t 1000 -u low'

        if [ -z $(< /tmp/touchpad) ] || [ $(< /tmp/touchpad) -eq 1 ]; then

            synclient TouchpadOff=1

            [ ! -z "$(command -v notify-send)" ] && 
                $notify "Disabling the touchpad..."

            echo 0 > /tmp/touchpad

        elif [ $(< /tmp/touchpad) -eq 0 ] ; then

            synclient TouchpadOff=0

            [ ! -z "$(command -v notify-send)" ] && 
                $notify "Enabling the touchpad..."

            echo 1 > /tmp/touchpad

        fi

esac
