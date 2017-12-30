#!/bin/bash

# http://github.com/MitchWeaver/bin

ffmpeg -i "$1" -vf scale=320:-1 -r 10 -f image2pipe -vcodec ppm - | convert -delay 5 -loop 0 - "$1".gif
