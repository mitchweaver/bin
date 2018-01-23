#!/bin/bash

# http://github.com/MitchWeaver/bin

# make sure we're not already running
# if [ "$(pgrep BSDNixVolume.sh)" ] ; then
    # exit
# fi

if [ "$(uname)" == "Linux" ] ; then

    # NOTE: linux version is bash only --- to be fixed
    if [ "$1" == "-get" ] ; then
        if [ -z $(pidof pulseaudio) ] ; then
            vol=$(awk -F"[][]" '/dB/ { print $2 }' $(amixer sget Master))
        else
            vol=$(amixer -D pulse sget Master | \
                awk '/%/ {gsub(/[\[\]]/,""); print $5}')
        fi

        vol_val=$(echo $vol | sed 's/.$//')
    
    elif [ "$1" == "-set" ] ; then

        if [ -z $(pidof pulseaudio) ] ; then
            amixer -q sset Master "$2"%+
        else
            amixer -q -D pulse sset Master "$2"%+
        fi

        exit

    elif [ "$1" == "-mute" ] ; then
        echo "Unimplemented. To do."
  
    fi

# elif test mixerctl ; then
else # BSD

    case "$1" in
        "-get")
            tmp=$(mixerctl -n outputs.master)
            vol_val=${tmp%,*}

            # BSD has a peculiarity, that its volume is actually 0-255, not 0-100
            # To get the proper percent, we will accomodate for that here.
            vol_val=$(echo $vol_val \* 0.392 | bc)
            # convert back to int
            vol_val=${vol_val%.*}

            # checks if the volume is either A: below zero
            # or B: a non-number was returned
            if [ $vol_val -lt 0 ] ; then
                vol_val=0
            elif [ $vol_val -gt 98 ] ; then
                vol_val=100
            fi

            vol=$vol_val% ;;

        "-set")
            mixerctl -q outputs.master="$2"
            exit ;;

        "-mute")
            # restoring from mute
            if [ $(mixerctl -n outputs.master) -eq 0 ] ; then
                if [ -f /tmp/mutevol] ; then
                    mixerctl -q outputs.master=$(cat /tmp/mutevol)
                    rm /tmp/mutevol
                fi
            else
                echo $(mixerctl -n outputs.master) > /tmp/mutevol
                mixerctl -q outputs.master=0
            fi ;;
        esac

fi

echo "$vol_val"
