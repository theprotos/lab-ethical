#!/usr/bin/bash

echo -e "\n
#######################[ polkit ]#######################
#Create polkit rule to allow mount drives for otus user
#
#pkaction | grep disks
########################################################
"

echo -e "  --> Add users and set password"
groupadd otus
useradd -m otus0 -s /bin/bash -p otus || true
useradd -m otus1 -s /bin/bash -p otus || true
useradd -m otus2 -s /bin/bash -p otus || true

usermod -a -G otus otus0
usermod -a -G otus otus1
usermod -a -G otus otus2

echo -e "  --> Install packages"
yum install -qqy udisks2 mc policycoreutils-python-utils

echo -e "  --> Create polkit policies:"

echo -e "  -- --> 1) log detailed information about any requested access"
cat <<EOT > /etc/polkit-1/rules.d/00-log-access.rules
polkit.addRule(function(action, subject) {
    polkit.log("action=" + action);
    polkit.log("subject=" + subject);
});
EOT

echo -e "  -- --> 2) allow to mount for otus"
cat <<EOT > /etc/polkit-1/rules.d/10-udisks2.rules
// See the polkit(8) man page for more information
// about configuring polkit.

// Allow udisks2 to mount devices without authentication
// for users in the "wheel" group.
polkit.addRule(function(action, subject) {
    if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
         action.id == "org.freedesktop.udisks2.filesystem-mount") &&
        subject.isInGroup("otus") && subject.active) {
        return polkit.Result.YES;
    }
});
EOT

echo -e "  --> Create partition"
echo -e "  -- --> before"
lsblk -af

disk=/dev/sdb

sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${disk}
  o # create a new empty DOS partition table
  n # add new partition
  p # primary partition
  1 # partition number 1
    # First sector: default - start at beginning of disk
    # Last sector: default - end of disk
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF

echo -e "  -- --> after"
lsblk -af

mkfs.ext4 /dev/sdb1
#mkdir -p /mnt/disk
#mount /dev/sdb1 /mnt/disk
#df -h


#/var/log/auth.log
#/var/log/secure

echo -e "\n
#######################[ pam.d ]#######################
#use time_conf to disable ssh login from user otus2
#
#
########################################################
"

install authconfig

cat /etc/pam.d/sshd
session  required       pam_time.so

cat <<EOT > /etc/security/time.conf
#
login; tty* & !ttyp* ; !root & mislinux ; !Al0000-2400
sshd; *; damian; We0900-1500
EOT



/etc/security/pwquality.conf
minlen=7
dcredit=-1
ucredit=-1
ocredit=-1

### chroot
#настроить chroot для логине через ssh пользователю otus3

#* реализовать apparmor профайл для nginx согласно документации для виртуалки ubuntu
#https://docs.docker.com/engine/security/apparmor/


# create user namespace
#unshare --uts bash
#hostname demo

#unshare --fork --pid --mount-proc bash
#ping 8.8 >/dev/null &
