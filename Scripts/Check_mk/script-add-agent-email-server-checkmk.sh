#!/bin/bash
# Add Agent Check_mk
# ThangNV

echo "---- Update OS ----"

curl -sSL https://raw.githubusercontent.com/nhanhoadocs/scripts/master/Utilities/update_sudo_CVE-2021-3156.sh| bash
yum install wget -y
systemctl stop iptables 
systemctl disable iptables
systemctl stop httpd
systemctl disable httpd
systemctl stop firewalld
systemctl disable firewalld
systemctl stop sendmail
systemctl disable sendmail
echo "---- Done Update OS ----"
sleep 3
echo "---- Download Agent Check_MK 1.5.0p22-1 && setup ---- "
wget http://203.162.79.139/monitor/check_mk/agents/check-mk-agent-1.5.0p22-1.noarch.rpm
chmod +x check-mk-agent-1.5.0p22-1.noarch.rpm
rpm -ivh check-mk-agent-1.5.0p22-1.noarch.rpm
echo "---- Done Download Agent Check_MK 1.5.0p22-1 && setup ---- "
sleep 3
echo "---- Cai dat xinetd ----"
yum install xinetd -y
systemctl start xinetd
systemctl enable xinetd
sed -i "s|#only_from      = 127.0.0.1 10.0.20.1 10.0.20.2|only_from      = 203.162.79.139|g" /etc/xinetd.d/check_mk
systemctl restart xinetd
rm -rf check-mk-agent-1.5.0p22-1.noarch.rpm
echo "---- Agent Check_MK 1.5.0p22-1 finish ----"
sleep 3
echo "---- add mail queue ----"
yum install epel-release -y
yum install supervisor -y
cat << EOF >> /etc/mq.txt
[program:queue]
command=bash /usr/local/bin/send_queues.sh
EOF
cat /etc/mq.txt >>  /etc/supervisord.conf
wget https://raw.githubusercontent.com/gunnytian/tian/master/scripts/kerio/send_queues.sh -O /usr/local/bin/send_queues.sh && chmod +x /usr/local/bin/send_queues.sh
service supervisord start
systemctl enable supervisord.service 
rm -rf /etc/mq.txt
echo "---- Add Mail Queue finish ----"
sleep 3
echo "---- Cài đặt chronyd ----"
yum install chrony -y
sed -i 's|server 1.vn.pool.ntp.org iburst|server 162.159.200.123 iburst|g' /etc/chrony.conf
systemctl enable --now chronyd 
hwclock --systohc
echo "---- Cài đặt chronyd finish ----"
sleep 3
echo "---- check status  ----"
systemctl status xinetd
supervisorctl status
chkconfig --list | grep supervisord
date
echo "---- done  ----"