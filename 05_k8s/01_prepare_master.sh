#!/bin/sh

# This script is just creating master without kubeadm and post instalation phase


echo "Creating master..."

i=71
while [ "$i" -ne 72 ]
do
    echo "node$i.lab.local"
    rm -rf /root/.ansible/cp/*
    rm -rf /root/.ansible/tmp/*
    cat ansible/include/_setup_vars.template | sed s/XXX/$i/g > ansible/include/_setup_vars.yaml
    ansible-playbook ansible/01_prepare_nodes.yaml
    if [ $? -eq 1 ]; then
    	exit 1
    fi
    ansible-playbook ansible/02_prepare_master.yaml
    i=$((i + 1))
done
