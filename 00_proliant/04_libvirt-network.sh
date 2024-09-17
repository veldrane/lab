#!/bin/bash 

ovs-vsctl add-br br-pub0
#nmcli con up br-pub0
ip link set dev br-pub0 up
#nmcli con modify br-pub0 connection.autoconnect true
nmcli con add type vlan con-name vlan8 ifname vlan8 dev br-pub0 id 8 ip4 10.1.8.1/24 connection.autoconnect true
nmcli con up vlan8
echo "net.ipv4.conf.vlan8.forwarding=1" > /etc/sysctl.d/10-vlan8-forwarding.conf
echo "net.ipv4.conf.eno1.forwarding=1" > /etc/sysctl.d/10-eno1-forwarding.conf

virsh net-define libvirt-network/public.xml 
virsh net-start public
virsh net-autostart public
