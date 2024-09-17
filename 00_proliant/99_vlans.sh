#!/bin/bash

ID=$1
RE='^[0-9]+$'


 ! [[ "$1" =~ $RE ]] && echo "Add correct vlan id"
 [[ "$1" -ge 4095 ]] && echo "Add correct vlan id"

nmcli con add type vlan con-name vlan$ID ifname vlan$ID dev br-pub0 id $ID ip4 10.1.$ID.1/24 connection.autoconnect true
nmcli con up vlan$ID

sysctl -w net.ipv4.conf.vlan$ID.forwarding=1

echo "net.ipv4.conf.vlan$ID.forwarding=1" > /etc/sysctl.d/10-vlan$ID-forwarding.conf
