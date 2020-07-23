#! /bin/bash

QEMUPATH=/usr/local/qemu-5.0.0
MACHINE=$1

[[ -z $1 ]] && exit 1

mkdir /data/vms/$MACHINE
cp /data/templates/debian-arm64/* /data/vms/$MACHINE/
$QEMUPATH/bin/qemu-img create -f qcow2 /data/vms/$MACHINE/root.qcow2 8G
$QEMUPATH/bin/qemu-system-aarch64 -M virt -m 4096 -cpu cortex-a72 \
  -kernel /data/vms/$MACHINE/install-kernel \
  -initrd /data/vms/$MACHINE/install-initrd.gz \
  -drive if=none,file=/data/vms/$MACHINE/root.qcow2,format=qcow2,id=hd \
  -device virtio-blk-pci,drive=hd \
  -netdev user,id=virbr16 \
  -device virtio-net-pci,netdev=virbr16 \
  -nographic -no-reboot