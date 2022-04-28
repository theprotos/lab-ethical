#!/usr/bin/bash

echo -e "  --> Update packages"
time apt-get update -qqy

echo -e "  --> Install packages"
time apt-get install mc httrack wget -qqy --fix-missing
