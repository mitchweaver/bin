#!/bin/sh
#
# Autorice using pywal
#

if [ $# -eq 0 ] ; then
    echo "Usage: sh pywal.sh \$wallpaper_path"
fi

wal -qi "$1" || { echo "wal failed - exiting." ; exit 1; }
cat ~/.cache/wal/sequences &


# copy wallpaper for it to be permanent
rm ${HOME}/workspace/dotfiles/suckless-tools/dwm/wall
cp "$1" ${HOME}/workspace/dotfiles/suckless-tools/dwm/wall &
rm ${HOME}/.wall
cp "$1" ${HOME}/.wall &


# Generate web browser startpage css
startpage=${HOME}/workspace/dotfiles/startpage
sass $startpage/scss/style.scss $startpage/style.css
