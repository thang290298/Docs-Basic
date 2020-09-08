# Hướng dẫn cấp quyền sudo user và xóa vô hiệu hóa root
## I. CentOS 7/ RHEL 7
### 1. Cấp quyền `sudo` user 
- Bước 1: Tạo mới `user` bằng lệnh `adduser`
```
# adduser thang292
```
- Bước 2: Thiết lập passwoek cho thang292 bằng lệnh `passwd`
```
# passwd thang292
```
- Bước 3: Thêm tài khoản thang292 vào nhóm wheel bằng lệnh `usermod`
```
usermod -aG wheel thang292
```
- Bước 4 : Kiểm tra user đã sử dụng dk `sudo`chưa
```
su - thang292
sudo ls -la
```
<img src="https://i.imgur.com/j3JdX34.png">

### 2. Chặn truy cập SSH tren Root
- Để vô hiệu hóa đăng nhập root, mở tập tin cấu hình ssh /etc/ssh/sshd_config
```
# vi  /etc/ssh/sshd_config
```
- Tìm kiếm cho các dòng sau đây trong tập tin.
```
#PermitRootLogin no
```
- Loại bỏ các '#' từ đầu dòng.
```
PermitRootLogin no
```
<img src="https://i.imgur.com/IGh9mWG.png">

## II. Ubuntu/Debian
### 1. Cấp quyền `sudo` User
- Bước 1: Tạo tài khoản `User` mới 
```
# adduser thang292
```
Trên Ubuntu/Debian, ko cần sử dụng lệnh passwd để thiết lập mật khẩu, mà lệnh adduser sẽ hỏi mật khẩu của người dùng luôn.
- Bước 2: Thêm tài khoản thang292 vào nhóm sudo cũng sử dụng lệnh adduser
```
# adduser thang292 sudo
```
- Bước 3: Kiểm tra lại tài khoản thang292 xem đã sử dụng được quyền sudo chưa
```
su - thang292
sudo ls -la
```
<img src="https://i.imgur.com/V0LCUO4.png">

### 2. Chặn truy cập SSH tren Root
- Để vô hiệu hóa đăng nhập root, mở tập tin cấu hình ssh /etc/ssh/sshd_config
```
# vi  /etc/ssh/sshd_config
```
- Tìm kiếm cho các dòng sau đây trong tập tin.
```
#PermitRootLogin no
```
- Loại bỏ các '#' từ đầu dòng.
```
PermitRootLogin no
```
<img src="https://i.imgur.com/vO5QplL.png">

# Nguồn Tham Khảo
https://vinasupport.com/tao-user-voi-quyen-sudo-tren-centos-ubuntu/

https://mediatemple.net/community/products/dv/204643810/how-do-i-disable-ssh-login-for-the-root-user