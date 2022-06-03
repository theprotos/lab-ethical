#!/usr/bin/bash

#libs
ls -al /lib/security
ls -al /lib64/security

ls -al /etc/pam.conf
ls -al /etc/pam.d

cat /etc/security/time.conf
yum install pam_script

man pam_namespace
