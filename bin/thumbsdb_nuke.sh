#!/bin/sh
#
# https://github.com/mitchweaver/bin
#
# because windows is also stupid
#

set -e

case $1 in
    -h|--help)
        >&2 echo 'usage: thumbsdb_nuke [dir]'
        ;;
    *)
        # use current dir if no args
        d="${1:-.}"

        # make sure dir is valid
        [ -d "$d" ] || exit 1

        find "$d" -type f -name Thumbs.db -print 2>/dev/null || :

        printf '\ndelete these? (y/n): '

        read -r ans

        if [ "$ans" = y ]; then
            find "$d" -type f -name Thumbs.db -exec rm -v -- {} + 2>/dev/null || :
        fi
esac

