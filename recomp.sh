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
    NUM_CORES=3
else
    NUM_CORES=$(echo "$(sysctl -n hw.ncpu) + 1" | bc)
fi

for i in "$@" ; do

    cd "$i" && 
    make clean &&
    make -j$NUM_CORES &&
    make install

done

clear
