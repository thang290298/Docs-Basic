# Hướng dẫn cài đặt LAMP và WordPress lên CentOS7
## I. Hướng dẫn cài đặt LAMP
### 1. Tổng quan
LAMP là một hệ thống các phần mềm để tạo dựng môi trường máy chủ web có khả năng chứa và phân phối các trang web động được viết bằng PHP.
<img src="https://image.prntscr.com/image/zZ-kCGioRmu9tImliG176Q.png">
LAMP bao gồm:
 - Linux: là hệ điều hành, cũng là phần mềm dùng để điều phối và quản lí các tài nguyên của hệ thống.
 - Apache: là phần mềm máy chủ web, có thể thực hiện các request được gọi tới máy chủ thông qua giao thức HTTP
 - Mysql/Mariadb: là hệ quản trị cơ sở dữ liệu giúp lưu trữ và truy xuất dữ liệu. Cả 2 hệ quản trị cơ sở dữ liệu này đều khá tương đồng với nhau (có thể tìm hiểu thêm [tại đây](https://www.eversql.com/mariadb-vs-mysql/) )
 - PHP: Là ngôn ngữ lập trình cho kịch bản hoạt động của máy chủ.

### 2.Tiến Hành cài đặt
#### 2.1 Cài đặt Apache
Để cài đăt, sử dụng cửa sổ terminal và gõ lệnh
```
 # sudo yum -y install httpd
```
Cài xong tiến hành khởi động lại service
```
  # systemctl start httpd
  # systemctl enable httpd
```
Bạn có thể check lại trang thái hoạt động của service bằng cách gõ:
```
  # systemctl status httpd
```
<img src="https://image.prntscr.com/image/zZ-kCGioRmu9tImliG176Q.png">

Kiểm tra trạng thái trên trình duyệt bằng cách gõ trên thanh url địa chỉ sau:
- http://your_server_IP/

<img src="https://image.prntscr.com/image/zZ-kCGioRmu9tImliG176Q.png">

Thay đổi Firewall để cho phép kết nối các cổng này bằng các lệnh sau:
```
 # sudo firewall-cmd --zone=public --add-port=80/tcp
 # sudo firewall-cmd --zone=public ––add-port=80/tcp ––permanent
 # sudo firewall-cmd --reload 
```
#### 2.2 Cài đặt MariaDB
Trên cửa sổ terminal, tiến hành cài đặt mariadb:
```
# sudo yum -y install mariadb mariadb-server
```
Tiến hành khởi động mariadb service:
```
 # systemctl start mariadb
 # systemctl enable mariadb
```
Cài lại mật khẩu mật khẩu cho quyền root của cơ sở dữ liệu:
```
 # sudo mysql_secure_installation
```

<img src="https://image.prntscr.com/image/529ViWdeTnyJiEVlhvMGQg.png">
Với những máy mới cài mariadb lần đầu, hệ thống yêu cầu thêm một số thiết lập như sau:
- Xoá bỏ các user khác.
- Không cho phép root đăng nhập từ xa.
- Xoá bỏ databases test.
- Khởi chạy lại bảng Privilege (bảng phân quyền).


<img src="https://image.prntscr.com/image/xonMLb3GTQmEMtOJgdtJWw.png">

#### 2.2 Cài đặt PHP
Phiên bản có sẵn trong repo của CentOS đang là 5.4. Phiên bản này khá cũ và sẽ khiến bạn gặp một số vấn đề xảy ra khi tiến hành cài đặt wordpress. Vì vậy bạn cần phải cài đặt phiên bản 7x để khắc phục. Bạn cần tiến hành thêm kho vào Remi CentOS:
```
 # rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
```
Cài yum-utils vì chúng ta cần tiện ích yum-config-manager để cài đặt:
```
 # yum -y install yum-utils
```
Tiến hành cài đặt php. Ở đây ta cần lưu ý về phiên bản cài đặt như sau:
- Bản 7.0:

```
yum-config-manager --enable remi-php70
yum -y install php php-opcache php-mysql
```
- Bản 7.2:
```
yum-config-manager --enable remi-php72
yum -y install php php-opcache php-mysql
```
- Bản 7.3:
```
yum-config-manager --enable remi-php73
yum -y install php php-opcache php-mysql
```
Trong bài này, mình cài phiên bản 7.0
Sau khi cài đặt xong, thực hiện restart lại apache:
```
systemctl restart httpd
```
Tiến hành kiểm tra kết quả. Ta thêm file sau:
```
echo "<?php phpinfo();?>" > /var/www/html/info.php
```
Sau đó restart lại apache:
```
systemctl restart httpd
```
Vào trình duyệt, gõ trên thanh url địa chỉ sau:
- http://103.124.94.180/info.php

Khi màn hình này xuất hiện, bạn đã thực hiện thành công!

<img src="https://image.prntscr.com/image/0f38im3XTl_RQcOnZlGHnQ.png">

## II. Tiến hành cài đặt WordPress
### 1. Khởi tạo MariaDB
WordPress sử dụng một cơ sở dữ liệu quan hệ( relational database) để quản lý thông tin cho các trang web và người sử dụng của nó. Vì đã cài MariaDB (một nhánh của MySQL) nên ta chỉ cần phải tạo một database và một user để làm việc với WordPress.
Log in vào root (administrative) account của MariaDB với lệnh:
```
mysql -u root -p
```
Đầu tiên, tạo một database mới mà WordPress có thể kiểm soát được. Ở đây gọi là wordpress :
```
CREATE DATABASE wordpress;
```
Account mới sẽ là wordpressuser với password đi kèm là password. Dùng những tên tài khoản và mật khẩu khác để đảm bảo bảo mật.
```
CREATE USER nvt292@localhost IDENTIFIED BY 'Thang@292';
```
Đến đây, bạn có một database và một user account được dùng riêng cho WordPress. Tuy nhiên, user vừa tạo không có quyền truy cập vào database. Chúng ta cần phải liên kết hai thành phần với nhau bằng cách cấp quyền truy cập đến database cho user.
```
GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED BY 'password';
```
Dùng lệnh sau để cập nhật những thay đổi về quyền truy cập.
```
FLUSH PRIVILEGES;
```
Sau đó thoát với lệnh: `exit`
### 2. Cài đặt WordPress
Trước khi tải WordPress, ta cần cài một module hỗ trợ PHP vì nếu không có nó, WordPress sẽ không thể resize ảnh để tạo các thumbnail.
Cài module này từ kho mặc định của Centos 7 với lệnh yum:
```
sudo yum install php-gd
```
Khởi động lại Apache để việc cài đặt có hiệu lực.
```
sudo service httpd restart
```
Giờ ta sẽ cài WordPress trên trang chủ của nhóm phát truển. May mắn là đội phát triển của WordPress luôn cập nhật phiển bản mới nhất của WordPress lên cùng một URL, nên ta chỉ cần gõ lệnh:
```
cd ~
wget http://wordpress.org/latest.tar.gz
```
Sau khi tải về, giải nén file vừa tải với tar:
```
tar xzvf latest.tar.gz
```
Giờ bạn đã có một thư mục tên wordpress trong thư mục gốc của mình. Kết thúc quá trình cài đặt bằng cách chuyền những file này đến thư mục gốc của Apache để chúng có thể đưuọc truy cập bởi người dùng với lệnh rsync, để quyền truy cập vào các file không bị ảnh hưởng:
```
sudo rsync -avP ~/wordpress/ /var/www/html/
```
Tạo một thư mục để lưu những file đã đưuọc upload của WordPress bằng lệnh mkdir :
```
mkdir /var/www/html/wp-content/uploads
```
Giờ ta cần xác thực quyền sở hữu với các file và thư mục của WordPress với lệnh chown. Điều này tăng tính bảo mật trong khi không ảnh hưởng đến các chức năng của WordPress.
```
sudo chown -R apache:apache /var/www/html/*
```
### 3. Cấu hình WordPress
Mở thư mục cài WordPress:
```
cd /var/www/html
```
File cấu hình chính có tên là wp-config.php. Có một file cấu hình mẫu gần như khớp với những thiết lập ta sẽ cài được đính kèm sẵn với WordPress. Ta cần sao chép nó vào vị trí file cấu hình trên, để WordPress có thể nhận biết và sử dụng nó:
```
cp wp-config-sample.php wp-config.php
```
Mở file cấu hình vừa được copy vào với `vim`:
```
nano wp-config.php
```
Tìm đến mục MySQL settings rồi đổi các thuộc tính DB_NAME, DB_USER, và DB_PASSWORD cho pù hợp để WordPress có thể kết nối và xác thực với database ta vừa tạo.
 
 <img src="https://image.prntscr.com/image/HaSFgc4HTDOj545M1lYrhg.png">

lưu và đóng file `:wq!`:
### 4. Kết thúc quá trình cài đặt qua giao diện

- http://103.124.94.180

 <img src="https://image.prntscr.com/image/Staj9cRsQXSH7Cox3AIbuQ.png">
