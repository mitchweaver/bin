#!/bin/sh

# http://github.com/MitchWeaver/bin

# PAUSE MUSIC
if [ $(pgrep mpd) ] ; then
    mpc -q pause
fi &

# Screenshot
scrot -q 65 /tmp/screen.jpg && jpegoptim --strip-all /tmp/screen.jpg

# Distort to hide text on screen
convert -quiet /tmp/screen.jpg -paint 5 /tmp/screen.png

# Dim 
# convert /tmp/screen.png -level 50% /tmp/screen.png

# Merge Screenshot and Lock Symbol
[[ -f ~/.config/lock.png ]] && convert -quiet /tmp/screen.jpg  \
    ~/.config/lock.png -gravity center -composite -matte /tmp/screen.png

# Lock
i3lock -f -e -i /tmp/screen.png &

# Blank Screen
xset dpms force off

# Delete
rm /tmp/screen.jpg /tmp/screen.png
