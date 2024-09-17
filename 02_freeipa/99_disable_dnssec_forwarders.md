## https://www.freeipa.org/page/V4/DNSSEC_Support

It is necessary to add:

```
options {
    dnssec-validation no;
}
```

to named configuration of ip. Without that dsn resolving for external hosts wont work properly

ALso is necessary to allow recursive query for other vlans:

https://serverfault.com/questions/1078706/freeipa-external-dns-requests-google-etc-fail-for-clients-on-new-subnet


```/etc/named/ipa-ext.conf
acl "trusted_network" {
 127.0.0.1;
 192.168.1.0/24; 
 10.1.0.0/16; 
};
```
