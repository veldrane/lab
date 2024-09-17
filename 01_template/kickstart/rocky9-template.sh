#!/bin/bash

KICKSTART="/root/lab/01_template/kickstart/kickstart.cfg"

mkdir -p /data/vms/rocky9

virt-install \
--name rocky9 \
--ram 2048 \
--vcpus 2 \
--disk bus=virtio,path=/data/vms/rocky9/rootvg.qcow2,format=qcow2,size=20 \
--os-variant rocky9 \
--network model=virtio,network=public \
--xml './devices/interface/vlan/tag/@id=8' \
--graphics none \
--location /data/iso/Rocky-9.4-x86_64-dvd.iso \
--initrd-inject=$KICKSTART \
--extra-args="inst.ks=file:/kickstart.cfg console=tty0 console=ttyS0,115200n8"
