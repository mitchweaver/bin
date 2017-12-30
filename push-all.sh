#!/bin/sh

# http://github.com/MitchWeaver/bin

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
