#!/bin/bash
mkdir /data/vms/freeipa.lab.local
virt-clone --original-xml /data/templates/t_centos7/t_centos7.xml --name freeipa.lab.local --file /data/vms/freeipa.lab.local/rootvg.qcow2
virsh setmaxmem freeipa.lab.local 2G --config
virsh setmem freeipa.lab.local 2G --config
virsh autostart freeipa.lab.local
virsh start freeipa.lab.local
