#!/usr/bin/env dash
#
# http://github.com/mitchweaver/bin
#


while [ $# -gt 0 ] ; do

    case "$1" in
        --help|-h)
            printf "%s\n" \
                "Usage: --mpc/--mpd --path <path>"
            exit 0
            ;;
        --mpv) 
            PLAYER=mpv
            ;;
        --mpd|--mpc)
            PLAYER=mpd
            ;;
        --path)
            dir="$2"
            shift
            ;;
        *)
            OPTIONS="$OPTIONS $1"
    esac

    shift
done

[ -z "$PLAYER" ] &&
    PLAYER=mpv

[ "$(pgrep mpv)" ] && pkill -9 mpv

case "$PLAYER" in
    mpv)
        nohup mpv --really-quiet --no-video --input-ipc-server=/tmp/mpvsocket \
            --title=mpv $OPTIONS "$dir" -- > /dev/null 2>&1 &
        ;;
    mpd)
        python3 /home/mitch/bin/mpc_play_dir.py "$dir"
esac

res="$(xrandr --nograb --current | awk '/\*/ {print $1}')"
res="${res% *}"
sw="${res%x*}"
sh="${res#*x}"
w=$(echo "$sw * 0.5" | bc) # width
h=$(echo "$sh * 0.5" | bc) # height
w=${w%.*}
h=${h%.*}

opts=-'x --auto-rotate -Y -q --scale-down'
if [ -f "$dir"/*over.* ] ; then
    nohup feh $opts -g "$w"x"$h" "$dir"/*over.* > /dev/null 2>&1 &
elif [ -f "$dir"/*ront.* ] ; then 
    nohup feh $opts "$dir"/*ront.* > /dev/null 2>&1 &
elif [ -f "$dir"/*rt.* ] ; then 
    nohup feh $opts "$dir"/*rt.* > /dev/null 2>&1 &
elif [ -f "$dir"/*older.* ] ; then 
    nohup feh $opts "$dir"/*older.* > /dev/null 2>&1 &
elif [ -f "$dir"/*mage.* ] ; then 
    nohup feh $opts "$dir"/*mage.* > /dev/null 2>&1 &
else
    nohup feh $opts "$dir"/*.jpg > /dev/null 2>&1 &
fi

echo "$dir" > /tmp/currently_playing
