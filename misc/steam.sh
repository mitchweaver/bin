#!/bin/sh
#
# set steam in either 1 or 2 scaling based on main monitor
#

read -r width height <<EOF
$(dimensions)
EOF

echo "w: $width ; h: $height"

case $width in
	1920)
		export STEAM_FORCE_DESKTOPUI_SCALING=1.0
		;;
	3840)
		export STEAM_FORCE_DESKTOPUI_SCALING=2.0
esac

case $1 in
	*silent*)
		steam -silent > ~/.cache/launch_steam.log 2>&1 &
		;;
	*)
		steam > ~/.cache/launch_steam.log 2>&1 &
esac

