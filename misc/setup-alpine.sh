#!/bin/sh
#
# https://github.com/mitchweaver/setup-alpine
#

die() {
    >&2 echo "$@"
    exit 1
}

[ "$(id -u)" -eq 0 ] || die "you're not root idiot"

# =============================================== 
# setup repositories to edge and enable testing
# =============================================== 
cat >/etc/apk/repositories <<"EOF"
http://dl-cdn.alpinelinux.org/alpine/edge/main
http://dl-cdn.alpinelinux.org/alpine/edge/community
http://dl-cdn.alpinelinux.org/alpine/edge/testing
EOF
apk update

# ===============================================
# add common programs
# ===============================================
apk add neovim git rsync wget tree mandoc

# ===============================================
# security
# ===============================================
apk add fail2ban
rc-update add fail2ban default
rc-service fail2ban start

# ===============================================
# premit root ssh
# ===============================================
sed -i -e 's/.*ermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
rc-update add sshd default
rc-service sshd start

# ===============================================
# disable ipv6
# ===============================================
cat >/etc/sysctl.d/no-ipv6.conf <<"EOF"
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
net.ipv6.conf.lo.disable_ipv6=1
EOF
sysctl --load

