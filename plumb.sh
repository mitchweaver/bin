#!/usr/bin/env dash

# echo "$@" >> /home/mitch/test.txt

echo "$(sselp)" >> /home/mitch/test.txt

pattern="$(sselp)"
[ -z "$pattern" ] &&
    exit

patternbase=${pattern%%:*} 
