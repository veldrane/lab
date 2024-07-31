#!/bin/bash

SERVICE=$1

systemctl enable $1
systemctl start $1
