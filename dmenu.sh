#!/usr/bin/env dash

# http://github.com/MitchWeaver/bin

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

# w=$(echo "$sw * 0.6" | bc) # width
# x=$(echo "$sw * 0.5 - $w * 0.5" | bc) # x-offset
# y=$(echo "$sh * 0.18" | bc) # y-offset
# h=$(echo "$sh * 0.02" | bc) # height

dmenu -l $h -nb $color0 -nf $color15 -sb $color2 -sf $color15 -x $x -y $y -wi $w "$@"
