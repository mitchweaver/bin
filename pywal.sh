#!/bin/dash
#
# http://github.com/MitchWeaver/bin
#
# Autorice using pywal and other tools
#

while [ $# -gt 0 ] ; do
    case "$1" in
        --light|-l)
            LIGHT=true
            ;;
        --no-kill|-n)
            nokill=true
            ;;
        --help|-h)
            printf "%s\n%s\n%s\n\n%s\n%s\n%s\n%s\n" \
                "Usage: " \
                "------------------------------------" \
                "$ sh pywal.sh \"\$wallpaper_path\"" \
                "Options:" \
                "------------------------------------" \
                "--no-kill    -    do not kill progs" \
                "--light      -    make a light theme"
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
    echo "Unable to copy to $wall_path"
    exit 1
fi

# based on what is set as my wallpaper,
# this could either be a still picture
# or a cinemagraph. Find out what it is,
# and launch with the appropriate program.
feh="feh --bg-fill --no-fehbg "$wall_path""
mpvbg="mpvbg "$wall_path""
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

# Recomp suckless tools
dir="${HOME}/etc/suckless-tools"
doas ${HOME}/bin/recomp.sh $dir/dwm $dir/st $dir/tabbed -- > /dev/null 2>&1  &

if [ -z "$nokill" ] ; then
    [ $(pgrep compton) ] && COMPTON=true
    [ $(pgrep bar) ]     && BAR=true

    pkill -9 bar lemonbar compton -- > /dev/null 2>&1

    # relaunch 
    [ -n "$BAR" ]     && nohup bar     -- > /dev/null 2>&1 &
    [ -n "$COMPTON" ] && nohup compton -- > /dev/null 2>&1 &
fi
