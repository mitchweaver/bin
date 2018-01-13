#!/bin/sh
#
# http://github.com/MitchWeaver/bin
#
# Autorice using pywal and other tools
#
####################################################

if [ $# -eq 0 ] ; then
    echo "Usage: sh pywal.sh \"\$wallpaper_path\""
    exit 1
fi

# wal's -n flag tells it to skip setting the wallpaper
# Using feh instead forked to background speeds up the script
wal -qni "$1"
feh --bg-fill "$1" &
cat ~/.cache/wal/sequences &

# copy wallpaper for it to be permanent
rm ${HOME}/.wall -- > /dev/null 2>&1
cp "$1" ${HOME}/.wall &

# Generate web browser startpage css
spage=${HOME}/workspace/dotfiles/startpage
sass $spage/scss/style.scss $spage/style.css -- > /dev/null 2>&1 \
    || { echo "sass failed to build - exiting." ; exit 1 ; }
rm $spage/backup.css $spage/style.css.map -- > /dev/null 2>&1 &

# Recomp all suckless tools
dir=${HOME}/workspace/dotfiles/suckless-tools
sudo ${HOME}/bin/recomp.sh $dir/dwm/dwm $dir/st/st $dir/tabbed/tabbed -- > /dev/null 2>&1 

# kill running procs
pkill -9 bar lemonbar compton dash bash sleep -- > /dev/null 2>&1 

# relaunch 
nohup bar -- > /dev/null 2>&1 &
nohup compton -- > /dev/null 2>&1 &
