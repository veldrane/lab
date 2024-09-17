nft add table nat
nft 'add chain nat postrouting { type nat hook postrouting priority 100 ; }'

nft add rule nat postrouting ip saddr 10.1.8.0/24 oif eno1 masquerade
