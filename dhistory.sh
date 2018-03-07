#!/usr/bin/env dash
#
# Script to pull up your shell history
# with dmenu and run the chosen command.
#
# http://github.com/mitchweaver/bin
#

# history_file="${HOME}/.$(basename ${SHELL})_history"
history_file="${HOME}/tmp/$(basename ${SHELL})_history"

go_dmenu() {
    # Import the colors
    . ${HOME}/.cache/wal/colors.sh

    res="$(xrandr --nograb --current | awk '/\*/ {print $1}')"
    res="${res% *}"
    sw="${res%x*}"
    sh="${res#*x}"
    sw="${sw%.*}"
    sh="${sh%.*}"

    w=$((sw / 2)) # width
    x=$((sw / 2 - w / 2)) # x-offset
    y=$((sh / 5)) # y-offset
    h=$((sh / 50)) # height

    dmenu -l $h -nb $color0 -nf $color15 -sb $color2 -sf $color15 \
        -x $x -y $y -wi $w -p 'History:' "$@"
}

cat "${history_file}" | awk '!seen[$0]++' | \
    sed '1!G;h;$!d' | go_dmenu | ${SHELL}
