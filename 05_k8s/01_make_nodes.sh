#!/bin/sh

#echo "Creating master..."

#i=71
#while [ "$i" -ne 72 ]
#do
#    echo "node$i.lab.local"
#    cat ansible/include/_setup_vars.template | sed s/XXX/$i/g > ansible/include/_setup_vars.yaml
#    ansible-playbook ansible/01_prepare_nodes.yaml
#    if [ $? -eq 1 ]; then
#    	exit 1
#    fi
#    ansible-playbook ansible/02_install_master.yaml
#    i=$((i + 1))
#done

#sleep 60

echo "Creating nodes..."

i=86
while [ "$i" -ne 89 ]
do
    echo "node$i.lab.local"
    arp -da 10.1.16.200
    cat ansible/include/_setup_vars.template | sed s/XXX/$i/g > ansible/include/_setup_vars.yaml
    ansible-playbook ansible/01_prepare_nodes.yaml
    if [ $? -eq 1 ]; then
       exit 1
    fi
    ansible-playbook ansible/03_install_nodes.yaml
    i=$((i + 1))
done
