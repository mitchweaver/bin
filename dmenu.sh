#!/bin/sh

# http://github.com/MitchWeaver/bin

if [ $(pgrep dmenu) ] ; then
    exit
fi

# Import the colors
. "${HOME}/.cache/wal/colors.sh"

dmenu -f -nb "$color0" -nf "$color15" -sb "$color2" -sf "$color15" "$@"
