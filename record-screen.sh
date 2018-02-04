#!/bin/bash

# http://github.com/MitchWeaver/bin

# Records a selected rectangle with ffmpeg. Provide an argument
# For the framerate.
# -------------------------------------------------------------------------- #

# make sure we're not already running
[ "$(pgrep slop)" ] && exit

read -r X Y W H <<< $(slop -q -o -f '%x %y %w %h')

if [ $# -eq 0 ] ; then
    FRAMERATE=30
else
    FRAMERATE=$1
fi

file="$(date +%m.%d_%H-%M-%S_%Y)".mp4

ffmpeg -y -f x11grab -s "$W"x"$H" -r $FRAMERATE -i :0.0+$X,$Y -qscale 0 $file 

if [ "$1" == "--upload" ] || [ "$2" == "--upload" ] || [ "$1" == "-u" ] || [ "$2" == "-u" ] ; then

    curl -sF file=@"$file" https://0x0.st | xclip &&
    xclip -o

fi

