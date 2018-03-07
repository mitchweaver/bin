#!/bin/dash

tasks="xbanish miniclip bar bash sleep lemonbar compton"
pkill -9 $tasks -- > /dev/null 2>&1

[ "$(cat /tmp/dwm_info/gappx)" -gt 0 ] &&
    compton --config ${HOME}/etc/config/compton.conf -b -- > /dev/null 2>&1 &

# based on what is set as my wallpaper,
# this could either be a still picture
# or a cinemagraph. Find out what it is,
# and launch with the appropriate program.
feh="feh --bg-fill --no-fehbg ${HOME}/var/tmp/wall --"
mpvbg="mpvbg ${HOME}/var/tmp/wall --"
case "$(file -b -i -L ${HOME}/var/tmp/wall)" in
    "image/png")  $feh & ;;
    "image/jpg")  $feh & ;;
    "image/jpeg") $feh & ;;

    "image/gif")  $feh ; $mpvbg & ;;
    "video/webm") $feh ; $mpvbg & ;;
    "video/mp4")  $feh ; $mpvbg & ;;
    "video/flv")  $feh ; $mpvbg & ;;
    "video/mkv")  $feh ; $mpvbg & ;;
esac

[ "$(pgrep -f dwm)" ] &&
    bar > /dev/null 2>&1 &

miniclip --daemon &

xbanish &

# xautolock -time 10 -secure -locker /usr/local/bin/slock
