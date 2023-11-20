#!/bin/sh
#
# http://github.com/mitchweaver/bin
#
# archive things
#
# shellcheck disable=2181
# ========================================================================

usage() {
    >&2 printf 'Usage: %s [-n no remove] [-xz] [-lz4] <dir>\n' "${0##*/}"
    exit 1
}

while [ "$1" ] ; do
    case ${1#-} in
        lz4)
            ALGO=lz4
            shift
            ;;
        xz)
            ALGO=xz
            shift
            ;;
        n)
            NO_REMOVE=true
            shift
            ;;
        *)
            # is a folder
            break
    esac
done

[ -d "$1" ] || usage

# safely exit if given root :^)
[ "$1" = / ] && exit 1

: "${ALGO:=xz}"
out="${1%/}".tar.$ALGO

if [ -f "$out" ] ; then
    printf "file '%s' already exists, overwrite? (y/n): " "$out"
    read -r ans
    [ "$ans" = y ] || exit 1
fi

# note: lz4 default is -1, with the --best being -12
#       seems -6 is a happy medium where it compresses
#       reasonably well but doesn't take forever
#       (speed is the whole point of lz4 anyway)
case $ALGO in
    xz)  tar -cvf - "$1" | xz -qcT 0 > "$out" ;;
    lz4) tar -cvf - "$1" | lz4 -q -6 > "$out"
esac

[ $? -eq 0 ] || exit 1

if [ ! "$NO_REMOVE" ] ; then
    rm -r "$1"
fi
