#!/bin/bash

# increments/decrements current screen brightness.
# Also clamps the final output as to not have the screen
# go blank/and or above 100% brightness.

[[ $1 == "-inc" ]] && xbacklight -inc $2 || xbacklight -dec $2

if [ $(printf "%0.f" $(xbacklight -get)) -lt 1 ] ; then xbacklight -set 1 && exit ; fi

if [ $(printf "%0.f" $(xbacklight -get)) -gt 100 ] ; then xbacklight -set 100 && exit ; fi
