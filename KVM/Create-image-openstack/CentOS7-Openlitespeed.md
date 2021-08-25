# Tài liệu đóng Image CentOS7 + Openlitespeed

## Các thành phần chính

- Openlitespeed
- Mariadb
- PHP 8.0
- phpMyAdmin
- LiteSpeed Cache
- Memcached
- Redis
- Certbort
- Postfix

***Lưu ý***: Sử dụng version mới nhất

## Bước 1: Trên KVM host tạo máy ảo CentOS7

### 1. Khởi tạo ổ cứng sử dụng cho máy ảo:

<img src = "..\Images\Centos7-app\1.png">
<img src = "..\Images\Centos7-app\2.png">
<img src = "..\Images\Centos7-app\3.png">
<img src = "..\Images\Centos7-app\4.png">

### 2. thực hiện khởi tạo VM
-  `Instances` -> `+` sau đó thực hiện các bước khởi tạo sau: 
<img src = "..\Images\Centos7-app\5.png">
<img src = "..\Images\Centos7-app\6.png">

  - Lựa chọn `Custom` và điền các thông tin: Name, VCPU, RAM, HDD, Network rồi chọn `Create`:
<img src = "..\Images\Centos7-app\7.png">
- Mount ISO tiến hành cài đặt OS
<img src = "..\Images\Centos7-app\8.png">
- chỉnh lại thứ tự boot
<img src = "..\Images\Centos7-app\9.png">

### 3. Tạo `Snapshots` trước khi cài đặt OS
<img src = "..\Images\Centos7-app\12.png">

### 4. Bật máy ảo và Console vào để cài đặt OS

<img src = "..\Images\Centos7-app\10.png">
<img src = "..\Images\Centos7-app\11.png">

## Bước 2: Cài Đặt Centos 7

### 1. Cài đặt OS
- Chọn `Install CentOS7` để tiến hành cài đặt 

![](../Images/create-image-Centos7-WP-LAMP/1.png)


- Cấu hình ngôn ngữ chọn `English(English)`

![](../Images/create-image-Centos7-WP-LAMP/2.png)

- Cấu hình timezone về Ho_Chi_Minh

![](../Images/create-image-Centos7-WP-LAMP/3.png)

![](../Images/create-image-Centos7-WP-LAMP/4.png)

- Cấu hình disk để cài đặt 

![](../Images/create-image-Centos7-WP-LAMP/5.png)

![](../Images/create-image-Centos7-WP-LAMP/6.png)

- Chọn `Standard Partition` cho ổ disk 

![](../Images/create-image-Centos7-WP-LAMP/7.png)

- Cấu hình mount point `/` cho toàn bộ disk

![](../Images/create-image-Centos7-WP-LAMP/8.png)

- Định dạng lại `ext4` cho phân vùng

![](../Images/create-image-Centos7-WP-LAMP/9.png)

![](../Images/create-image-Centos7-WP-LAMP/10.png)

- Kết thúc quá trình cấu hình disk 

![](../Images/create-image-Centos7-WP-LAMP/11.png)

- Confirm quá trình chia lại partition cho disk 

![](../Images/create-image-Centos7-WP-LAMP/12.png)

- Cấu hình network 

![](../Images/create-image-Centos7-WP-LAMP/13.png)

- Turn on network cho interface và set hostname

![](../Images/create-image-Centos7-WP-LAMP/14.png)

- Kết thúc cấu hình, bắt đầu quá trình cài đặt OS

![](../Images/create-image-Centos7-WP-LAMP/15.png)

- Setup passwd cho root

![](../Images/create-image-Centos7-WP-LAMP/16.png)


![](../Images/create-image-Centos7-WP-LAMP/17.png)


- Reboot lại VM sau khi cài đặt hoàn tất

![](../Images/create-image-Centos7-WP-LAMP/18.png)

### 2. Chỉnh sửa file XML VM Lưu ý:

