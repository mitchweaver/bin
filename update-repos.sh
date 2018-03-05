#!/bin/sh
#
#

# ------------------------------------------------------- 
[ "$(uname)" == OpenBSD ] &&
    alias sudo=doas


if type python3.6 > /dev/null 2>&1 ; then
    PYTHON=python3.6
elif type python3.5 > /dev/null 2>&1 ; then
    PYTHON=python3.5
elif type python3 > /dev/null 2>&1 ; then
    PYTHON=python3
fi

dir="${HOME}/programs"
# ------------------------------------------------------- 

update-make() {
    cd "$dir/$1" &&
        git pull

    sudo make &&
    sudo make install
}

update-py() {
    cd "$dir"/"$1" &&
        git pull

    sudo $PYTHON setup.py install
}

# ------------------------------------------------------- 



update-py pywal
update-py doge
update-py ranger

update-make neofetch
update-make bush
update-make mpvc
update-make ranger_devicons
update-make translate-shell
update-make xwinwrap

