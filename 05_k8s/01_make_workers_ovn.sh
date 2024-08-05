#!/bin/sh

echo "Creating nodes..."

i=22
while [ "$i" -ne 23 ]
do
    echo "ovn$.lab.local"
    arp -da 10.1.16.200
    rm -rf /root/.ansible/cp/*
    rm -rf /root/.ansible/tmp/*
    cat ansible/include/_setup_vars.ovn.template | sed s/XXX/$i/g > ansible/include/_setup_vars.yaml
    #ansible-playbook ansible/01_prepare_nodes.yaml
    if [ $? -eq 1 ]; then
       exit 1
    fi
    ansible-playbook ansible/03_install_nodes_ovn.yaml
    i=$((i + 1))
done
