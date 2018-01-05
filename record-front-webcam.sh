#!/bin/sh

# ffmpeg -f v4l2 -video_size 640x480 -r 30 -i /dev/video0 output.mkv

ffmpeg -i /dev/video0 -f sndio -i default "$(date)".mp4
# -video_size 640x480 
# -r 30 
# -f v4l2 
# -i default
