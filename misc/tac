#!/bin/sh
#
# http://github.com/mitchweaver/bin
#
# POSIX tac
#

usage() { >&2 echo 'Usage: tac [file]' ; exit 1 ; }

if [ "$1" ] ; then
    case $1 in
        -h)
            usage
            ;;
        *)
            [ -f "$1" ] || usage
            sed '1!G;h;$!d' "$1"
    esac
else
    while read -r inp ; do
        printf '%s\n' $inp
    done | sed '1!G;h;$!d'
fi
