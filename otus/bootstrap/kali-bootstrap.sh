#!/usr/bin/bash

echo -e "  --> Update packages"
time apt-get update -qqy

echo -e "  --> Install packages"
time DEBIAN_FRONTEND=noninteractive apt-get install amass dnsmap mc httrack wget -qqy --fix-missing

echo -e "  --> Bootstrap completed"
