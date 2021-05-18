#!/usr/bin/bash

#echo -e "  --> Update packages"
#time apt-get update -qqy

echo -e "  --> Install packages"
time apt-get install terminator dsniff bettercap -qqy --fix-missing&

echo -e "  --> Shutdown eth0+"
ip -force link set dev eth0 down&
#ifconfig eth0 down

echo -e "  --> Setup eth1+"
ip addr replace 192.168.100.100 dev eth1&
#ip route replace 192.168.100.0/24 via 192.168.100.1 dev eth1 #onlink

echo -e "  --> Setup default gateway+"
ip route replace default via 192.168.100.10&

#route add default gw 192.168.0.1
#route add -net 192.168.100.0 netmask 255.255.255.0 gw 192.168.100.1
#exit 0