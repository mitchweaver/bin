#!/bin/sh -e

# automatically read from .travis.yml
if [ -f .travis.yml ] ; then
    while read -r line ; do
        case $line in
            *shellcheck*)
                line=${line##* }
                if [ -d "${line%\/\*}" ] ; then
                    # shellcheck disable=2086
                    shellcheck -s sh $line
                fi
        esac
    done < .travis.yml
fi
