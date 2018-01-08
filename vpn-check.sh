#!/bin/sh

# http://github.com/MitchWeaver/bin

if [ $(pgrep openvpn) ] ; then
    echo "\\uf023"
else
    echo "\\uf09c"
fi
