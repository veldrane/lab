#!/bin/sh
i=1
while [ "$i" -ne 5 ]
do
    echo "node2$i.lab.local"
    cat include/_setup_vars.template | sed s/XXX/$i/g > include/_setup_vars.yaml
    ansible-playbook ./01_prepare_nodes.yaml    
    i=$((i + 1))
done
