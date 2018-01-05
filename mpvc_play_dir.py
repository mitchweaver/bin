#!/usr/bin/python3

# http://github.com/MitchWeaver/bin

# Requirements: mpv, mpvc, python3
# -------------------------------------------------------------------------- #

import os
import sys

try: PATH=sys.argv[1]
except IndexError:
    print("You must provide a path as an argument")
    exit()

PATH.replace('"', "")
PATH.replace('$(', "")
PATH.replace('`', "")
PATH='"' + PATH + '"'

cmd='mpv --really-quiet --title=mpv --input-ipc-server=/tmp/mpvsocket '

vid_exts = [ '.mp4', '.webm', '.flv', '.gif', '.mpv' ]

if not any(ext in PATH for ext in vid_exts):
    cmd = cmd + "--no-video "

if "--no-video" in cmd:
    os.system("if [ $(pgrep mpd) ] ; then pkill -9 mpd ; fi")

os.system("pkill -9 mpv > /dev/null ; " + "nohup " + cmd + PATH + " > /dev/null &")
