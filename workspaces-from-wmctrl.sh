#!/bin/bash

wmctrl -d | awk '$2=="-"{printf " " $NF " "} $2=="*"{printf "[" $NF "]" }'
