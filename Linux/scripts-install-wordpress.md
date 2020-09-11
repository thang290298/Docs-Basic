# Scripts cài đặt LAMP và Wordpress
- Tạo file scripts
```
 # vi scripts-LAMP-WP.sh
```
- Dán nội dung bên dưới vào file  
```
#!/bin/bash

if [ -e /usr/bin/mysql ]
then 
	echo "da cai dat mysql "
else

	cd ~
	echo " ------- Tien hanh cai dat apache -------"
	sleep 3
	yum install -y httpd
	systemctl start httpd
	systemctl enable httpd
	systemctl stop firewalld
	echo "DONE"
	sleep 3
	echo " ------ Tien hanh cai dat mariadb ------ "
	sleep 3
	yum -y install mariadb mariadb-server
	systemctl start mariadb
	systemctl enable mariadb
	
cat << EOF | mysql -uroot
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'Thangnguyen2020' WITH GRANT OPTION ;FLUSH PRIVILEGES;
EOF
	
	echo "DONE"
	sleep 3


	echo "------- Tien hanh cai dat PHP -------- "
	sleep 3
	yum install epel-release -y
	yum update epel-release -y
	rpm -Uvh https://rpms.remirepo.net/enterprise/remi-release-7.rpm
	yum -y install yum-utils
	yum-config-manager --enable remi-php70 -y
	yum -y install php php-opcache php-mysql
	systemctl restart httpd
	echo "DONE"
	
	
	sleep 3
	echo "tao tai khoan user cho MySQL voi user thang password Thangnguyen2020 DATABASE wordpress "
	sleep 3
	mysql -uroot -pThangnguyen2020 -e "CREATE DATABASE Wordpress;
	CREATE USER thang@localhost IDENTIFIED BY 'Thangnguyen2020';
	GRANT ALL PRIVILEGES ON Wordpress.* TO thang@localhost IDENTIFIED BY 'Thangnguyen2020';
	FLUSH PRIVILEGES;"
	echo "DONE"
	sleep 3
	
	
	echo " ------- Tien hanh cai dat wordpress ------- "
	sleep 3
	yum -y install php-gd
	yum install wget -y
	wget http://wordpress.org/latest.tar.gz
	tar xvfz latest.tar.gz
	cp -Rvf /root/wordpress/* /var/www/html
	cd /var/www/html
	cp wp-config-sample.php wp-config.php
	sed -i 's/username_here/thang/g' /var/www/html/wp-config.php
	sed -i 's/database_name_here/Wordpress/g' /var/www/html/wp-config.php
	sed -i 's/password_here/Thangnguyen2020/g' /var/www/html/wp-config.php
	chmod -R 755 /var/www/*
	chown -R apache:apache /var/www/*
	systemctl restart httpd
	echo "DONE"
	sleep 3
	echo "tat ca moi thu da xong gio ban co the vao browser va go dia chi ip cua may da cai dat va trai nghiem "
fi
```
- Phân quyền thực thi thư mục
```
# chmod +x scripts-LAMP-WP.sh
```
- Chạy scripts
```
sh ./scripts-LAMP-WP.sh
```
kết quả:
  <img src="https://image.prntscr.com/image/ZN_741dwQ-mSg8qnzZtRhg.png">

Chúc các bạn thành công!!