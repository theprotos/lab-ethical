#!/bin/bash

#echo -e "  --> Update packages"
#rm -f /var/cache/yum/timedhosts.txt
#time yum update -q -y --setopt=tsflags=noscripts
#apt-get update -qqy

echo -e "  --> Install packages+"
yum install net-tools -qqy
#apk add iptables

echo -e "  --> SSH enable password login"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

echo -e "  --> Iptables config"
echo 1 > /proc/sys/net/ipv4/ip_forward
echo 1 > /proc/sys/net/ipv4/conf/eth0/proxy_arp
echo 1 > /proc/sys/net/ipv4/conf/eth1/proxy_arp
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
#iptables --append FORWARD --in-interface eth1 -j ACCEPT
