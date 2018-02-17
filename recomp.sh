#!/bin/sh

# http://github.com/MitchWeaver/bin

# This is a script to recompile often used programs. 
# This allows you to add this script to visudo, as to let a user 
# recompile programs without having to type the root password.

case "$1" in
    --help|-h)
        echo "Usage: sh recomp.sh path1 path2 path3..."
        exit 0
        ;;
esac

case "$(uname)" in
    Linux)
        NUM_CORES=$(echo "$(nproc) + 1" | bc)
        ;;
    OpenBSD)
        NUM_CORES=$(echo "$(sysctl -n hw.ncpu) + 1" | bc)
        ;;
    *) NUM_CORES=3
esac

for i in "$@" ; do

    cd "$i" && 
    make clean &&
    make -j$NUM_CORES &&
    make install || exit 1

done

clear
