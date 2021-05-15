#!/bin/sh
#
# http://github.com/mitchweaver/bin
#
# f - a tiny posix file searcher
#

usage() {
    >&2 printf 'Usage: %s [-t type] <search terms>\n' "${0##*/}"
    exit 1
}

[ "$1" ] || usage

while [ "$1" ] ; do
    case ${1#-} in
        h)
            usage
            ;;
        t)
            case $2 in
                f|d|l)
                    ;;
                *)
                    usage
            esac
            t="-type $2"
            shift 2
            ;;
        *)
            case $# in
                1)
                    # if only given one term, it must be a search term
                    # and the dir to search in is assumed to be $PWD
                    p=.
                    ;;
                2)
                    if [ -d "$1" ] ; then
                        p=$1
                        shift
                    else
                        usage
                    fi
                    ;;
                *)
                    # we shouldn't ever have three arguments here
                    usage
            esac
            break
    esac
done

# shellcheck disable=2086
exec find -L \
    "$p" ! -path "$p" \
    $t \
    -iname "*${*}*" \
    -maxdepth 10 2>/dev/null
