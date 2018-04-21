#!/bin/dash
#
#
#
#

band="$(echo "$@" | tr ' ' '\%20')"

case "$BROWSER" in
#    *surf*) tabbed -c surf 
    *chrom*) $BROWSER --new-window \
            "https://metal-archives.com/search?searchString=$band&type=band_name"
    ;;
    *) ;;
esac
