#!/bin/sh
#
# https://github.com/mitchweaver
#
# ever bork your iptable config and need
# to rule out it being the problem?
#

ip6tables --policy INPUT   ACCEPT;
ip6tables --policy OUTPUT  ACCEPT;
ip6tables --policy FORWARD ACCEPT;

ip6tables -Z; # zero counters
ip6tables -F; # flush rules
ip6tables -X; # delete all chains

iptables --policy INPUT   ACCEPT;
iptables --policy OUTPUT  ACCEPT;
iptables --policy FORWARD ACCEPT;

iptables -Z; # zero counters
iptables -F; # flush rules
iptables -X; # delete all chains
