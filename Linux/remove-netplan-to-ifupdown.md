# Hướng dẫn đặt IP tĩnh bằng ifupdown trên Ubuntu server 20.04

## Disable Netplan

tắt `netplan`
```
echo 'GRUB_CMDLINE_LINUX = "netcfg/do_not_use_netplan = true"' >>  /etc/default/grub
```
Cập nhật lại grub:

```
update-grub
```
## Cài đặt ifupdown thay thế netplan

Cài đặt ifupdown :
```
apt-get update
apt-get install -y ifupdown
```
## Xóa Netplan khỏi hệ thống

Xóa bỏ netplan khỏi hệ thống:
```
apt-get --purge remove netplan.io
```
Nếu bạn chưa cài đặt ifupdown, khi xóa bỏ netplan hệ thống sẽ tự cài đặt ifupdown thay thế cho bạn.
Sau đó ta xóa toàn bộ cấu hình của netplan:
```
rm -rf /usr/share/netplan
rm -rf /etc/netplan
```
## Cấu hình interface
File cấu hình interface: `vi /etc/network/interfaces`

Kiểm tra IP của máy. Ở đây interface là ens33, và đang là IP động.

<img src="https://image.prntscr.com/image/_ikg1cbOR7i6Axby7WIiGA.png">

Chỉnh sửa file cấu hình:
```
vim /etc/network/interfaces
```
Thêm các dòng sau vào file cấu hình:
```
auto lo
iface lo inet loopback

auto ens33
iface ens33 inet static
address 192.168.18.192
netmask 255.255.255.0
gateway 192.168.18.2
broadcst 192.168.18.255
dns-nameservers 8.8.8.8 8.8.4.4
dns-search lan
```

<img src="https://image.prntscr.com/image/BbdahOE3QbmEhoQycot6dg.png">

*Chú ý*: Cần xác định đúng tên interface và các thông số về IP của bạn.
Reboot hệ thống để IP được nhận.
```
reboot
```
## Kiểm tra kết nối mạng
Sau khi máy reboot. Ta kiểm tra lại IP đã đặt

<img src="https://image.prntscr.com/image/5QnHpNbWQjunsIDG3cOVLw.png">

Ping tới IP server Google:
```
ping 8.8.8.8
```
<img src="https://image.prntscr.com/image/D9p-qHagS7aalJWv6p2rTw.png">


## Sửa lỗi không ping được tên miền
Ta ping tới địa chỉ google.com:
```
ping google.com
```
Xuất hiện lỗi: Temporary failure in name resolution như hình dưới.
<img src="https://image.prntscr.com/image/RrgC_dtYRWqSy6q9y7hTmg.png">

Để xử lí lỗi này, ta làm theo các bước sau:
  - Disable `systemd-resolved` service.
```
systemctl disable systemd-resolved.service
```
  - Stop service
```
systemctl stop systemd-resolved.service
```
  - Bỏ link giữa 2 file sau: /run/systemd/resolve/stub-resolv.conf và /etc/resolv.conf bằng cách xóa file /etc/resolv.conf
```
rm /etc/resolv.conf
```
  - Tạo mới file /etc/resolv.conf
```
vim /etc/resolv.conf
```
   - Mở file và thêm DNS server mà bạn sử dụng:


```
nameserver 8.8.8.8
```
Kiểm tra lại: ping google.com . Ta thấy đã có thể ping bình thường.

<img src="https://image.prntscr.com/image/z2cJO31MT3a_Dljbu7ze5A.png">

# Nguồn tham khảo

https://news.cloud365.vn/ubuntu-huong-dan-dat-ip-tinh-bang-ifupdown-tren-ubuntu-server-20-04-ban-develop/

