#!/bin/sh

if [ $(uname) == "Linux" ] ; then
    echo "Unsupported - exiting..."
    exit 1
else # BSD
    mins=$(apm -m)
fi

if [[ $mins -gt 60 ]] ; then

    hours=0
    while [[ $mins -gt 60 ]] ; do
    
        mins=$(echo "$mins - 60" | bc)
        hours=$(echo "$hours + 1" | bc)

    done

fi

if [ $hours -gt 1 ] ; then
    hs="hours"
else
    hs="hour"
fi

if [ $mins -gt 1 ] ; then
    ms="mins"
else
    ms="min"
fi

if [ $hours ] ; then
    if [ $mins -gt 0 ] ; then
        echo "$hours $hs $mins $ms"
    else
        echo "$hours $hs"
    fi
elif [ $mins -eq 60 ] ; then
    echo "1 $hs"
else
    echo "$mins $ms"
fi
