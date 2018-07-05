#!/bin/dash
#
# http://github.com/mitchweaver
#
# xrandr resolution wrapper
#

case "$1" in
    13*) xrandr -s 1366x768 ;;
    12*) xrandr -s 1280x720 ;;
    10*) xrandr -s 1024x768 ;;
    9*) xrandr -s 960x540 ;;
    8*) xrandr -s 800x600 ;;
    *) xrandr -s 1280x800 ;;
esac

sleep 2

pkill -9 bar
pkill -9 lemonbar
dash ~/bin/bar
