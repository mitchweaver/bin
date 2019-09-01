#!/bin/sh -ex
#
# http://github.com/mitchweaver/bin
#
# launches some micro$oft garbage in qemu
# for some uni classes I'm forced to take
#

disk=${HOME}/env/windows/winshit.qcow2

qemu-system-x86_64 \
    -daemonize \
    -m 2G \
    -vga std \
    -usb \
    -device usb-tablet \
    $disk &

    #-enable-kvm
wait
