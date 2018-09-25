#!/bin/dash
#
# http://github.com/mitchweaver/bin
#
# xrandr wrapper for common resolutions
#

# i only use these two resolutions, 
# so this will just be a toggle-script
case `xrandr --nograb --current | awk '/\*/ {print $1}'` in
    *1080) xrandr -s 1280x720 ;;
    *720)  xrandr -s 1920x1080 ;;
esac

# reset bar to conform to new resolution
pkill bar ; bar
