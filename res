#!/bin/dash
#
# http://github.com/mitchweaver/bin
#
# xrandr wrapper for common resolutions
#

case "$1" in
    1080) xrandr -s 1920x1080
        ;;
    720) xrandr -s 1280x720
        ;;
    *) exit
esac

pkill bar ; bar
