#!/bin/sh

########## doas flatpak install flathub com.getmailspring.Mailspring

exec flatpak run com.getmailspring.Mailspring --password-store="gnome-libsecret"

