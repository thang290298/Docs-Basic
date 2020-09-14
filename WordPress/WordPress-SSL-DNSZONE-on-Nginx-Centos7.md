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

## 2. Cài đặt SSL Let's Encrypt
### 2.1 Tạo chứng chỉ SSL
TLS / SSL hoạt động bằng cách sử dụng kết hợp chứng chỉ công khai và khóa riêng tư. Khóa SSL được giữ bí mật trên máy chủ. Nó được sử dụng để mã hóa nội dung được gửi đến máy khách. Chứng chỉ SSL được chia sẻ công khai với bất kỳ ai yêu cầu nội dung. Nó có thể được sử dụng để giải mã nội dung được ký bởi khóa SSL liên quan.

Thư mục /etc/ssl/certs, có thể được sử dụng để giữ chứng chỉ công khai, nên đã tồn tại trên máy chủ. Hãy tạo một /etc/ssl/privatethư mục để giữ tệp khóa riêng tư. Vì tính bí mật của khóa này là cần thiết để bảo mật, chúng tôi sẽ khóa các quyền để ngăn truy cập trái phép:
```
sudo mkdir /etc/ssl/private
sudo chmod 700 /etc/ssl/private
```
Bây giờ, chúng ta có thể tạo một cặp chứng chỉ và khóa tự ký với OpenSSL trong một lệnh duy nhất bằng cách gõ:
```
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
```
Bạn sẽ được hỏi một loạt câu hỏi. Trước khi xem xét điều đó, hãy xem điều gì đang xảy ra trong lệnh mà chúng tôi đang phát hành:
  - openssl : Đây là công cụ dòng lệnh cơ bản để tạo và quản lý chứng chỉ OpenSSL, khóa và các tệp khác.
  - req : Lệnh con này chỉ định rằng chúng tôi muốn sử dụng quản lý yêu cầu ký chứng chỉ (CSR) X.509. “X.509” là tiêu chuẩn cơ sở hạ tầng khóa công khai mà SSL và TLS tuân thủ để quản lý khóa và chứng chỉ của nó. Chúng tôi muốn tạo một chứng chỉ X.509 mới, vì vậy chúng tôi đang sử dụng lệnh con này.
  - -x509 : Điều này sửa đổi thêm lệnh con trước đó bằng cách nói với tiện ích rằng chúng tôi muốn tạo chứng chỉ tự ký thay vì tạo yêu cầu ký chứng chỉ như thường xảy ra.
  - -nodes : Điều này yêu cầu OpenSSL bỏ qua tùy chọn bảo mật chứng chỉ của chúng tôi bằng cụm mật khẩu. Chúng tôi cần Nginx để có thể đọc tệp mà không cần sự can thiệp của người dùng, khi máy chủ khởi động. Cụm mật khẩu sẽ ngăn điều này xảy ra vì chúng tôi sẽ phải nhập cụm mật khẩu sau mỗi lần khởi động lại.
  - -days 365 : Tùy chọn này đặt khoảng thời gian mà chứng chỉ sẽ được coi là hợp lệ. Chúng tôi đặt nó trong một năm ở đây.
  - -newkey rsa: 2048 : Điều này chỉ định rằng chúng tôi muốn tạo chứng chỉ mới và khóa mới cùng một lúc. Chúng tôi đã không tạo khóa bắt buộc phải ký chứng chỉ ở bước trước, vì vậy chúng tôi cần tạo khóa cùng với chứng chỉ. Các rsa:2048phần nói với nó để thực hiện một khóa RSA đó là dài 2048 bit.
  - -keyout : Dòng này cho OpenSSL biết nơi đặt tệp khóa cá nhân đã tạo mà chúng tôi đang tạo.
  - -out : Điều này cho OpenSSL biết nơi đặt chứng chỉ mà chúng tôi đang tạo.
Cả hai tệp đã tạo sẽ được đặt trong các thư mục con thích hợp của thư mục /etc/ssl.
- Cập nhật các thông số Diffie-Hellman:
Tạo tệp bằng cách sử dụng openssl:
```
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
```

### 2.2 Định cấu hình Nginx để sử dụng SSL
- Tiến hành định cấu hình File như trong hình:

<img src="https://image.prntscr.com/image/Zr2odmgLTOm-nlcxW-Csmg.png">

- khởi động lại Nginx:
```
sudo systemctl restart nginx
```
### 2.3 Kiểm tra mã hóa 
Bây giờ, chúng tôi đã sẵn sàng để kiểm tra máy chủ SSL của mình.
Mở trình duyệt web của bạn và nhập `https://tên` miền hoặc IP của máy chủ vào thanh địa chỉ:
```
https://learning365.online
```

kết quả:
<img src="https://image.prntscr.com/image/MmfMDCiCQ_qeXQCu1P0ZRQ.png">

## 3. Trỏ tền miềm cho Website Wordpress
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