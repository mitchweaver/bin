#!/bin/sh

# This is a script to recompile often used programs. 
# This allows you to add this script to visudo, as to let a user 
# recompile programs without having to type the root password.

if [ "$1" == "--help" ] || [ "$1" == "-h"  ] ; then
    echo "Usage: sh recomp.sh path1 path2 path3..."
    exit
fi


if [ $(uname) == "Linux" ] ; then
    echo 'TODO: add linux support'
else
    NUM_CORES=$(sysctl -n hw.ncpu)
fi

for i in "$@" ; do

    cd "$i" && 
    make clean > /dev/null &&
    make -j$NUM_CORES > /dev/null &&
    make install > /dev/null &&
    clear

done
