#!/bin/sh
# Pulls all from my git servers

dogit(){
    cd "$1" &&
    git pull --force
}

dogit ~/backup
dogit ~/books
dogit ~/downloads
dogit ~/files
dogit ~/images
dogit ~/programs
dogit ~/tmp
dogit ~/videos
dogit ~/workspace

dogit ~/workspace/dotfiles
dogit ~/workspace/Discline
dogit ~/workspace/diskvlt-bot
dogit ~/workspace/dedit
dogit ~/workspace
