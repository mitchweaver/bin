#!/bin/sh
# Get detailed weather forecast [for given city]

# Ignore last four lines, stay in pager only if terminal height does
# not suffice
curl -s http://wttr.in/Moon |
	head -n23 |
	less -cFKRSX
