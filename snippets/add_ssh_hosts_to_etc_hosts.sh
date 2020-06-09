#!/bin/sh
#
# http://github.com/mitchweaver/bin
#
# print out ssh host aliases in /etc/hosts format
#

grep -A 1 'Host ' ~/.ssh/config | \
xargs | \
sed 's/ -- /\n/g' | \
while read -r _ host _ ip ; do
    printf '%s %s\n' "$ip" "$host"
done
