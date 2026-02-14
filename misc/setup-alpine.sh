#!/bin/sh
#
# https://github.com/mitchweaver/setup-alpine
#
# ==============================================

# ==============================================
# CONFIG
DNS_SERVER_IP="192.168.100.200"
# ==============================================

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

cat >/root/update.sh <<"EOF"
#!/bin/sh -e
apk update
apk upgrade --force-missing-repositories
EOF

chmod +x /root/update.sh
sh /root/update.sh

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
sysctl -p

# ===============================================
# clear motd
# ===============================================
rm -fv /etc/motd

# ===============================================
# DNS
# ===============================================
# prevent udhcpc from overwriting on startup
echo 'RESOLV_CONF="no"' > /etc/udhcpc/udhcpc.conf

# if this is a container, prevent PVE from overwriting
# /etc/resolv.conf with the hosts config
touch /etc/.pve-ignore.resolv.conf

# setup resolvconf
cat >/etc/resolvconf.conf <<EOF
resolv_conf=/etc/resolv.conf
name_servers="$DNS_SERVER_IP"
EOF
resolvconf -u

# ===============================================

# ===============================================
# ntpd
# ===============================================
rc-update add ntpd default
rc-service ntpd start

# ===============================================
# qemu guest agent
# ===============================================
apk add qemu-guest-agent qemu-guest-agent-openrc
rc-update add qemu-guest-agent default
rc-service qemu-guest-agent start

# ===============================================
# docker
# ===============================================
printf 'do you plan to use docker? (y/n): '
read -r ans
case $ans in
    y|yes)
        apk add docker docker-cli docker-cli-compose
        rc-update add docker default
        rc-service docker start
esac

printf 'do you plan to use nginx? (y/n): '
read -r ans
case $ans in
    y|yes)
        apk add nginx nginx-openrc
        rc-update add nginx default
        rc-service nginx start
esac

# ===============================================
# nfs
# ===============================================
printf 'will this machine be an nfs client? (y/n): '
read -r ans
case $ans in
    y|yes)
        apk add nfs-utils rpcbind util-linux
        rc-update add rpc.statd default
        rc-service rpc.statd start
esac

# ===============================================
# samba
# ===============================================
printf 'will this machine be an samba client? (y/n): '
read -r ans
case $ans in
    y|yes)
        apk add samba-client cifs-utils
esac

# ===============================================
# add common userland programs
# ===============================================
apk add neovim git rsync wget curl tree mandoc htop make eza bat progress pv neofetch

# ===============================================
# grab my bin
# ===============================================
tempdir="$HOME/setup-alpine-tmp"
mkdir -p "$tempdir"
cd "$tempdir"
git clone https://github.com/mitchweaver/bin
cd bin
mkdir -p ~/.local/bin
make
make install
# shellcheck disable=SC2016
echo 'export PATH=$PATH:${HOME}/.local/bin' >> ~/.profile
rm -rf -- "$tempdir"
. ~/.profile

# ===============================================
# setup my neovim vimrc
# ===============================================
tempdir="$HOME/setup-alpine-tmp"
mkdir -p "$tempdir"
cd "$tempdir"
git clone https://github.com/mitchweaver/dots
cd dots/scripts
sh grab-vim.sh
# removing deoplete (python3) for security
sed -i -e 's/.*deoplete.*//g' ~/.vimrc
rm -rf -- "$tempdir"
cd ~
command nvim +PlugInstall +q +q

# ===============================================
# basic aliases
# ===============================================
cat >> ~/.profile <<"EOF"
alias ls='eza -F --color=always --group-directories-first'
alias bat='bat -p --pager=never --wrap=never --color=auto'
alias l=ls
alias c=clear
alias v=nvim
alias vim=nvim
alias grep='grep -i'

set -o vi
EOF

