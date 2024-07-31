#!/bin/sh

# This script is just creating master without kubeadm and post instalation phase


echo "Creating master..."

i=11
while [ "$i" -ne 12 ]
do
    echo "node$i.lab.syscallx86.com"
    rm -rf /root/.ansible/cp/*
    rm -rf /root/.ansible/tmp/*
    cat ansible/include/_setup_vars.template | sed s/XXX/$i/g > ansible/include/_setup_vars.yaml
    #ansible-playbook ansible/01_prepare_nodes.yaml
    if [ $? -eq 1 ]; then
    	exit 1
    fi
    #ansible-playbook ansible/02_prepare_master.yaml
    ansible-playbook ansible/02_install_master_antrea_crio.yaml
    i=$((i + 1))
done
