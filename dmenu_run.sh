#!/bin/bash

# http://github.com/MitchWeaver/bin

# Import the colors
. "${HOME}/.cache/wal/colors.sh"

# note: the --current/--nograb option makes this much faster.
DIM=$(xrandr --nograb --current | grep \* | awk '{print $1}')
sw=$(echo "$DIM" | sed 's/x.*//') # screen width
sh=$(echo "$DIM" | sed 's/^[^x]*x//') # screen height

w=$(echo "$sw / 1.60" | bc) # width
x=$(echo "$sw / 2 - $w / 2" | bc) # x-offset
y=$(echo "$sh / 6" | bc) # y-offset
h=$(echo "$sh / 50" | bc) # height

dmenu_run -f -l $h -nb "$color0" -nf "$color15" -sb "$color2" -sf "$color15" -x $x -y $y -wi $w -p "Run:" "$@"
