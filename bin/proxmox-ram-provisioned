#!/bin/sh
#
# https://github.com/mitchweaver/bin
#
# tool to get a nice overview of RAM provisioned
# for all VMs/containers on your proxmox server
#
# ------------------------------------------------


# keep a running total of bytes provisioned
TOTAL=0

# convert bytes to human readable format
human() {
    if [ "$1" -gt 1099511627776 ] ; then
        res=$(( $1 * 10 / 1099511627776 ))
        pow=T
    elif [ "$1" -gt 1073741824 ] ; then
        res=$(( $1 * 10 / 1073741824 ))
        pow=G
    elif [ "$1" -gt 1048576 ] ; then
        res=$(( $1 * 10 / 1048576 ))
        pow=M
    elif [ "$1" -gt 1024 ] ; then
        res=$(( $1 * 10 / 1024 ))
        pow=K
    else
        printf '%sB\n' "${1:-0}"
        exit
    fi

    # shellcheck disable=SC2295
    printf "%s$pow\n" "${res%?}.${res#${res%?}}"
}


cat <<"EOF"
VIRTUAL MACHINE RAM USAGE:
---------------------------
EOF

for file in /etc/pve/qemu-server/*.conf ; do
    # get memory in megabytes
    mem=$(grep memory: "$file")
    mem=${mem#*: }
    # convert megabytes to bytes
    mem="$((mem * 1024 * 1024))"
    TOTAL=$((TOTAL + mem))
    mem=$(human "$mem")
    name=$(grep name: "$file")
    printf '%s: %s\n' "${name#*: }" "$mem"
done

cat <<"EOF"

CONTAINER RAM USAGE:
---------------------------
EOF

for file in /etc/pve/lxc/*.conf ; do
    # get memory in megabytes
    mem=$(grep memory: "$file")
    mem=${mem#*: }
    # convert megabytes to bytes
    mem="$((mem * 1024 * 1024))"
    TOTAL=$((TOTAL + mem))
    mem=$(human "$mem")
    name=$(grep name: "$file")
    printf '%s: %s\n' "${name#*: }" "$mem"
done

cat <<"EOF"

TOTAL RAM PROVISIONED:
---------------------------
EOF

human "$TOTAL"
