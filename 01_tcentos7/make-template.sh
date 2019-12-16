#yum install -y virt-install
#yum install -y libguestfs-tools
virt-clone --original centos7 --name t_centos7 --auto-clone
w=$(virt-sysprep --list-operations | egrep -v 'fs-uuids|lvm-uuids|ssh-userdir|ssh-hostkeys|bash-history' | awk '{ printf "%s,", $1}' | sed 's/,$//')
virt-sysprep -d t_centos7 --hostname centos7 --enable $w
mv /data/vms/t_centos7.qcow2 /data/templates/t_centos7
virsh undefine t_centos7
