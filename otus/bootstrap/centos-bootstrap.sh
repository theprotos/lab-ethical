#!/usr/bin/bash

echo -e "  --> SSH enable password login"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config && echo -e "\tset /etc/ssh/sshd_config [ OK ]"
systemctl reload sshd && echo -e "\treload sshd [ OK ]"

echo -e "  --> Install repos"
yum install yum epel-release -qqy && echo -e "\tepel \t[ OK ]"
yum repolist -qq && echo -e "\tupdate repos \t[ OK ]"

echo -e "  --> Install packages"
time yum install setroubleshoot-server net-tools nginx policycoreutils-python-utils -qqy && echo -e "\tinstalled \t[ OK ]"

echo -e "  --> Add users"
useradd -m user -s /bin/bash || true

echo -e "  --> Bootstrap completed"
