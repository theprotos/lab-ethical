#!/bin/bash

#echo -e "  --> Update packages"
#rm -f /var/cache/yum/timedhosts.txt
#time yum update -q -y --setopt=tsflags=noscripts
#apt-get update -qqy

echo -e "  --> Install packages+"
time yum install net-tools -qqy&
#apk add iptables

echo -e "  --> Iptables config"
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
