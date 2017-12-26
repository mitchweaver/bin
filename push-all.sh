#!/bin/sh
# Pushes all my backups to my git server, in parallel.

dogit(){
    cd "$1" &&
    git add -A ; git commit -m 'automated backup' ; git push -u origin master -f
}

dogit ~/backup &
dogit ~/books &
dogit ~/downloads &
dogit ~/files &
dogit ~/images &
dogit ~/programs &
dogit ~/tmp &
dogit ~/videos &
dogit ~/workspace &

# FNAME="workspace-$(date +%m.%d_%H-%M-%S_%Y).tar.gz"

# tar -czpf ~/storage/backups/workspace-backups/$FNAME ~/workspace

# echo "Copying to local /tmp..."
# cp -v ~/storage/backups/workspace-backups/$FNAME /tmp &
# echo "Copying to micro-server..."
# scp ~/storage/backups/workspace-backups/$FNAME micro-server:backups/workspace-backups &
# echo "Copying to bananapi..."
# scp ~/storage/backups/workspace-backups/$FNAME bananapi:/mnt/usb1/backups/workspace-backups &
