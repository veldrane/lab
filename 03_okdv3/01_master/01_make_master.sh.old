#!/bin/sh
i=1
while [ "$i" -ne 2 ]
do
    echo "node1$i.lab.local"
    mkdir /data/vms/node1$i.lab.local
    virt-clone --original-xml /data/templates/t_centos7/t_centos7.xml --name node1$i.lab.local --file /data/vms/node1$i.lab.local/rootvg.qcow2
    cat include/_setup_vars.template | sed s/XXX/$i/g > include/_setup_vars.yaml
    virsh setmaxmem node1$i.lab.local 16G --config
    qemu-img resize /data/vms/node1$i.lab.local/rootvg.qcow2 +20G
    ansible-playbook ./01_prepare_master.yaml    
    i=$((i + 1))
done
