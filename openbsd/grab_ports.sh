#!/bin/sh -e
#
# http://github.com/mitchweaver/bin
#
# shellcheck disable=2046
#

case $(uname) in
    OpenBSD)
        ;;
    *)
        exit 1
esac

if [ ! -d /usr/ports ] ; then
    cd /tmp
    for f in ports.tar.gz SHA256.sig ; do
        ftp https://cdn.openbsd.org/pub/OpenBSD/$(uname -r)/$f
    done
    signify -Cp \
        -x /etc/signify/openbsd-$(uname -r | cut -c 1,3)-base.pub \
        ports.tar.gz
    mkdir -p /usr/ports
    cd /usr
    tar xvzf /tmp/ports.tar.gz
    rm /tmp/ports.tar.gz /tmp/SHA256.sig

    git clone https://github.com/jasperla/openbsd-wip /usr/ports/openbsd-wip
fi
