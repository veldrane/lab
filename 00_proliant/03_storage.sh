#!/bin/bash

lvcreate -L+20G -n iso rootvg
lvcreate -L+100G -n vms rootvg

