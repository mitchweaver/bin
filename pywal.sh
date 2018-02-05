#!/bin/dash
#
# http://github.com/MitchWeaver/bin
#
# Autorice using pywal and other tools
#
####################################################

while [ $# -gt 0 ] ; do
    case "$1" in
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
        --no-kill|-n)
            nokill=true
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

# wal's -n flag tells it to skip setting the wallpaper
# Using feh instead forked to background speeds up the script
wal -qni "$path"

# copy wallpaper for it to be permanent
rm ${HOME}/.wall -- > /dev/null 2>&1
cp "$path" ${HOME}/.wall

# based on what is set as my wallpaper,
# this could either be a still picture
# or a cinemagraph. Find out what it is,
# and launch with the appropriate program.
feh="feh --bg-fill --no-fehbg ${HOME}/.wall"
mpvbg="mpvbg ${HOME}/.wall"

if [ "$(uname)" = OpenBSD ] ; then
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
elif [ "$(uname)" = Linux ] ; then
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
fi &

cat ${HOME}/.cache/wal/sequences

# Generate web browser startpage css
if type sass > /dev/null 2>&1 ; then
    spage=${HOME}/workspace/dotfiles/startpage
    sass $spage/scss/style.scss $spage/style.css -- > /dev/null 2>&1
    [ $? -gt 0 ] &&
        echo "sass failed to build" ||
        rm $spage/backup.css $spage/style.css.map -- > /dev/null 2>&1 &
fi

# Recomp all suckless tools
dir="${HOME}/workspace/dotfiles/suckless-tools"
sudo ${HOME}/bin/recomp.sh $dir/dwm/dwm $dir/st/st $dir/tabbed/tabbed -- > /dev/null 2>&1 

# kill running procs
[ -z "$nokill" ] &&
[ "$(uname)" = OpenBSD ] &&
    pkill -9 bar lemonbar compton dash bash sleep -- > /dev/null 2>&1  ||
    killall bar lemonbar compton dash bash sleep -- > /dev/null 2>&1 &

# relaunch 
nohup bar -- > /dev/null 2>&1 &
nohup compton -- > /dev/null 2>&1 &
