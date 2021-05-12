#!/usr/bin/bash

echo -e "  --> Update packages"
apt-get update -qqy
apt-get install terminator -qqy

#route add default gw 192.168.0.1
#route add -net 192.168.100.0 netmask 255.255.255.0 gw 192.168.100.1