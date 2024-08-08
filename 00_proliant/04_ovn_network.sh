#!/bin/bash 

ovs-vsctl add-br br-int0
#nmcli con up br-int0
ip link set dev br-int0 up
#nmcli con modify br-int0 connection.autoconnect true
nmcli con add type vlan con-name vlan64 ifname vlan64 dev br-int0 id 64 ip4 10.2.64.1/24 connection.autoconnect true
nmcli con up vlan64
echo "net.ipv4.conf.vlan64.forwarding=1" > /etc/sysctl.d/10-vlan64-forwarding.conf

virsh net-define libvirt-network/ovn.xml 
virsh net-start ovn
virsh net-autostart ovn
