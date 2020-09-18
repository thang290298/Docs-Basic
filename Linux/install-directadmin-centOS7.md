# Hướng dẫn cài đặt DirectAdmin trên CentOS 7
- yêu cầu cài đặt
  - Chuẩn bị VPS trắng chưa cài các dịch vụ web, database server, FTP, PHP vàcó sử dụng IP public
  - OS có thể là: CentOS/Redhat, Debian/Ubuntu, Cloud Linux, FreeBSD.
  - Hardware: tối thiểu 1GB RAM, 2G hard disk, CPU > 500MHz
- Cài đặt:
   - Ở trong phần cài đặt này tôi sẽ sử dụng 1 VPS chạy CentOS 7 của Nhân Hòa. Tham khảo tại VPS tại đây: https://nhanhoa.com/
   - License trial để thực hiện cài đặt.
   - Hoặc bạn muốn tiện lợi hơn, bỏ qua bước cài đặt khi sử dụng Cloud VPS của Nhân Hòa đã tích hợp sẵn Direct Admin bản mới nhất.

## I. Đăng ký tài khoản DirectAdmin Trial
- đăng nhâp website [DiectAdmin](https://www.directadmin.com/) tiến hành đăng kí tài khoản:

<img src="https://image.prntscr.com/image/05fQb0Z1R3qlcOdVno2CiQ.png">

- sau khi `Submit` bạn sẽ nhận đươc thông tin tài khoản qua E-mail:

<img src="https://image.prntscr.com/image/zLISZbIISnC7_E4UW-rTCQ.png">

- Sau đó login lại để đăng kí license trial, thông tin bao gồm địa chỉ IP public của VPS dùng Direct Admin, hostname của VPS
- Sau khi đăng kí xong, kiểm tra lại license:

<img src="https://image.prntscr.com/image/wE2dmb2-Sly5xvAa5YL4Wg.png">

Sau khi đã có thông tin về license, ta tiến hành cài đặt Direct Admin
## II. Cài đặt DirectAdmin
### 2.1  Chạy Scripts cài đặt 
Direct Admin cài đặt rất tiện lợi, ta chỉ cần tải script về và cài đặt. Chạy lệnh update để update các gói phần mềm mới nhất.
```
yum update -y
```
Tải script về theo đường link sau:
```
wget https://www.directadmin.com/setup.sh 
```
Phân quyền và bắt đầu chạy script:
```
chmod 755 setup.sh
sh ./setup.sh
```

Khi file script bắt đầu chạy, ta cần nhập những thông tin về license, user id, IP… và chờ khoảng 30p để có thể cài đặt:

<img src="https://image.prntscr.com/image/tVkdI_-dQtGNO8_168vAUw.png">

Sau khi quá trình cài đặt hoàn tất, thông tin về địa chỉ GUI, tài khoản login sẽ được in ra:

<img src="https://image.prntscr.com/image/RO9sFihAQeeW4ns3_Uiovw.png">

Truy cập vào giao diện quản lý theo link: http://IP:2222 sau đó điền tài khoản admin và password để truy cập:

<img src="https://image.prntscr.com/image/gAj5fNzuRsakBTf8yff1Rw.png">

Giao diện quản lý mới của Direct Admin kể từ phiên bản 1.57 gọi là skin evolution.

<img src="https://image.prntscr.com/image/houJJ7gVRDmMzdg8NlBVbQ.png">

# Nguôn tham khảo

https://news.cloud365.vn/directadmin-gioi-thieu-va-cai-dat-direct-admin-phan-1/
