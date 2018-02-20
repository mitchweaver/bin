#!/bin/sh

if [ $(uname) == "Linux" ] ; then
    echo "Unsupported - exiting..."
    exit 1
else # BSD
    mins=$(apm -m)
    if [ "$mins" == "unknown" ] ; then
        echo "charging..."
        exit
    fi
fi

if [[ $mins -gt 60 ]] ; then

    hours=0
    while [[ $mins -gt 60 ]] ; do
    
        mins=$(echo "$mins - 60" | bc)
        hours=$(echo "$hours + 1" | bc)

    done

fi

if [ $mins -eq 60 ] ; then
    mins=0
    hours=$(echo "$hours + 1" | bc)
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
else
    echo "$mins $ms"
fi
