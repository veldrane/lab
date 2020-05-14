#!/bin/bash

QEMUPATH=/usr/local/qemu-5.0.0
MACHINE=$1

$QEMUPATH/bin/qemu-system-aarch64 \
  -M virt \
  -cpu cortex-a53 \
  -m 1024 \
  -hda /data/vms/$MACHINE/2020-02-13-raspbian-buster.img \
  -net user,hostfwd=tcp::5022-:22 \
  -serial stdio \
  -kernel /data/vms/$MACHINE/kernel-qemu-4.19.50-buster \
  -append 'root=/dev/sda2 panic=1' \
  -vnc 0.0.0.0:10 \
  -no-reboot


  #$QEMUPATH/bin/qemu-system-arm \
  #-M versatilepb \
  #-cpu arm1176 \
  #-m 256 \
  #-hda /data/vms/$MACHINE/2020-02-13-raspbian-buster.img \
  #-net user,hostfwd=tcp::5022-:22 \
  #-serial stdio \
  #-dtb /data/vms/$MACHINE/versatile-pb-buster.dtb \
  #-kernel /data/vms/$MACHINE/kernel-qemu-4.19.50-buster \
  #-append 'root=/dev/sda2 panic=1' \
  #-vnc 0.0.0.0:10 \
  #-no-reboot