- Chỉnh sửa file .xml của máy ảo, bổ sung thêm channel trong (để máy host giao tiếp với máy ảo sử dụng qemu-guest-agent), sau đó save lại

Truy cập Settings > XML > EDIT SETTINGS

<img src = "..\Images\Centos7-app\13.png">

Nếu đã tồn tại channel đổi port channel này về port='2' và add channel bình thường

![](../Images/create-image-ubuntu20.04/29.png)

Định dạng
```shsh
<devices>
<channel type='unix'>
    <target type='virtio' name='org.qemu.guest_agent.0'/>
    <address type='virtio-serial' controller='0' bus='0' port='1'/>
</channel>
</devices>
```
## Bước 2: Cài đặt môi trường

### 1. Cấu hình và cài đặt các gói
Cài đặt `epel-release` và update
```sh
yum install epel-release -y
yum update -y
yum install -y wget
```

### 2. Disable firewalld, SElinux
```sh
systemctl disable firewalld
systemctl stop firewalld

sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config
```

Reboot kiểm tra lại firewalld và SElinux

### 3. Cấu hình Network
Disable NetworkManager, sử dụng network service
```sh
systemctl disable NetworkManager
systemctl stop NetworkManager
systemctl enable network
systemctl start network
```

Disable IPv6:
```sh
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p
```

Kiểm tra
```sh
cat /proc/sys/net/ipv6/conf/all/disable_ipv6
```

Lưu ý: Kết quả ra `1` => Tắt thành công, `0` tức IPv6 vẫn bật

### 4. Cấu hình SSH
```sh
sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g' /etc/ssh/sshd_config 
sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config 
systemctl restart sshd
```

### 5. Điều chỉnh timezone
Đổi timezone về `Asia/Ho_Chi_Minh`
```sh
timedatectl set-timezone Asia/Ho_Chi_Minh
```
### 6. Cài đặt chronyd
```sh
yum install chrony -y
sed -i 's|server 1.vn.pool.ntp.org iburst|server 162.159.200.123 iburst|g' /etc/chrony.conf
systemctl enable --now chronyd 
hwclock --systohc
```

### 7. Cấu hình console và network

Để sử dụng nova console-log, bạn cần thay đổi option cho `GRUB_CMDLINE_LINUX` và lưu lại 

```sh sh
sed -i 's/GRUB_CMDLINE_LINUX="crashkernel=auto rhgb quiet"/GRUB_CMDLINE_LINUX="crashkernel=auto console=tty0 console=ttyS0,115200n8"/g' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
```


- Disable Default routing

```sh sh
echo "NOZEROCONF=yes" >> /etc/sysconfig/network
```

- Xóa thông tin card mạng
```sh sh
rm -f /etc/sysconfig/network-scripts/ifcfg-eth0
```

- Để sau khi boot máy ảo, có thể nhận đủ các NIC gắn vào:

```shsh 
cat << EOF >> /etc/rc.local
for iface in \$(ip -o link | cut -d: -f2 | tr -d ' ' | grep ^eth)
do
   test -f /etc/sysconfig/network-scripts/ifcfg-\$iface
   if [ \$? -ne 0 ]
   then
       touch /etc/sysconfig/network-scripts/ifcfg-\$iface
       echo -e "DEVICE=\$iface\nBOOTPROTO=dhcp\nONBOOT=yes" > /etc/sysconfig/network-scripts/ifcfg-\$iface
       ifup \$iface
   fi
done
EOF
```

- Thêm quyền thực thi cho file `/etc/rc.local`
```sh
chmod +x /etc/rc.local 
```

- Xóa file hostname

```sh sh
rm -f /etc/hostname
```

### 8. Tạo Snapshot Begin

## Bước 3: Cài đặt APP
### 1. Cài đăt OpenLiteSpeed + PHP 8.0 + Mariadb
#### 1.1 OpenLiteSpeed
- Add the Repository
```sh
rpm -Uvh http://rpms.litespeedtech.com/centos/litespeed-repo-1.1-1.el7.noarch.rpm
```
- Install OpenLiteSpeed
```sh
yum install openlitespeed
```
- khởi động OpenLiteSpeed
```sh
systemctl start lsws
systemctl enable lsws
systemctl status lsws
```
#### 1.2. Cài đăt PHP 8.0

