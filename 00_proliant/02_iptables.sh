cp include/iptables.save /etc/sysconfig/iptables
yum install -y iptables-services
systemctl enable iptables
systemctl start iptables
