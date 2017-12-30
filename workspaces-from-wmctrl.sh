#!/bin/bash

# http://github.com/MitchWeaver/bin

wmctrl -d | awk '$2=="-"{printf " " $NF " "} $2=="*"{printf "[" $NF "]" }'
