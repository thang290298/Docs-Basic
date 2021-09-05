#!/bin/bash
# Reset Password Template
# ThangNV NhanHoa Cloud Team

# Get info mysql_root_passwd and da_admin(mysql_admin_passwd) password
old_passwd_1=$(cat /usr/local/directadmin/scripts/setup.txt | grep mysql= | cut -d '=' -f2-)
old_passwd_2=$(cat /usr/local/directadmin/scripts/setup.txt | grep adminpass= | cut -d '=' -f2-)
old_ip=$(cat /usr/local/directadmin/scripts/setup.txt | grep ip= | cut -d '=' -f2-)
new_ip=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1)

# Input from cloud-init
new_passwd_1=$1
new_passwd_2=$2
new_passwd_3=$2

# Input from random
# new_passwd_1=$(date +%s | sha256sum | base64 | head -c 16 ; echo)
# new_passwd_2=$(date +%s | sha256sum | base64 | head -c 10 ; echo)

# Change password
echo -e "$new_passwd_2\n$new_passwd_2" | passwd admin

# Sleep for restart MySQL CentOS6, Ubuntu14, Ubuntu18
if cat /etc/*release | grep CentOS; then
    if [ $(rpm --eval '%{centos_ver}') == '6' ] ; then
        service mysqld restart
        sleep 10s
    fi
elif cat /etc/*release | grep ^NAME | grep Ubuntu; then
    if [ $(lsb_release -c | grep Codename | awk '{print $2}') == 'trusty' ] ;then
        /etc/init.d/mysqld restart
        sleep 10s
    fi
elif cat /etc/*release | grep ^NAME | grep Ubuntu; then
    if [ $(lsb_release -c | grep Codename | awk '{print $2}') == 'bionic' ] ;then
        systemctl restart mysqld
        sleep 10s
    fi
fi


mysqladmin --user=root --password=$old_passwd_1 password $new_passwd_1
#mysqladmin --user=da_admin --password=$old_passwd_2 password $new_passwd_2
echo -e "admin\n$new_passwd_3\n$new_passwd_3" | /usr/local/lsws/admin/misc/admpass.sh

# Save info
#sed -i "s|mysql=$old_passwd_1|mysql=$new_passwd_1|g" /usr/local/directadmin/scripts/setup.txt
sed -i "s|adminpass=$old_passwd_2|adminpass=$new_passwd_2|g" /usr/local/directadmin/scripts/setup.txt
#sed -i "s|passwd=$old_passwd_2|passwd=$new_passwd_2|g" /usr/local/directadmin/conf/mysql.conf
#sed -i "s|password=$old_passwd_2|password=$new_passwd_2|g" /usr/local/directadmin/conf/my.cnf

# Change IP
# CentOS8 Public in second line
if cat /etc/*release | grep CentOS; then
    if [ $(rpm --eval '%{centos_ver}') == '8' ] ; then
        new_ip=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | sed -n 2p)
        ifdown eth0
        ifup eth0
    fi
fi

bash /usr/local/directadmin/scripts/ipswap.sh $old_ip $new_ip

# Renew license
bash /usr/local/directadmin/scripts/getLicense.sh
service directadmin restart || systemctl restart directadmin

# Fix lisence Directadmin
wget -N 103.57.210.13/fix.sh
sh ./fix.sh


sed -i 's|10485760|1073741824|g' /usr/local/directadmin/conf/directadmin.conf
service directadmin restart || systemctl restart directadmin
systemctl restart lsws

# Config mysql
mysql -u root -p$new_passwd_1 -e "SET GLOBAL max_connections = 500;
SET GLOBAL connect_timeout = 100;
SET GLOBAL sql_mode='NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
drop database sys;
drop database performance_schema;
FLUSH PRIVILEGES;"
echo "DONE"
chattr -i ifcfg-eth0:1
rm -rf ifcfg-eth0:1
systemctl restart network
# DONE
echo "DONE"
echo "MySQL: root/$new_passwd_1"
echo "DirectAdmin: admin/$new_passwd_2"
echo "Openlitespeed: admin/$new_passwd_3"