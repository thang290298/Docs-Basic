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
```
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
```
yum install epel-release -y
yum update -y
yum install -y wget
```

### 2. Disable firewalld, SElinux
```
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
```
systemctl disable NetworkManager
systemctl stop NetworkManager
systemctl enable network
systemctl start network
```

Disable IPv6:
```
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p
```

Kiểm tra
```
cat /proc/sys/net/ipv6/conf/all/disable_ipv6
```

Lưu ý: Kết quả ra `1` => Tắt thành công, `0` tức IPv6 vẫn bật

### 4. Cấu hình SSH
```
sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g' /etc/ssh/sshd_config 
sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config 
systemctl restart sshd
```

### 5. Điều chỉnh timezone
Đổi timezone về `Asia/Ho_Chi_Minh`
```
timedatectl set-timezone Asia/Ho_Chi_Minh
```
### 6. Cài đặt chronyd
```
yum install chrony -y
sed -i 's|server 1.vn.pool.ntp.org iburst|server 162.159.200.123 iburst|g' /etc/chrony.conf
systemctl enable --now chronyd 
hwclock --systohc
```

### 7. Cấu hình console và network

Để sử dụng nova console-log, bạn cần thay đổi option cho `GRUB_CMDLINE_LINUX` và lưu lại 

``` sh
sed -i 's/GRUB_CMDLINE_LINUX="crashkernel=auto rhgb quiet"/GRUB_CMDLINE_LINUX="crashkernel=auto console=tty0 console=ttyS0,115200n8"/g' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
```


- Disable Default routing

``` sh
echo "NOZEROCONF=yes" >> /etc/sysconfig/network
```

- Xóa thông tin card mạng
``` sh
rm -f /etc/sysconfig/network-scripts/ifcfg-eth0
```

- Để sau khi boot máy ảo, có thể nhận đủ các NIC gắn vào:

```sh 
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

``` sh
rm -f /etc/hostname
```

### 8. Tạo Snapshot Begin

## Bước 3: Cài đặt APP
### 1. Cài đăt 

https://openlitespeed.org/kb/install-ols-from-litespeed-repositories/

