#!/usr/bin/awk -f
# This script is used on https://notabug.org/kl3/barricade to generate
# traffic statistics

BEGIN {
"netstat -b -I em0 | sed '2q;d'" | getline
# Total in- and outbound traffic on WAN interfaces in bytes
ibytes = $(NF - 1)
obytes = $NF

# Traffic in mebibytes
ibytes_m = ibytes / 1024 / 1024
obytes_m = obytes / 1024 / 1024

printf "In: \t%dMB\nOut: \t%dMB\n", \
       ibytes_m, obytes_m \

# Traffic in gibibytes
ibytes_g = ibytes_m / 1024
obytes_g = obytes_m / 1024

printf "In: \t%dGB\nOut: \t%dGB\n", \
       ibytes_g, obytes_g

printf "In: \t%dTB\nOut: \t%dGB\n", \
       ibytes_g / 1024,
       obytes_g / 1024
}
