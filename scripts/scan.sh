#!/usr/bin/bash

netdiscover -i eth0 -r 192.168.100.1/24

nmap -sn 192.168.100.1/24
nmap -T4 -F 192.168.100.1/24
nmap -sV -T4 -O -F --version-lihgt 192.168.100.1/24
