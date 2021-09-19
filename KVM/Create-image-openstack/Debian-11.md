# Hướng dẫn đóng Image debian 16.04 với cloud-init và QEMU Guest Agent( không dùng LVM)

## Chú ý:

- Hướng dẫn này dành cho các image không sử dụng LVM
- Sử dụng công cụ virt-manager hoặc web-virt để kết nối tới console máy ảo
- OS cài đặt KVM là Debian 11
- Phiên bản OpenStack sử dụng là Queens
- Hướng dẫn bao gồm 2 phần chính: thực hiện trên máy ảo cài OS và thực hiện trên KVM Host

## Phần 1: Tạo mới VM Debian 11 (WebvirtCloud)
### Bước 1: Tạo mới disk
<img src = "..\Images\debian11\1.png">

### Bước 2: Tạo mới VM với cấu hình 2 vCPU, 2 GB RAM
<img src = "..\Images\debian11\2.png">

### Bước 3: Mount bản cài Debian 11
<img src = "..\Images\debian11\3.png">

### Bước 4: Snapshot VM (NoOS)
<img src = "..\Images\debian11\4.png">

### Bước 5: Khởi động VM
<img src = "..\Images\debian11\5.png">

### Bước 6: Truy cập Console
<img src = "..\Images\debian11\6.png">

### Bước 7: Cài đặt Debian 11 với các lựa chọn như sau
- Chọn `Install`
<img src = "..\Images\debian11\7.png">

- Chọn `English`
<img src = "..\Images\debian11\8.png">
<img src = "..\Images\debian11\9.png">
<img src = "..\Images\debian11\10.png">
<img src = "..\Images\debian11\10.1.png">
<img src = "..\Images\debian11\10.2.png">
<img src = "..\Images\debian11\10.3.png">
<img src = "..\Images\debian11\10.4.png">

- Đặt `Hostname` và `domain`
  - Hostname
<img src = "..\Images\debian11\11.png">
  - Domain
<img src = "..\Images\debian11\12.png">

- Set `Password` user Root
<img src = "..\Images\debian11\13.png">

- Điền `Full name` thông tin `new user`
<img src = "..\Images\debian11\14.png">

- `Username` cho `new user`
<img src = "..\Images\debian11\15.png">

- Set `Password` user Root
<img src = "..\Images\debian11\16.png">

- Chia phân vùng disk
<img src = "..\Images\debian11\17.png">
<img src = "..\Images\debian11\18.png">
<img src = "..\Images\debian11\19.png">
<img src = "..\Images\debian11\20.png">
<img src = "..\Images\debian11\21.png">
<img src = "..\Images\debian11\22.png">
<img src = "..\Images\debian11\23.png">
<img src = "..\Images\debian11\24.png">
<img src = "..\Images\debian11\25.png">
<img src = "..\Images\debian11\26.png">
<img src = "..\Images\debian11\27.png">
<img src = "..\Images\debian11\28.png">
<img src = "..\Images\debian11\29.png">
<img src = "..\Images\debian11\30.png">
<img src = "..\Images\debian11\31.png">
### Bước 8: Tắt VM, chỉnh lại BOOT OPTION

<img src = "..\Images\debian11\32.png">

- Vào `Setting` chọn lại `Boot order`
  - Chỉnh sửa file .xml của máy ảo, bổ sung thêm channel trong (để máy host giao tiếp với máy ảo sử dụng qemu-guest-agent), sau đó save lại

  - Nội dung bổ sung: 
```
<devices>
 <channel type='unix'>
      <target type='virtio' name='org.qemu.guest_agent.0'/>
      <address type='virtio-serial' controller='0' bus='0' port='1'/>
 </channel>
</devices>
```
<img src = "..\Images\debian11\33.png">

### Bước 9: Truy cập VM, kiểm tra các dịch vụ

Kiểm tra dịch vụ SSH

![](../Images/create-image-debian20.04/25.png)


Lưu ý nếu dịch vụ SSH không khởi động được, thực hiện
```
sudo ssh-keygen -A
sudo systemctl restart sshd
```
<img src = "..\Images\debian11\34.png">

## Phần 2: Chuẩn bị môi trường Image Debian 11
### Bước 1: Thiết lập SSH
- Login ssh với tài khoản `debian`, chuyển user sudo
```
su - root
```
- Cấu hình cho phép ssh bằng user root /etc/ssh/sshd_config
```
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/'g /etc/ssh/sshd_config
service sshd restart
```
- Login lại bằng user root

- Xóa user debian
```
userdel debian
rm -rf /home/debian
```
- Bổ sung env locale
```
echo "export LC_ALL=C" >>  ~/.bashrc
```

- Disable firewalld
```
apt-get install sudo -y
sudo apt-get install ufw -y
systemctl disable ufw
systemctl stop ufw
systemctl status ufw
```
- Cài đặt Chronyd
```
apt install chrony -y
sed -i 's|pool 1.asia.pool.ntp.org offline iburst|pool 212.26.18.43 offline iburst|g' /etc/chrony/chrony.conf
service chrony restart
hwclock --systohc
```
### Bước 2: Disable ipv6
```
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf 
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf 
echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p
```
Kiểm tra
```
cat /proc/sys/net/ipv6/conf/all/disable_ipv6
```

### Bước 3: Cập nhật gói, update OS

```
apt-get update -y 
apt-get upgrade -y 
apt-get dist-upgrade -y
apt-get autoremove 
```
### Bước 4: Cài đặt trình soạn thảo VIM

```
apt-get install vim -y
```
### Bước 5: Cấu hình Card mạng và log console

