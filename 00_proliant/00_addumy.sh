#!/bin/bash

modprobe dummy
echo "dummy" > /etc/modules-load.d/dummy.conf
echo "options dummy numdummies=1" > /etc/modprobe.d/dummy.conf
