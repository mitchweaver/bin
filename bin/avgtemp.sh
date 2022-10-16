#!/bin/sh
#
# https://github.com/mitchweaver
#
# get average CPU temperature on Linux with lm-sensors
#
# shellcheck disable=SC2086,SC2126
#

printf '%s°C\n' \
"$(

bc << EOF
scale=1;
$(
sensors | \
while read -r line ; do
	case $line in
		*Core*)
			set -- $line
			temp=$3
			temp=${temp##+}
			temp=${temp%%°C}
			printf '%s\n' "$temp"
	esac
done | paste -sd+ | bc) / $(sensors | grep Core | wc -l)
EOF

)"
