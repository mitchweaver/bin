#!/bin/bash
# Get detailed weather forecast for given city/location

# stay in pager only if terminal height does
# not suffice
# nc -cTnoverify wttr.in 443 << EOF |
# GET /${1:?} HTTP/1.0
# Host: wttr.in
# User-Agent: curl

# EOF
# 	grep -Fe│ -e─ |
# 	less -cFKRSX

curl http://wttr.in/"$1"
