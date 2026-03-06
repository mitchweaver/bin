#!/bin/sh

############# flatpak permission-remove desktop-used-apps text/markdown net.cozic.joplin_desktop

flatpak override -u net.cozic.joplin_desktop --socket=wayland

exec flatpak run net.cozic.joplin_desktop
