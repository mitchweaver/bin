#!/bin/bash

# Records a selected rectangle with ffmpeg. Provide an argument
# For the framerate. Note: bash only.
# -------------------------------------------------------------------------- #

read -r X Y W H <<< $(slop -q -o -f '%x %y %w %h')

if [ $# -eq 0 ] ; then
    FRAMERATE=30
else
    FRAMERATE=$1
fi

ffmpeg -f x11grab -s "$W"x"$H" -r $FRAMERATE -i :0.0+$X,$Y -qscale 0 "$(date +%m.%d_%H-%M-%S_%Y)".mp4
