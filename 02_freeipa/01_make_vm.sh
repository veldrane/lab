#!/bin/bash
mkdir /data/vms/freeipa.lab.syscallx86.com
virt-clone --original-xml /data/vms/templates/basevm.xml --name freeipa.lab.syscallx86.com --file /data/vms/freeipa.lab.syscallx86.com/rootvg.qcow2
virsh setmaxmem freeipa.lab.syscallx86.com 2G --config
virsh setmem freeipa.lab.syscallx86.com 2G --config
virsh autostart freeipa.lab.syscallx86.com
virsh start freeipa.lab.syscallx86.com
