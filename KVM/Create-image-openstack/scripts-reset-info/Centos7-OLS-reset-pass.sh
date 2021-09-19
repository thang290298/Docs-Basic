#!/bin/bash
# Openlitespeed reset password
# ThangNV NhanHoa Cloud Team
# Get info mysql_root_passwd
old_passwd_mysl=0435626533aA
# Input from cloud-init
new_passwd_1=$1
new_passwd_2=$2
# Input from random
# new_passwd_1=$(date +%s | sha256sum | base64 | head -c 16 ; echo)
# Change password
mysqladmin --user=root --password=$old_passwd_mysl password $new_passwd_1
echo -e "admin\n$new_passwd_2\n$new_passwd_2" | /usr/local/lsws/admin/misc/admpass.sh
sed -i "s|NjZkYWIw|$new_passwd_2|g" /usr/local/lsws/adminpasswd
sed -i "s|0435626533aA|$new_passwd_2|g" /usr/local/lsws/password
# Restart Openlitespeed
systemctl restart lsws
systemctl restart mysqld
# DONE