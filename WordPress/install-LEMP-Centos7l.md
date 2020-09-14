# Hướng dẫn cài đặt LEMP, WordPress, SSL Let's Encrypt
## I. Hướng dẫn cài đặt LEMP
### 1. Tắt Selinux
Để tắt Selinux các bạn chạy lệnh sau
```
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config && setenforce 0
```
### 2. Cài Đặt Nginx
Theo mặc định thì khi cài đặt qua repo của CentOS sẽ không phải là phiên bản mới nhất. Để cài đặt phiên bản mới nhất của `Nginx` chúng ta cần tạo  repo riêng bằng cách tạo file `/etc/yum.repos.d/nginx.repo` với nội dung sau:
```
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
```
Sau khi tạo repo các bạn chạy lệnh sau để cài đặt Nginx:
```
yum install -y epel-release nginx
```
Để kiểm tra phiên bản Nginx được cài đặt các bạn có thể dùng lệnh sau:
```
nginx -v
```

<img src="https://image.prntscr.com/image/4G0LoLUeTAq2Hdj95bZrig.png">

Nếu sử dụng Firewalld thì bạn sẽ cần mở port để có thể truy cập website:

```
firewall-cmd --add-service=http --permanent
firewall-cmd --add-service=https --permanent
firewall-cmd --reload
```
Tất cả các file cấu hình của Nginx đều nằm trong thư mục `/etc/nginx`
- Backup file cấu hình Nginx

Trước khi bắt đầu cấu hình Nginx các bạn nên backup lại file config để có thể khôi phục khi cần thiết

```
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
```

- Cấu hình Nginx

Sau khi đã backup file cấu hình các bạn mở file /etc/nginx/nginx.conf và xoá sạch nội dung bên trong và thay thế bằng nội dung sau đây
```
user  nginx;

worker_processes  auto;
pid /var/run/nginx.pid;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

events {
   worker_connections  10240;
}


http {
   include       /etc/nginx/mime.types;

   default_type  application/octet-stream;
   tcp_nopush on;
   tcp_nodelay on;
   sendfile        on;

   log_format bytes '$bytes_sent $request_length';

   keepalive_timeout  15;
   types_hash_max_size 2048;

   disable_symlinks if_not_owner from=$document_root;

   server_tokens off;

   add_header X-Frame-Options SAMEORIGIN;
   add_header X-XSS-Protection "1; mode=block";
   add_header X-Content-Type-Options nosniff;
   add_header Strict-Transport-Security "max-age=63072000; includeSubdomains";
   
   client_max_body_size 1024m;
   client_body_buffer_size 128k;

   server_names_hash_bucket_size 128;
   server_names_hash_max_size 10240;

   ssl_dhparam /etc/nginx/ssl/dhparams.pem;
   ssl_session_cache   shared:SSL:10m;
   ssl_session_timeout  5m;
   proxy_read_timeout 1800s;

   ssl_protocols TLSv1.2 TLSv1.3;
   ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
   ssl_prefer_server_ciphers on;

   index  index.html index.htm index.php;

   gzip on;
   gzip_static on;
   gzip_disable "msie6";
   gzip_http_version 1.1;
   gzip_vary on;
   gzip_comp_level 1;
   gzip_proxied any;
   gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript application/javascript text/x-js image/svg+xml;
   gzip_buffers 16 8k;

   include /etc/nginx/conf.d/*.conf;
}
```
- Khởi động Nginx
   - Kiểm tra cấu hình nginx:
```
nginx -t
```
<img src="https://image.prntscr.com/image/8ymswZgyReS5NWWrB-KkwA.png">

- Khởi động Nginx :
```
systemctl enable nginx
systemctl start nginx
```
<img src="https://image.prntscr.com/image/BRSzEWftRCKoWTf25YrMnQ.png">

### 3. Cài đặt Mariadb
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

### 4. Cài đặt PHP
#### 4.1 Cài đặt PHP-FPM

Để cài đặt PHP-FPM các bạn chạy các lệnh sau
```
yum -y install yum-utils
rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y update

yum-config-manager --enable remi-php73
yum -y install php-fpm php-ldap php-zip php-embedded php-cli php-mysql php-common php-gd php-xml php-mbstring php-mcrypt php-pdo php-soap php-json php-simplexml php-process php-curl php-bcmath php-snmp php-pspell php-gmp php-intl php-imap perl-LWP-Protocol-https php-pear-Net-SMTP php-enchant php-pear php-devel php-zlib php-xmlrpc php-tidy php-mysqlnd php-opcache php-cli php-pecl-zip unzip gcc
```
#### 4.2 Cấu hình PHP-FPM
Tất cả các file cấu hình PHP-FPM sẽ nằm trong thư mục /etc/php-fpm.d. Đầu tiên các bạn backup lại file cấu hình mặc định:
```
cp /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.bak
```
Sau đó mở file /etc/php-fpm.d/www.conf xoá toàn bộ nội dung bên trong và thay bằng nội dung sau:
```
[www]
user = nginx 
group = nginx
listen = /var/run/php-fpm.sock;
listen.owner = nginx
listen.group = nginx
listen.mode = 0660
pm = ondemand
pm.max_children = 10
pm.process_idle_timeout = 20
pm.max_requests = 500
;slowlog = /var/log/php-fpm/www-slow.log
php_admin_value[error_log] = /var/log/php-fpm/www-error.log
php_admin_flag[log_errors] = on
php_value[session.save_handler] = files
php_value[session.save_path]    = /var/lib/php/session
php_value[soap.wsdl_cache_dir]  = /var/lib/php/wsdlcache
security.limit_extensions = .php .php52 .php53 .php54 .php55 .php56 .php60 .php70 .php71 .php73
```
Tiếp theo các bạn chạy lệnh sau:
```
chown -R nginx:nginx /var/lib/php/*
```
#### 4.3 Khởi động PHP-FPM
Sau khi cấu hình hoàn tất các bạn chạy 2 lệnh sau để khởi động PHP-FPM
```
systemctl enable php-fpm
systemctl start php-fpm
```
#### 4.4 Kiểm tra PHP-FPM
Sau khi đã khởi động PHP-FPM các bạn có thể kiểm tra xem nó có hoạt động hay không. Đầu tiền các bạn mở file `/etc/nginx/conf.d/default.conf` xoá toàn bộ nội dung bên trong và thay thế bằng nội dung sau:
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
Khởi động lại Nginx để load lại cấu hình:
```
systemctl restart nginx
```
Sau đó các bạn tạo file /usr/share/nginx/html/info.php với nội dung sau:
```
<?php
phpinfo();
```
Tiến hành truy cập theo link http://learning365.online/info.php để kiểm tra.
<img src="https://image.prntscr.com/image/T4po9u9NTmuCzn1X7JA7Lw.png">

# Nguồn tham khảo

https://blog.hostvn.net/chia-se/huong-dan-cach-cai-dat-lemp-tren-centos-7.html