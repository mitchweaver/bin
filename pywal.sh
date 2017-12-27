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
spage=${HOME}/workspace/dotfiles/startpage
sass $spage/scss/style.scss $spage/style.css \
    || { echo "sass failed to build - exiting." ; exit 1 ; }
rm $spage/backup.css $spage/style.css.map &

# Recomp all suckless tools

