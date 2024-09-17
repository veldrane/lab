#!/bin/bash

# Flush existing rules
nft flush ruleset

# Create NAT table and chains
nft add table ip nat
nft add chain ip nat prerouting { type nat hook prerouting priority 0 \; }
nft add chain ip nat postrouting { type nat hook postrouting priority 100 \; }

# NAT rule for outgoing traffic to the internet
nft add rule ip nat postrouting oif "eno1" ip saddr 10.1.0.0/16 ip daddr != 192.168.1.0/24 ip daddr != 10.2.0.0/16 ip daddr != 10.1.0.0/16 counter snat to 192.168.1.228
nft add rule ip nat postrouting oif "eno1" ip saddr 10.2.0.0/16 ip daddr != 192.168.1.0/24 ip daddr != 10.2.0.0/16 ip daddr != 10.1.0.0/16 counter snat to 192.168.1.228

# Accept rule for local traffic to 192.168.1.0/24 and 10.2.0.0/16
nft add rule ip nat postrouting oif "eno1" ip daddr { 192.168.1.0/24, 192.168.2.0/24 } counter accept
