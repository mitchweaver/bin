#!/bin/bash

# http://github.com/MitchWeaver/bin

# totally nukes your ~/.local/share/Trash

if [ $(uname) == "Linux" ] ; then
    find /home/mitch/.local/share/Trash/files -type f -exec shred -fuz {} \; > /dev/null
    find /home/mitch/.local/share/Trash/info -type f -exec shred -fuz {} \; > /dev/null
# else
    # BSD doesn't have shred :c
fi

rm -rf /home/mitch/.local/share/Trash/files/*
rm -rf /home/mitch/.local/share/Trash/info/*

