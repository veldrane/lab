#! /bin/bash
mkdir /data/vms/rasbpi.lab.local
cp /data/templates/raspbian/qemu-rpi-kernel/kernel-qemu-4.19.50-buster /data/vms/rasbpi.lab.local/
cp /data/templates/raspbian/qemu-rpi-kernel/versatile-pb-buster.dtb /data/vms/rasbpi.lab.local/
unzip /data/templates/raspbian/2020-02-13-raspbian-buster.zip -d /data/vms/rasbpi.lab.local