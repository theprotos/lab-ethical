#!/usr/bin/bash

BASE_DIR="/home/vagrant"

useradd -m otus -s /bin/bash -p otus || true

mkdir permissions && cd permissions

touch test
chmod u=rwx,g+w,go-x test
rm -rf test

mkdir testdir && chmod u=x,g=,o= testdir
cd testdir

mkdir testdir1 && chmod u=w,g=,o= testdir1
rmdir testdir1

mkdir testdir2 && chmod u=xr,g=,o= testdir2
ls -al testdir2
cd testdir2

mkdir testdir3 && chmod u=wr,g=,o= testdir3
ls -al testdir3
rmdir testdir3

mkdir testdir4 && chmod u=wx,g=,o= testdir4
touch testdir4/test
cd testdir4
rm testdir4/test
rmdir testdir4

#===============
cd ~
mkdir acl && cd acl
touch test

setfacl -m u:vagrant:rw-,g:root:rw- testfile
mkdir testdir
setfacl -d -m u::rwx,g::-,o::-,u:someuser:rwx,u:somegroup:rwx testdir



find / -perm -u=s -type f 2>/dev/null
find / -perm -u=g -type d 2>/dev/null


#SUID
find / -perm -4000 2>/dev/null
#SGID
find / -perm -2000 2>/dev/null
#SUID+SGIT
find / -perm -6000 2>/dev/null

#anyone car write
find / -perm -0002 -type d 2>/dev/null

#sticky
find / -perm -1000 -type d 2>/dev/null

#no-user and no-group
find / -xdev \( -nouser -o -nogroup \) -print

#=================
cd ~
mkdir attr && cd attr
touch file
mkdir mydir

lsattr -a
chattr +i
chattr +s


