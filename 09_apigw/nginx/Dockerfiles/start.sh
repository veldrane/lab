#!/bin/bash
export RESOLVER=`cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`
cat /etc/nginx/templates/fortuna.conf | sed -E "s/XXXXX/$RESOLVER/g" > /etc/nginx/conf.d/fortuna.conf
"${NGINXCMD[@]}"
