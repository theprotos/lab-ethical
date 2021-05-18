#!/usr/bin/bash

#echo -e "  --> Update packages"
#time yum update -q -y --setopt=tsflags=noscripts

echo -e "  --> Install packages+"
time yum install net-tools -qqy&

echo -e "  --> SSH enable password login"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

echo -e "  --> Shutdown eth0+"
ip -force link set dev eth0 down&
#ifconfig eht0 down

echo -e "  --> Setup eth1+"
ip addr replace 192.168.100.102 dev eth1&
#ip route replace 192.168.100.0/24 via 192.168.100.10 dev eth1

echo -e "  --> Setup default gateway+"
ip route replace default via 192.168.100.10&
