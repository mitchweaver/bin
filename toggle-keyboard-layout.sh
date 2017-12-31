#!/bin/sh

# Toggles between 'us' and us-international keyboard layouts.
# -------------------------------------------------------------------------- #

if [ $(setxkbmap -query | grep -c intl) -eq 1 ] ; then

    setxkbmap -layout us
else
    setxkbmap -layout us -variant intl

fi

xmodmap ~/.Xmodmap