- Add Remi Repository
```sh
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm
```
- Install PHP 8.0
```sh
yum install -y --enablerepo=remi-php80 php php-cli
sudo yum install lsphp80 lsphp80-mysql lsphp80-common lsphp80-opcache lsphp80-curl
```

- Install PHP Extensions

```sh
yum -y install lsphp80-mysqlnd lsphp80-gd lsphp80-process lsphp80-mbstring lsphp80-xml lsphp80-pdo lsphp80-imap lsphp80-soap lsphp80-bcmath lsphp80-zip
```

- check version
```sh
[root@localhost ~]# php -v
PHP 8.0.10 (cli) (built: Aug 24 2021 15:40:40) ( NTS gcc x86_64 )
Copyright (c) The PHP Group
Zend Engine v4.0.10, Copyright (c) Zend Technologies
```
#### 1.3 Install MariaDB 10.6.4
- update packages
```
yum install upgrade -y
```
Mặc định, repo cài đặt MariaDB trên CentOS-7 là phiên bản 5.x. Vì vậy, để cài đặt bản mới cần chỉnh sửa repo cài MariaDB (phiên bản 10.6.4 - Stable)
```sh
vi /etc/yum.repos.d/MariaDB.repo
```
- Nội dung
```
# MariaDB 10.6 CentOS repository list - created 2021-08-04 11:35 UTC
# http://downloads.mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.6/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
```
- Cài đặt MariaDB:
```
yum install MariaDB-server MariaDB-client -y
```
- Khởi động Mariadb service:
```
systemctl start mariadb
systemctl enable mariadb
```
- Disable unix_socket authentication: Thêm đoạn sau vào file /etc/my.cnf
```
[mariadb]
unix_socket=OFF
```
- Cài đặt 1 số thông tin ban đầu:
```
sudo mysql_secure_installation

```
  - Tiến hành lựa chọn giống như sau
```
Enter current password for root (enter for none): Nhấn phím Enter
Switch to unix_socket authentication [Y/n]: n
Change the root password? [Y/n]: Y
New password: Nhập password root các bạn muốn tạo
Re-enter new password: Nhập lại password root
Remove anonymous users? [Y/n] : Y
Disallow root login remotely? [Y/n]: Y
Remove test database and access to it? [Y/n] : Y
Reload privilege tables now? [Y/n]: Y
```

#### 1.4 Configuretion OpenliteSpeed

- trang quản trị OpenliteSpeed hoạt động trên port **7080** tiến hành allow port firewalld
```
firewall-cmd --add-port=7080/tcp --permanent
firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --add-port=443/tcp --permanent
firewall-cmd --reload
```
- thay đổi port truy cập website từ **8088** sang port **80**. sửa file: `/usr/local/lsws/conf/httpd_config.conf`

<img src = "..\Images\Centos7-app\15.png">

- Set admin console password :
```
cd /usr/local/lsws/admin/misc
sh admpass.sh
```
<img src = "..\Images\Centos7-app\14.png">

- Thay đổi PHP version in openlitespeed
  - chỉnh sửa file `/usr/local/lsws/conf/httpd_config.conf`
```
thay thế: `$SERVER_ROOT/lsphp73/bin/lsphp`
bằng: `$SERVER_ROOT/lsphp80/bin/lsphp`
```
truy cập kiểm tra:
  - giao diện WebAdmin: http://IPserver:7080/
  account: admin
  pass: 0435626533aA
<img src = "..\Images\Centos7-app\16.png">
  - truy cập trang web: http://IPserver

<img src = "..\Images\Centos7-app\17.png">

  - kiểm tra phiển bản php8.0
  
<img src = "..\Images\Centos7-app\18.png">