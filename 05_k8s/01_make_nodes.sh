#!/bin/sh

#echo "Creating master..."

#i=71
#while [ "$i" -ne 72 ]
#do
#    echo "node$i.lab.local"
#    cat ansible/include/_setup_vars.template | sed s/XXX/$i/g > ansible/include/_setup_vars.yaml
#    cd ansible
#    ansible-playbook ./01_prepare_nodes.yaml
#    i=$((i + 1))
#done

#cd ../

echo "Creating nodes..."

i=81
while [ "$i" -ne 85 ]
do
    echo "node$i.lab.local"
    cat ansible/include/_setup_vars.template | sed s/XXX/$i/g > ansible/include/_setup_vars.yaml
    cd ansible
    ansible-playbook ./01_prepare_nodes.yaml
    i=$((i + 1))
done
