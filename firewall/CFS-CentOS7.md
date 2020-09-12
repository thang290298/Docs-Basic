# Tìm hiểu về CFS
## 1. Khái niệm CSF

CSF (ConfigServer & Firewall) là 1 gói ứng dụng hoạt động trên Linux như 1 Firewall được phát hành miễn phí để tăng tính bảo mật cho server (VPS và Dedicated). CSF hoạt động dựa trên iptables và tiến trình ldf để quyét các file log để phát hiện các dấu hiệu tấn công bất thường.

Một số công dụng của CSF:

- Chống DoS các loại.

- Chống Scan Port.

- Đưa ra các lời khuyên về việc cấu hình server (VD: 
Nên nâng cấp MySQL lên bản mới hơn).

- Chống BruteForce Attack vào ftp server, web server, mail server,directadmin,cPanel…

- Chống Syn Flood.

- Chống Ping Flood.

- Cho phép ngăn chặn truy cập từ 1 quốc gia nào đó bằng cách chỉ định Country Code chuẫn ISO.

- Hỗ trợ IPv6 và IPv4.

- Cho phép khóa IP tạm thời và vĩnh viễn ở tầng mạng (An toàn hơn ở tầng ứng dụng ) nên webserver ko phải mệt nhọc xử lý yêu cầu từ các IP bị cấm nữa.

- Cho phép bạn chuyến hướng yêu cầu từ các IP bị khóa sang 1 file html để thông báo cho người dùng biết IP của họ bị khóa.

- Cùng với rất nhiều tính năng, công dụng khác. Có thể xem [tại đây](https://www.configserver.com/cp/csf.html).

## 2. Cài đặt CSF trên CentOS7

### Bước 1: Cài đặt các module cần thiết cho CSF

```
yum install perl-libwww-perl -y
```

### Bước 2: Tải CSF

```
cd /tmp
wget https://download.configserver.com/csf.tgz
```

### Bước 3: Cài đặt CSF

```
tar -xzf csf.tgz
cd csf
sh install.sh
```

### Bước 4: Cấu hình CSF

Cấu hình mặc định của CSF ở chế độ `Testing`, điều đó có nghĩa hệ thống chưa được bảo vệ toàn diện. Để tắt chế độ `Testing` bạn cần cấu hình các lựa chọn TCP_IN, TCP_OUT, UDP_IN và UDP_OUT cho phù hợp với nhu cầu:

Mở file cấu hình CSF

```
vi /etc/csf/csf.conf
```

Tắt chệ độ Testing bằng cách chuyển dòng `TESTING="1"` thành `
```
TESTING="0"
```

Lưu cấu hình lại.

### Bước 5: Khởi động CSF và cho phép CSF khởi động cùng hệ thống

```
[root@srv-thuctapanh csf]# systemctl start csf
[root@srv-thuctapanh csf]# systemctl enable csf
```

## 3. Những file cấu hình của CSF

Toàn bộ thông tin cấu hình và quản lý CSF được lưu ở các file trong folder /etc/csf. Nếu bạn chỉnh sửa các file này thì cần khởi động lại CSF để thay đổi có hiệu lực.

- **csf.conf:** File cấu hình chính để quản lý CSF.

- **csf.allow:** Danh sách địa chỉ IP cho phép qua firewall.

- **csf.deny:** Danh sách địa chỉ IP từ chối qua firewall.

- **csf.ignore:** Danh sách địa chỉ IP cho phép qua firewall và không bị block nếu có vấn đề.

- **csf.*ignore:** Danh sách user, IP bị ignore.

## 4. Một số lệnh thường dùng trong CSF

Một số câu lệnh sử dụng để add (-a) hoặc deny (-d) một địa chỉ IP.

```
csf -d IPADDRESS //Block địa chỉ IP
csf -dr IPADDRESS //Xóa địa chỉ IP đã bị block
csf -a IPADDRESS //Allow địa chỉ IP
csf -ar IPADDRESS //Xóa địa chỉ IP đã được allow
csf -g IPADDRESS //Kiểm tra địa chỉ IP có bị block không
csf -r //Khởi động lại CSF
csf -x //Tắt CSF
csf -e //Mở CSF
```

## 5. Xóa cài đặt CSF

Nếu muốn xóa cài đặt CSF, chỉ cần sử dụng lệnh

```
/etc/csf/uninstall.sh
```

Việc này sẽ xóa toàn bộ CSF nên bạn cần cân nhắc khi dùng. Nếu muốn tạm thời tắt CSF thì có thể chuyển chế độ TESTING sang 1.

## Tài liệu tham khảo

https://vinahost.vn/csf-la-gi

https://hocvps.com/cai-dat-configserver-security-firewall-csf-tren-centos/