#!/usr/bin/python3
import os
import sys

# NOTE: this is assuming your mpd directory is located at ~/music
#
# Requirements: mpd, mpc, python3
# -------------------------------------------------------------------------- #

# get full path name
# This should be /home/$USER/music/XXX/XXX/...
try:
    PATH=sys.argv[1]
except IndexError:
    print("You must provide a path as an argument")
    exit()

PATH.replace('"', "")
PATH='"' + PATH + '"'

# start mpd, if already started this will be a NOP
os.system("if [ ! $(pgrep mpd) ] ; then mpd > /dev/null && mpc pause > /dev/null  ; fi")

MPD_DIR = os.getenv("HOME") + '/music/'

# if we're not in the dir,
if not MPD_DIR in PATH:
    print("Please use mpd's directory.")
    exit()

# Cut off the beginning to only include
# The MPD database name
PATH = PATH.replace(MPD_DIR, "")

os.system("mpc clear > /dev/null ; mpc add " + PATH + " > /dev/null && mpc play > /dev/null")


# print(PATH)
