#!/bin/sh

# Import the colors
. "${HOME}/.cache/wal/colors.sh"

# note: the --current option makes this much faster.
DIM=$(xrandr --current | grep \* | awk '{print $1}')
sw=$(echo "$DIM" | sed 's/x.*//') # screen width
sh=$(echo "$DIM" | sed 's/^[^x]*x//') # screen height

w=$(echo "$sw / 1.5" | bc) # width
x=$(echo "$sw / 2 - $w / 2" | bc) # x-offset
y=$(echo "$sh / 6" | bc) # y-offset

dmenu_run -l 20 -nb "$color0" -nf "$color15" -sb "$color2" -sf "$color15" -x $x -y $y -wi $w "$@"
