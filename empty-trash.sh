#!/bin/bash

# http://github.com/MitchWeaver/bin

# totally nukes your ~/.local/share/Trash

find /home/mitch/.local/share/Trash/files -type f -exec shred -fuz {} \; > /dev/null
find /home/mitch/.local/share/Trash/info -type f -exec shred -fuz {} \; > /dev/null

rm -rf /home/mitch/.local/share/Trash/files/*
rm -rf /home/mitch/.local/share/Trash/info/*