Để sử dụng nova console-log, bạn cần thay đổi option cho `GRUB_CMDLINE_LINUX` và lưu lại 
```
sed -i 's|GRUB_CMDLINE_LINUX_DEFAULT="quiet"|GRUB_CMDLINE_LINUX_DEFAULT="console=tty0 console=ttyS0,115200n8"|g' /etc/default/grubsed -i 's|GRUB_CMDLINE_LINUX_DEFAULT=""|GRUB_CMDLINE_LINUX_DEFAULT="console=tty0 console=ttyS0,115200n8"|g' /etc/default/grub

update-grub
```

- Cấu hình để đổi name Card mạng về eth* thay vì ens, eno (Để scripts netplug chạy ổn định)
```
sed -i 's|GRUB_CMDLINE_LINUX=""|GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"|g' /etc/default/grub
```
- Lưu lại config
```
update-grub
```
- Reboot VM
```
init 6
```

- Cập nhật nameserver DNS tại file `/etc/resolv.conf`
```
nameserver 8.8.8.8
```

- Thực hiện restart network
```
/etc/init.d/networking restart 
```

## Phần 3: Cài đặt dịch vụ cần thiết cho Image Debian 11
### Bước 1: Cấu hình netplug

Để sau khi boot máy ảo, có thể nhận đủ các NIC gắn vào:
```
apt-get install netplug -y

wget https://raw.githubusercontent.com/danghai1996/thuctapsinh/master/HaiDD/CreateImage/scripts/netplug_debian -O netplug

mv netplug /etc/netplug/netplug

chmod +x /etc/netplug/netplug
```
- Xóa  thông tin MAC card mạng
```
echo > /lib/udev/rules.d/75-persistent-net-generator.rules
echo > /etc/udev/rules.d/70-persistent-net.rules
```
### Bước 2: Cài đặt qemu-agent

Chú ý: qemu-guest-agent là một daemon chạy trong máy ảo, giúp quản lý và hỗ trợ máy ảo khi cần (có thể cân nhắc việc cài thành phần này lên máy ảo)

Để có thể thay đổi password máy ảo bằng nova-set password thì phiên bản `qemu-guest-agent phải >= 2.5.0`

```
apt-get install software-properties-common -y
apt-get update -y
apt-get install qemu-guest-agent -y
service qemu-guest-agent start
```

Kiểm tra phiên bản qemu-ga bằng lệnh:
```
qemu-ga --version
service qemu-guest-agent status
```

### Bước 3: welcome Display và CMD Log
- welcome Display
```
wget https://raw.githubusercontent.com/danghai1996/create-images-openstack/master/scripts_all/linux-login.sh -O /etc/profile.d/linux-login.sh && chmod +x /etc/profile.d/linux-login.sh
```
Log out rồi login lại kiểm tra:
  - Log cmd: /var/log/cmdlog.log
  - Giao diện sau khi login:
      ```
    Welcome to Cloud365 | nhanhoa.com

    Tue 23 Mar 2021 03:04:17 PM +07

    ______ __                   __ _____  _____  ______
    / ____// /____   __  __ ____/ /|__  / / ___/ / ____/
    / /    / // __ \ / / / // __  /  /_ < / __ \ /___ \
    / /___ / // /_/ // /_/ // /_/ / ___/ // /_/ /____/ /
    \____//_/ \____/ \__,_/ \__,_/ /____/ \____//_____/

    * Trang chu NhanHoa : https://nhanhoa.com/
    * Cloud365          : https://cloud365.vn/
    * Portal            : https://portal.cloud365.vn/
    * Huong dan su dung : https://support.cloud365.vn/
    * Email ho tro      : support@nhanhoa.com

    *----------------------------------------------------*

    root@cloud:~# 
    ```

- CMD Log thực hiện theo tài liệu tại [đây](https://news.cloud365.vn/tools-log-all-command-of-user-in-linux/)


### Bước 4: Thiết lập gói cloud-init
- Cài đặt cloud-init
```
apt-get install cloud-utils cloud-initramfs-growroot cloud-init -y
```
- Cấu hình user mặc định
```
sed -i 's/name: debian/name: root/g' /etc/cloud/cloud.cfg
```
- Disable default config route
```
sed -i 's|link-local|#link-local|g' /etc/networks
```
- Clean cấu hình và restart service
```
cloud-init clean
systemctl restart cloud-init
systemctl enable cloud-init
systemctl status cloud-init
```
Lưu ý: Việc restart có thể mất 2-3 phút hoặc hơn (Nếu quá lâu có thể bỏ qua bước restart cloud-init)

### Bước 5: Xóa thông tin log CMD
```
apt-get clean all
rm -f /var/log/wtmp /var/log/btmp
> /var/log/cmdlog.log
history -c
```

## Phần 4. Tổi ưu và dẩy images

### Bước 1: Sử dụng lệnh virt-sysprep để xóa toàn bộ các thông tin máy ảo

```
virt-sysprep -d OPS_Template_Debian11
```

### Bước 2: Tối ưu kích thước image:
```
virt-sparsify --compress --convert qcow2 /var/lib/libvirt/images/OPS_Template_Debian11.qcow2 OPS_Template_Debian11
```

### Bước 3: Upload image lên glance và sử dụng
- trước tiên cần Coppy file images sang note Controller
- Convert images về định dạng raw
```
qemu-img convert -O raw OPS_Template_Debian11 OPS_Template_Debian11.raw
```
- Đẩy image lên hệ thống và sử dụng
```
glance image-create --name OPS_Template_Debian11 \
--file /root/image-create-ops-test/OPS_Template_Debian11.raw \
--disk-format raw \
--container-format bare \
--visibility=public \
--property hw_qemu_guest_agent=yes \
--min-disk 10 --min-ram 1024 --progress
```


### Bước 4: Nội dung cloud-init

```
#cloud-config
password: '{vps_password}'
chpasswd: { expire: False }
ssh_pwauth: True
```