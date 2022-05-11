#!/usr/bin/bash

echo -e "  --> SSH enable password login"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

echo -e "  --> Update packages"
time apt-get update -qqy

echo -e "  --> Install packages"
time DEBIAN_FRONTEND=noninteractive apt-get install policycoreutils acl -qqy --fix-missing

echo -e "  --> Add users"
useradd -m user -s /bin/bash || true

echo -e "  --> Bootstrap completed"
