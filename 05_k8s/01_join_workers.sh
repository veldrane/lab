#!/bin/sh

echo "Joining nodes to existing cluster..."

i=23
while [ "$i" -ne 25 ]
do
    echo "node$i.lab.local"
    arp -da 10.1.16.200
    rm -rf /root/.ansible/cp/*
    rm -rf /root/.ansible/tmp/*
    cat ansible/include/_setup_vars.template | sed s/XXX/$i/g > ansible/include/_setup_vars.yaml
#    ansible-playbook ansible/01_prepare_nodes.yaml
#    if [ $? -eq 1 ]; then
#       exit 1
#    fi
    ansible-playbook ansible/03_install_nodes.yaml
    i=$((i + 1))
done
