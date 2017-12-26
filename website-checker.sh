#!/bin/bash


# Checks whether a website exists or not


curl -s --head "$1" | head -n 1 | grep "HTTP/1.[01] [23].." > /dev/null

[[ $? -eq 0 ]] && echo "YES" || echo "NO"
