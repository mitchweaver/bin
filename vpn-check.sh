#!/bin/sh

# http://github.com/MitchWeaver/bin

if [ $(pgrep openvpn) ] ; then
    # echo "VPN: ✔️"
    echo "\\uf023"
else
    # echo "VPN: ✖️"
    echo "\\uf09c"
fi
