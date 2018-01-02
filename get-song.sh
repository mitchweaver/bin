#!/bin/bash

# http://github.com/MitchWeaver/bin
#
# TODO: make this posix
# -------------------------------------- #

# max length before truncation
max_len=35
# what to append on a truncation
trunc="..."

# -------------------------------------- #

# gets current song from mpd
#song="`mpc -q current 2> /dev/null`"

# gets current song from mpvc
if [ $(pgrep mpv) ] ; then 
    song="`mpvc -f \"%artist% - %title%\"`"
    if [[ "$song" =~ .*N/A.* ]] ; then
        song="`mpvc -f \"%file%\"`"
    elif [[ "$song" =~ .*MPV.* ]] ; then
        song=""
    fi
fi

if [ "$song" ] ; then
    # chop off filename
    song=${song%".opus"}
    song=${song%".flac"}
    song=${song%".ogg"}
    song=${song%".mp3"}
    song=${song%".wav"}
    song=${song%".cue"}

    # if its too long, trim it down
    if [ ${#song} -gt $max_len ] ; then
        song=`echo "$song" | cut -c1-$max_len`
        song="${song}$trunc"
    fi

    echo "[ ♫ $song ] ∙"

else
    # has to be " " or else NULL causes errors in slstatus
    echo " "
fi
