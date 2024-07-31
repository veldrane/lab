virt-clone --original rocky9 --name basevm -f /data/vms/templates/basevm.qcow2 
w=$(virt-sysprep --list-operations | egrep -v 'fs-uuids|lvm-uuids|ssh-userdir|ssh-hostkeys|bash-history' | awk '{ printf "%s,", $1}' | sed 's/,$//')
virt-sysprep -d basevm --hostname basevm --enable $w
#cp /data/vms/basevm.qcow2 /data/templates/basevm.qcow2
#virsh dumpxml basevm > /data/vms/templates/basevm.xml
virsh undefine basevm
