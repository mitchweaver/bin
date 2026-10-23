#!/bin/sh
#
# https://github.com/mitchweaver/bin
#
# because MacOS is stupid
#

set -e

case $1 in
    -h|--help)
        >&2 echo 'usage: dsstore_nuke [dir]'
        ;;
    *)
        # use current dir if no args
        d="${1:-.}"

        # make sure dir is valid
        [ -d "$d" ] || exit 1

        find "$d" -xdev -type f -name .DS_Store -print 2>/dev/null || :

        printf '\ndelete these? (y/n): '

        read -r ans

        if [ "$ans" = y ]; then
            find "$d" -xdev -type f -name .DS_Store -exec rm -- {} + 2>/dev/null || :
        fi
esac
