#! /bin/bash

QEMUPATH=/usr/local/qemu-5.0.0
MACHINE=$1

[[ -z $1 ]] && exit 1

$QEMUPATH/bin/qemu-system-aarch64 -M virt -m 4096 -cpu cortex-a72 \
  -kernel /data/vms/$MACHINE/vmlinuz-4.9.0-12-arm64 \
  -initrd /data/vms/$MACHINE/initrd.img-4.9.0-12-arm64 \
  -append 'root=/dev/vda2' \
  -drive if=none,file=/data/vms/$MACHINE/root.qcow2,format=qcow2,id=hd \
  -device virtio-blk-pci,drive=hd \
  -netdev user,id=virbr16 \
  -device virtio-net-pci,netdev=virbr16 \
  -nographic -no-reboot