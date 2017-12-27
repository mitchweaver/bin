#!/bin/sh

# Import the colors
. "${HOME}/.cache/wal/colors.sh"

dmenu -nb "$color0" -nf "$color15" -sb "$color2" -sf "$color15" "$@"
