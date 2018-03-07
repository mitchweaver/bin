#!/usr/bin/env dash
#
# http://github.com/MitchWeaver/bin
#
# Autorice using pywal and other tools
#
####################################################

case "$(uname)" in
    OpenBSD)
        alias sudo=doas
esac

while [ $# -gt 0 ] ; do
    case "$1" in
        --light|-l)
            LIGHT=true
            ;;
        --no-kill|-n)
            nokill=true
            ;;
        --help|-h)
            printf "%s\n%s\n%s\n\n%s\n%s\n%s\n" \
                "Usage: " \
                "------------------------------------" \
                "$ sh pywal.sh \"\$wallpaper_path\"" \
                "Options:" \
                "------------------------------------" \
                "--no-kill    -    do not kill progs"
            exit 0
            ;;
        *)
            path="$1"
    esac
    shift
done

if [ -z "$path" ] ; then
    printf "%s\n%s\n" \
        "No file path provided." \
        "See --help for more information."
    exit 1
fi

wall_path="${HOME}/var/tmp/wall"

# copy wallpaper for it to be permanent
cp "$path" "$wall_path" > /dev/null

if [ ! -f "$wall_path" ] ; then
    echo "Unable to copy to ~/.wall"
    exit 1
fi

# based on what is set as my wallpaper,
# this could either be a still picture
# or a cinemagraph. Find out what it is,
# and launch with the appropriate program.
feh="feh --bg-fill --no-fehbg "$wall_path""
mpvbg="mpvbg "$wall_path""

case "$(uname)" in
    Linux)
        case "$(file -b -i -L "$wall_path")" in
            "image/png; charset=binary") $feh & ;;
            "image/jpg; charset=binary") $feh & ;;
            "image/jpeg; charset=binary") $feh & ;;

            "image/gif; charset=binary") $feh & $mpvbg & ;;
            "video/webm; charset=binary") $feh & $mpvbg & ;;
            "video/mp4; charset=binary") $feh & $mpvbg & ;;
            "video/flv; charset=binary") $feh & $mpvbg & ;;
            "video/mkv; charset=binary") $feh & $mpvbg & ;;
        esac
        ;;
    OpenBSD|FreeBSD|DragonflyBSD)
        case "$(file -b -i -L ${HOME}/.wall)" in
            "image/png") $feh & ;;
            "image/jpg") $feh & ;;
            "image/jpeg") $feh & ;;

            "image/gif") $feh & $mpvbg & ;;
            "video/webm") $feh & $mpvbg & ;;
            "video/mp4") $feh & $mpvbg & ;;
            "video/flv") $feh & $mpvbg & ;;
            "video/mkv") $feh & $mpvbg & ;;
        esac 
esac &

# wal's -n flag tells it to skip setting the wallpaper
# Using feh instead forked to background speeds up the script
[ -n "$LIGHT" ] &&
    wal -qnli "$path" ||
    wal -qni "$path"

cat ${HOME}/.cache/wal/sequences

# Generate web browser startpage css
if type sass > /dev/null 2>&1 ; then
    spage=${HOME}/usr/startpage
    sass $spage/scss/style.scss $spage/style.css -- > /dev/null 2>&1
    [ $? -gt 0 ] &&
        echo "sass failed to build" ||
        rm $spage/backup.css $spage/style.css.map -- > /dev/null 2>&1 &
fi &

# Recomp all suckless tools
dir="${HOME}/etc/suckless-tools"
sudo ${HOME}/bin/recomp.sh $dir/dwm $dir/st $dir/tabbed -- > /dev/null 2>&1  &
# type acme > /dev/null 2>&1 &&
#     /bin/sh ${HOME}/var/programs/acme2k/INSTALL.sh -- > /dev/null 2>&1  &

[ $(pgrep compton) ] && COMPTON=true

if [ $(pgrep bar) ] || [ $(pgrep lemonbar) ] ; then
    BAR=true
fi

# kill running procs
[ -z "$nokill" ] &&
case "$(uname)" in
    Linux)
        killall bar lemonbar compton -- > /dev/null 2>&1
        ;;
    OpenBSD)
        pkill -9 bar lemonbar compton -- > /dev/null 2>&1
esac

# relaunch 
[ -n "$BAR" ] &&
    nohup bar -- > /dev/null 2>&1 &

[ -n "$COMPTON" ] &&
    nohup compton -- > /dev/null 2>&1 &
