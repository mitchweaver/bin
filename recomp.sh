#!/bin/sh

# This is a script to recompile often used programs. 
# This allows you to add this script to visudo, as to let a user 
# recompile programs without having to type the root password.

if [ "$1" == "--help" ] || [ "$1" == "-h"  ] ; then
    echo "Usage: sh recomp.sh path num_cores"
    exit
fi

if [ $# -eq 1 ] ; then
    NUM_CORES=3
else
    NUM_CORES=$2
fi

cd "$1" && 
make clean > /dev/null &&
make -j$NUM_CORES > /dev/null &&
make install > /dev/null &&
clear
