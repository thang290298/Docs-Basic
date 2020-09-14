# Hướng dẫn cài đặt WordPress, SSL Let's Encrypt trên Nginx
## I. Cài đặt Wordpress
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
GRANT ALL PRIVILEGES ON wordpress.* TO nvt292@localhost IDENTIFIED BY 'Thang@292';
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
sudo rsync -avP ~/wordpress/ /usr/share/nginx/html/
```
Tạo một thư mục để lưu những file đã đưuọc upload của WordPress bằng lệnh mkdir :
```
mkdir /usr/share/nginx/html/wp-content/uploads
```
Giờ ta cần xác thực quyền sở hữu với các file và thư mục của WordPress với lệnh chown. Điều này tăng tính bảo mật trong khi không ảnh hưởng đến các chức năng của WordPress.
```
chown -R nginx:nginx /usr/share/nginx/html/*
```
### 3. Cấu hình WordPress
Mở thư mục cài WordPress:
```
cd /usr/share/nginx/html/
```
File cấu hình chính có tên là wp-config.php. Có một file cấu hình mẫu gần như khớp với những thiết lập ta sẽ cài được đính kèm sẵn với WordPress. Ta cần sao chép nó vào vị trí file cấu hình trên, để WordPress có thể nhận biết và sử dụng nó:
```
cp wp-config-sample.php wp-config.php
```
Mở file cấu hình vừa được copy vào với `vim`:
```
vi wp-config.php
```
Tìm đến mục MySQL settings rồi đổi các thuộc tính DB_NAME, DB_USER, và DB_PASSWORD cho pù hợp để WordPress có thể kết nối và xác thực với database ta vừa tạo.
 
 <img src="https://image.prntscr.com/image/HaSFgc4HTDOj545M1lYrhg.png">

lưu và đóng file `:wq!`:
### 4. Cấu hình Nginx
Chỉnh sửa cấu hình Config cho WorPress:
```
	sudo vi /etc/nginx/conf.d/defau.conf
```
Xóa nội dung có trong file và dán nội dung sau đây vào file:
```
server {
    listen 80;
    server_name learning365.online;
    access_log /var/log/nginx/localhost.log;
    access_log /var/log/nginx/localhost.bytes bytes;
    error_log /var/log/nginx/localhost.error.log;
    root /usr/share/nginx/html;
    index index.html index.htm index.php;

    location ~ \.php$ {
        try_files $uri $uri/ =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```
### 5. Kết thúc quá trình cài đặt qua giao diện

- http://learning365.online

<img src="https://github.com/thang290298/work-Document/blob/master/Images/wordpress/wordpress_web_install.png?raw=true">


## 2. Trỏ tền miềm cho Website Wordpress
 Đăng nhập vào Website: `https://zonedns.vn/` với tên miền đã đăng ký.

 <img src="https://image.prntscr.com/image/36xRxd77SiCV7C3TTRbaXA.png">

 - Sau khi đăng nhập tiến hành trỏ các bản ghi DNS như trong hình:
<img src="https://image.prntscr.com/image/2XWmcSeFRnOhCEj2-mtAGg.png">

- Các loại bản ghi DNS:
  + Nếu chọn Loại là : A thì Địa chỉ phải nhập là địa chỉ IP, ví dụ: 203.182.78.121
 + Nếu chọn Loại là : CNAME thì Địa chỉ phải nhập là tên miền , ví dụ: abc.com
 + Nếu chọn Loại là : MX thì Bản ghi phải là <domain> và Địa chỉ phải nhập là tên mail server, ví dụ: mail.abc.com
 + Priority chỉ áp dụng cho Loại là MX
 + Nếu Loại là : URL Redirect/URL Frame thì Địa chỉ phải nhập là địa chỉ web, ví dụ: https://nhanhoa.com/


- Cấu hình tên miền trong file `*.conf` trong Nginx:

<img src="https://image.prntscr.com/image/lLIMsjXERKCIDIF9FrgVzw.png">
- kiểm tra :
  - Sử dụng trình duyệt để nhập tên miền vào thanh đại chỉ tìm kiếm : `https://learning365.online`
<img src="https://image.prntscr.com/image/ClJt68u9TuGwzPInVCeEFg.png">

# Nguồn Tham Khảo

https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-centos-7

https://linux4one.com/how-to-install-wordpress-with-lemp-stack-on-centos-7/