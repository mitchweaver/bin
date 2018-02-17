#!/bin/sh

# Toggles between 'us' and us-international keyboard layouts.
# -------------------------------------------------------------------------- #

notify='notify-send -t 1000 -u low'

if [ "$(setxkbmap -query | grep -c intl)" -eq 1 ] ; then

    # setxkbmap -layout us -variant dvorak

    # $notify "Keyboard Layout: Dvorak"

# elif [ "$(setxkbmap -query | grep -c dvorak)" -eq 1 ] ; then

    setxkbmap -layout us

    $notify "Keyboard Layout: US"

else

    setxkbmap -layout us -variant intl

    $notify "Keyboard Layout: US International"

fi

xmodmap ${HOME}/.Xmodmap
