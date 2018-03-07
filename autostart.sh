#!/bin/dash

xbacklight -set 90 &
xmodmap ${HOME}/.Xmodmap &
xrdb load ${HOME}/.Xresources &
xset +fp ${HOME}/.fonts
xset m 0 0 &

tasks="xbanish miniclip bar bash sleep lemonbar compton"
case "$(uname)" in
    Linux)
        killall $tasks -- > /dev/null 2>&1
        ;;
    OpenBSD)
        pkill -9 $tasks -- > /dev/null 2>&1
esac

if [ "$(pgrep -f dwm)" ] ; then
    [ "$(cat /tmp/dwm_info/gappx)" -gt 0 ] &&
        compton --config ${HOME}/.config/compton.conf -b -- > /dev/null 2>&1 &
else
    compton --config ${HOME}/.config/compton.conf -b -- > /dev/null 2>&1 &
fi 

# based on what is set as my wallpaper,
# this could either be a still picture
# or a cinemagraph. Find out what it is,
# and launch with the appropriate program.
feh="feh --bg-fill --no-fehbg ${HOME}/.wall --"
mpvbg="mpvbg ${HOME}/.wall --"
case "$(uname)" in
    Linux)
        case "$(file -b -i -L ${HOME}/.wall)" in
            "image/png; charset=binary") $feh & ;;
            "image/jpg; charset=binary") $feh & ;;
            "image/jpeg; charset=binary") $feh & ;;

            "image/gif; charset=binary") $feh ; $mpvbg & ;;
            "video/webm; charset=binary") $feh ; $mpvbg & ;;
            "video/mp4; charset=binary") $feh ; $mpvbg & ;;
            "video/flv; charset=binary") $feh ; $mpvbg & ;;
            "video/mkv; charset=binary") $feh ; $mpvbg & ;;
        esac
        ;;
    OpenBSD)
        case "$(file -b -i -L ${HOME}/.wall)" in
            "image/png") $feh & ;;
            "image/jpg") $feh & ;;
            "image/jpeg") $feh & ;;

            "image/gif") $feh ; $mpvbg & ;;
            "video/webm") $feh ; $mpvbg & ;;
            "video/mp4") $feh ; $mpvbg & ;;
            "video/flv") $feh ; $mpvbg & ;;
            "video/mkv") $feh ; $mpvbg & ;;
        esac
esac

[ "$(pgrep -f dwm)" ] &&
    bar > /dev/null 2>&1 &

xbanish &

[ -z "$(pgrep -f miniclip)" ] &&
    miniclip --daemon &

# xautolock -time 10 -secure -locker /usr/local/bin/slock
