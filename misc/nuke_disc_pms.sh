#!/bin/sh
sleep 1
for i in $(seq 10) ; do
    xdotool key Up
    xdotool key Up
    xdotool key keydown Control
    xdotool key a
    xdotool key keyup Control
    xdotool key Delete
    xdotool key Return
    sleep 0.1
    xdotool key Return
    sleep 0.5
done
