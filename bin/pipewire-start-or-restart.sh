#!/bin/sh

if command -v emerge >/dev/null ; then
    gentoo-pipewire-launcher restart
else
    if pgrep -x /usr/bin/pipewire >/dev/null ; then
        pkill -x /usr/bin/pipewire
        pkill -x /usr/bin/pipewire-pulse
        pkill -x /usr/bin/wireplumber
    fi

    /usr/bin/pipewire > ~/.cache/pipewire.log 2>&1 &
    /usr/bin/pipewire-pulse > ~/.cache/pipewire-pulse.log 2>&1 &
    /usr/bin/wireplumber > ~/.cache/wireplumber.log 2>&1 &
fi

