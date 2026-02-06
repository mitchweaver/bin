#!/bin/sh
#
# shitty script to keep steam games running at highest priority
#
# -20 for nice (highest)
# 1 for ionice (real time)
#
# https://github.com/mitchweaver/bin
#

if [ "$(id -u)" -ne 0 ] ; then
    >&2 echo "Must be run as root."
    exit 1
fi

INTERVAL=$(( 60 * 5 ))
LOGFILE="/tmp/${0##*/}.log"

while : ; do
    pgrep -f steam | \
    while read -r pid ; do
        renice -n -20 -p "$pid" && echo "Successfully changed process '$pid' nice to -20"
        ionice -c 1 -p "$pid" && echo "Successfully changed process '$pid' ionice to Real Time"
    done
    sleep "$INTERVAL"
done >> "$LOGFILE" 2>&1

