#### Introduction

Basic files related to ovn-kubernetes

#### Node config

```ovn11.lab.syscallx86.com

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master ovs-system state UP group default qlen 1000
    link/ether 52:54:00:ab:84:eb brd ff:ff:ff:ff:ff:ff
3: ovs-system: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether d6:c5:4e:86:9f:4a brd ff:ff:ff:ff:ff:ff
5: genev_sys_6081: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 65000 qdisc noqueue master ovs-system state UNKNOWN group default qlen 1000
    link/ether e2:f8:a8:44:72:e8 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::e0f8:a8ff:fe44:72e8/64 scope link 
       valid_lft forever preferred_lft forever
6: ovn-k8s-mp0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue state UNKNOWN group default qlen 1000
    link/ether 16:67:05:17:34:4d brd ff:ff:ff:ff:ff:ff
    inet 10.38.1.2/24 brd 10.38.1.255 scope global ovn-k8s-mp0
       valid_lft forever preferred_lft forever
7: br-int: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue state UNKNOWN group default qlen 1000
    link/ether ca:ef:76:3a:ce:3d brd ff:ff:ff:ff:ff:ff
8: br-ex: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
    link/ether 32:a1:53:6c:41:4c brd ff:ff:ff:ff:ff:ff
    inet 10.1.16.11/32 scope global noprefixroute br-ex
       valid_lft forever preferred_lft forever
    inet 169.254.169.2/29 brd 169.254.169.7 scope global br-ex
       valid_lft forever preferred_lft forever
    inet6 fe80::57b3:c74c:21f6:41ad/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
```

Just one ethernet interface, br-int has to be created manualy via "ovs-vsctl add-br br-int"

#### Important notes

- you have to explicitly enable egress features by adding env variable to ovnkube-master deployment

```
        - name: OVN_EGRESSIP_ENABLE
          value: "true"
```

- you have to disable ssl comunication on master, databases, and ovnkube-node daemon:


```
        - name: OVN_SSL_ENABLE
          value: "no"
```

It needs to be more investigation, root cause is probable self signed certificate generated by 