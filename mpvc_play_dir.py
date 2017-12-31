#!/usr/bin/python3

# http://github.com/MitchWeaver/bin

# NOTE: this is assuming your mpd directory is located at ~/music
#
# Requirements: mpd, mpc, python3
# -------------------------------------------------------------------------- #

import os
import sys

# get full path name
# This should be /home/$USER/music/XXX/XXX/...
try: PATH=sys.argv[1]
except IndexError:
    print("You must provide a path as an argument")
    exit()

PATH.replace('"', "")
PATH.replace('$(', "")
PATH.replace('`', "")
PATH='"' + PATH + '"'

cmd='mpv --really-quiet --input-ipc-server=/tmp/mpvsocket '

vid_exts = [ '.mp4', '.webm', '.flv', '.gif', '.mpv' ]

if not any(ext in PATH for ext in vid_exts):
    cmd = cmd + "--no-video "

os.system("pkill -9 mpv > /dev/null ; " + "nohup " + cmd + PATH + " > /dev/null &")
