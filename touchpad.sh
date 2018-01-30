#!/bin/sh

# note: don't forget to install xf86-input-synaptics!
dev="SynPS/2 Synaptics TouchPad"

# two finger scrolling
xinput --set-prop --type=int --format=32 "$dev" "Synaptics Two-Finger Pressure" 4
xinput --set-prop --type=int --format=32 "$dev" "Synaptics Two-Finger Width" 8
xinput --set-prop --type=int --format=8  "$dev" "Synaptics Two-Finger Scrolling" 1 0

# xinput --set-prop --type=int --format=8  "$dev" "Synaptics Palm Detection" 1
