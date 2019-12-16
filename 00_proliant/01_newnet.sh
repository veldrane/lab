#!/bin/bash

MAC=`hexdump -vn3 -e '/3 "52:54:00"' -e '/1 ":%02x"' -e '"\n"' /dev/urandom`
NUM=$1

if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit 1
fi

virsh net-destroy default
virsh net-autostart --disable default


echo "MACADDR=${MAC}" > /etc/sysconfig/virbr${NUM}-dummy

cat << EOF | sed s/XXX/${NUM}/g > /etc/sysconfig/network-scripts/virbr${NUM}
DEVICE="virbrXXX"
ONBOOT="yes"
TYPE=Bridge
IPADDR=10.1.XXX.1
NETMASK=255.255.255.0
BOOTPROTO=static
NM_CONTROLED="no"
EOF

cat << EOF | sed s/XXX/${NUM}/g | sed s/YYY/${MAC}/g > /etc/sysconfig/network-scripts/virbr${NUM}-dummy
DEVICE="virbrXXX-dummy"
MACADDR=YYY
ONBOOT=yes
TYPE=Dummy
NM_CONTROLLED=no
BRIDGE=virbrXXX
EOF

ifup virbr${NUM}

systemctl daemon-reload
systemctl enable dummy@virbr${NUM}.service
systemctl start dummy@virbr${NUM}.service

virsh net-undefine virbr${NUM} 

cat << EOF | sed s/XXX/${NUM}/g > /tmp/virbr${NUM}.xml
<network>
  <name>virbrXXX</name>
  <forward mode="bridge"/>
  <bridge name="virbrXXX" />
</network>
EOF

virsh net-define /tmp/virbr${NUM}.xml
virsh net-autostart --network virbr${NUM}
virsh net-start virbr${NUM}
rm -f /tmp/virbr${NUM}.xml
