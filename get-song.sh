#!/bin/sh

# gets current song from mpd
song="`mpc -q current 2> /dev/null`"

# if its not null
if [ "$song" ]; then

    # chop off filename
    song=${song%".opus"}
    song=${song%".flac"}
    song=${song%".ogg"}
    # song=${song%".mp3"}

    # if its too long, trim it down
    max_len=35
    if [ ${#song} -gt $max_len ] ; then
        song=`echo "$song" | cut -c1-$max_len`
        song="${song}..."
    fi

    echo "[ ♫ $song ] ∙"

else
    # has to be " " or else NULL causes errors in apps
    echo " "

fi
