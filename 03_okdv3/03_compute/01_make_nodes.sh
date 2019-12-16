#!/bin/sh
i=1
while [ "$i" -ne 5 ]
do
    echo "node2$i.lab.local"
    mkdir /vms/node2$i.lab.local
    virt-clone --original-xml /vms/templates/centos-7.6/centos-7.6.xml --name node2$i.lab.local --file /vms/node2$i.lab.local/rootvg.qcow2
    cat include/_setup_vars.template | sed s/XXX/$i/g > include/_setup_vars.yaml
    virsh setmaxmem node2$i.lab.local 8G --config
    qemu-img resize /vms/node2$i.lab.local/rootvg.qcow2 +20G
    ansible-playbook ./01_prepare_nodes.yaml    
    i=$((i + 1))
done
