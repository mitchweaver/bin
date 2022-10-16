#!/bin/sh -e

dir="gnome-backup-$(date +'%Y%m%d_%H%M%S')"
mkdir -p "$dir/config" "$dir/local/share"

dconf dump / > "$dir/dconf_dump.dconf"

cp -r ~/.config/gnome-control-center "$dir/config"/
cp -r ~/.config/gnome-session "$dir/config"/
cp -r ~/.config/dconf "$dir/config"/
cp -r ~/.config/nautilus "$dir/config"/

cp -r ~/.local/gnome-shell "$dir/local"/
cp -r ~/.local/gnome-settings-daemon "$dir/local"/
cp -r ~/.local/nautilus "$dir/local"/
cp -r ~/.local/share/gnome-settings-daemon "$dir/local/share"/
cp -r ~/.local/share/gnome-shell "$dir/local/share"/

tar -cvpJf "$dir".tar.xz "$dir" && rm -r "$dir"

# --------------------------------
# note to restore dconf:
# $ dconf load / < dconf_dump.dconf
