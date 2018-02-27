#!/bin/sh

while [ $# -gt 0 ] ; do

    case "$1" in
        --disk|-d)
            disk="$2"
            shift
            ;;
        --memory|-m|--ram)
            memory="$2"
            shift
            ;;
        --cdrom|-cdrom|-c)
            cdrom="$2"
            shift
            ;;
        --help|-h)
            printf "%s\n" \
                "Usage: --disk /path/to/disk"
    esac
    
    shift

done

if [ -z "$disk" ] ; then
    printf "%s\n%s\n" \
        "No disk specified." \
        "See --help for more information."
    exit 1
fi

[ -z "$memory" ] &&
    memory=2048

[ -n "$cdrom" ] &&
    cdrom="-cdrom $cdrom"

case "$(uname)" in
    Linux)
        qemu-system-x86_64 \
            -daemonize \
            -enable-kvm \
            -m $memory \
            -vga std \
            -usb -device usb-tablet $cdrom \
            "$disk" &
            # -net nic -net bridge,br=br0 \
            ;;
    OpenBSD)
        qemu-system-x86_64 \
            -daemonize \
            -m $memory \
            -vga std \
            -usb -device usb-tablet $cdrom \
            "$disk" &
esac

