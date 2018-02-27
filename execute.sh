#!/bin/sh

sleep 0.2

xdotool key -delay 0.01 control+U

# type what was in the selection
xdotool type  -delay 0.01 "$(xsel -o)"

# run the command
xdotool key -delay 0.01 Return
