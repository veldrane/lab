#!/bin/sh

echo "Creating nodes..."

i=52
while [ "$i" -ne 53 ]
do
    echo "ovn$i.lab.syscallx86.com"
    rm -rf /root/.ansible/cp/*
    rm -rf /root/.ansible/tmp/*
    cat ansible/include/_setup_vars.ovn.template | sed s/XXX/$i/g > ansible/include/_setup_vars.yaml
    #ansible-playbook ansible/01_prepare_nodes_ovn.yaml
    if [ $? -eq 1 ]; then
    	exit 1
    fi
    #ansible-playbook ansible/02_prepare_master.yaml
    #ansible-playbook ansible/02_install_master_ovn_crio.yaml
    #ansible-playbook ansible/03_install_nodes_ovn_crio_network.yaml
    ansible-playbook ansible/03_install_nodes_k8s.yaml
    i=$((i + 1))
done
