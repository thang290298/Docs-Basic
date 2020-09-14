# Tổng quan về SSL Certificate
## I. Giới thiệu SSL Certificate
`SSL Certificate` (hay còn được gọi là chứng chỉ SSL – Sercure Socket Layer) là giao thức bảo mật các thông tin được lưu hành từ website đến các trình duyệt web, các thông tin, dữ liệu trên trang web và khả năng hiển thị, hoạt động của website trên mạng Internet.

<img src="https://image.prntscr.com/image/cBDGQGfbReqOClGaP8fSqQ.png">
- Các nhiệm vụ chính cơ bản nhất của chứng chỉ SSL:
  - Xác thực trang web: Các chứng chỉ SSL sẽ làm nhiệm vụ đảm bảo tính xác thực của trang web của bạn. Cụ thể, các trang web có đăng kí SSL sẽ hiển thị giao thức https và có hình ổ khóa phía trước tên miền. Chúng tôi sẽ hướng dẫn bạn “Cách nhận biết website có đăng kí chứng chỉ SSL” trong các bài viết sắp tới.
  - Mã hóa thông tin, dữ liệu: Việc cài đặt SSL Certificate cũng giúp đảm bảo các dữ liệu trên trang web của bạn sẽ không thể truy cập được bởi bên thứ 3, thường là các hacker. Các thông tin truyền dẫn giữa website và các trình duyệt lớn sẽ được mã hóa bằng công nghệ mã hóa hiện đại, chuyên nghiệp nhất. Thao tác này chắc chắn sẽ khắc phục gần như hoàn toàn việc xem trộm thông tin, ăn cắ thông tin, dữ liệu khi lưu truyền trên Internet.

## II. Cài đặt SSL Certificate
### 1. Tạo Self-Signed SSL Certificate on CentOS 7
- Bước 1: Cài đặt Mod SSL
Để thiết lập chứng chỉ tự ký, trước tiên chúng ta phải chắc chắn rằng mod_ssl, một mô-đun Apache cung cấp hỗ trợ cho mã hóa SSL, đã được cài đặt máy chủ. Chúng ta có thể cài đặt mod_sslbằng yumlệnh:
```
  # sudo yum install mod_ssl
```
- Bước 2: Tạo mới chứng chỉ
Đầu tiên, chúng ta cần tạo một thư mục mới để lưu trữ khóa cá nhân của mình ( /etc/ssl/certsthư mục đã có sẵn để chứa tệp chứng chỉ của chúng ta):
```
   # sudo mkdir /etc/ssl/private
```
Vì các tệp được lưu trong thư mục này phải được giữ riêng tư nghiêm ngặt, chúng tôi sẽ sửa đổi các quyền để đảm bảo chỉ người dùng root mới có quyền truy cập:
```
   #  sudo chmod 700 /etc/ssl/private
```
Bây giờ chúng ta đã có vị trí để đặt các tệp của mình, chúng ta có thể tạo các tệp chứng chỉ và khóa SSL bằng openssl:
```
# sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
```
- Các thành phần cso trong lệnh:
   - openssl : Đây là công cụ dòng lệnh cơ bản để tạo và quản lý chứng chỉ OpenSSL, khóa và các tệp khác.
   - req -x509 : Điều này chỉ định rằng chúng tôi muốn sử dụng quản lý yêu cầu ký chứng chỉ (CSR) X.509. “X.509” là tiêu chuẩn cơ sở hạ tầng khóa công khai mà SSL và TLS tuân thủ để quản lý khóa và chứng chỉ.
   - -nodes : Điều này yêu cầu OpenSSL bỏ qua tùy chọn bảo mật chứng chỉ của chúng tôi bằng cụm mật khẩu. Chúng tôi cần Apache để có thể đọc tệp mà không cần sự can thiệp của người dùng, khi máy chủ khởi động. Một cụm mật khẩu sẽ ngăn điều này xảy ra, vì chúng tôi sẽ phải nhập nó sau mỗi lần khởi động lại.
   - -days 365 : Tùy chọn này đặt khoảng thời gian mà chứng chỉ sẽ được coi là hợp lệ. Chúng tôi đặt nó trong một năm ở đây.
   - -newkey rsa: 2048 : Điều này chỉ định rằng chúng tôi muốn tạo chứng chỉ mới và khóa mới cùng một lúc. Chúng tôi đã không tạo khóa bắt buộc phải ký chứng chỉ ở bước trước, vì vậy chúng tôi cần tạo khóa cùng với chứng chỉ. Các rsa:2048phần nói với nó để thực hiện một khóa RSA đó là dài 2048 
   - -keyout : Dòng này cho OpenSSL biết nơi đặt tệp khóa cá nhân đã tạo mà chúng tôi đang tạo.
   - -out : Điều này cho OpenSSL biết nơi đặt chứng chỉ mà chúng tôi đang tạo.
- Danh sách đầy đủ các lời nhắc sẽ trông giống như sau:

```
Country Name (2 letter code) [XX]:vn
State or Province Name (full name) []:hn
Locality Name (eg, city) [Default City]:hn
Organization Name (eg, company) [Default Company Ltd]:
Organizational Unit Name (eg, section) []:nhanhoa
Common Name (eg, your name or your server's hostname) []:learning365.online
Email Address []:thangjaeger.292@gmail.com
```
Cả hai tệp bạn đã tạo sẽ được đặt trong các thư mục con thích hợp của thư mục /etc/ssl.
Sau khi đã tạo chứng chỉ mới, hãy chạy phần sau để có mã hóa an toàn hơn nữa với thuật toán Diffie-Hellman. Quá trình này có thể mất một chút thời gian để hoàn thành:
```
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
```
Quá trình này có thể mất vài phút, nhưng khi hoàn tất, sẽ có một nhóm DH mạnh /etc/ssl/certs/dhparam.pemmà chúng tôi có thể sử dụng trong cấu hình của mình.
Vì phiên bản Apache đi kèm với CentOS 7 không bao gồm SSLOpenSSLConfCmdchỉ thị, chúng tôi sẽ phải nối tệp đã tạo theo cách thủ công vào cuối chứng chỉ tự ký của chúng tôi. Để làm điều này, hãy nhập:
```
cat /etc/ssl/certs/dhparam.pem | sudo tee -a /etc/ssl/certs/apache-selfsigned.crt
```

<img src="https://image.prntscr.com/image/CcEppKHwTOGUByK8m2L5qA.png">
Các apache-selfsigned.crttập tin bây giờ sẽ có cả giấy chứng nhận và tạo nhóm Diffie-Hellman.
- Bước 3: Thiết lập chứng chỉ
Mở tệp cấu hình SSL của Apache trong trình soạn thảo văn bản của bạn với đặc quyền root:

```
sudo vi /etc/httpd/conf.d/ssl.conf
```

Đầu tiên, bỏ ghi chú `DocumentRoot` và `ServerName` và chỉnh sửa địa chỉ trong dấu ngoặc kép cho vị trí của gốc tài liệu trang web cùng tên miền.

<img src="https://image.prntscr.com/image/OcQ2B_d5Qpe4IyGIJf9ExA.png">
Tiếp theo, tìm SSLProtocolvà SSLCipherSuitecác dòng và xóa chúng hoặc bình luận chúng. Cấu hình chúng tôi sẽ dán trong giây lát sẽ cung cấp các cài đặt an toàn hơn so với cấu hình mặc định được bao gồm trong Apache của CentOS:

<img src="https://image.prntscr.com/image/hFgFh0IGRq2MRjmmui7KLQ.png">
Tìm SSLCertificateFilevà SSLCertificateKeyFiledòng và thay đổi chúng vào thư mục chúng tôi thực hiện tại /etc/httpd/ssl:

<img src="https://image.prntscr.com/image/oL_tcKM2S4W2CrOsnx06wg.png">

- Thiết lập thông số SSL an toàn:
Dán vào cài đặt từ trang web SAU KHI kết thúc VirtualHostkhối:
```

</VirtualHost>
. . .

# Begin copied text
# from https://cipherli.st/
# and https://raymii.org/s/tutorials/Strong_SSL_Security_On_Apache2.html

SSLCipherSuite EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH
SSLProtocol All -SSLv2 -SSLv3
SSLHonorCipherOrder On
# Disable preloading HSTS for now.  You can use the commented out header line that includes
# the "preload" directive if you understand the implications.
#Header always set Strict-Transport-Security "max-age=63072000; includeSubdomains; preload"
Header always set Strict-Transport-Security "max-age=63072000; includeSubdomains"
Header always set X-Frame-Options DENY
Header always set X-Content-Type-Options nosniff
# Requires Apache >= 2.4
SSLCompression off 
SSLUseStapling on 
SSLStaplingCache "shmcb:logs/stapling-cache(150000)" 
# Requires Apache >= 2.4.11
# SSLSessionTickets Off
```
Sửa đổi tệp máy chủ ảo không được mã hóa để chuyển hướng sang HTTPS
```
sudo vi /etc/httpd/conf.d/httpd.conf
```
Bên trong, tạo một VirtualHostkhối để khớp các yêu cầu trên cổng 80. Bên trong, sử dụng lệnh ServerNameđể khớp lại với tên miền hoặc địa chỉ IP của bạn. Sau đó, sử dụng Redirectđể khớp bất kỳ yêu cầu nào và gửi chúng tới SSL VirtualHost. Đảm bảo bao gồm dấu gạch chéo sau:
```
<VirtualHost *:80>
        ServerName learning365.online
        Redirect "/" "https://learning365.online/"
</VirtualHost>
```
Lưu và đóng tệp này khi bạn hoàn tất.
Bước 4 : Kích hoạt chứng chỉ
Trước tiên, hãy kiểm tra tệp cấu hình của bạn để tìm lỗi cú pháp bằng cách nhập:
```
sudo apachectl configtest
```
Miễn là đầu ra kết thúc bằng Syntax OK, bạn có thể an toàn để tiếp tục. Nếu đây không phải là một phần của kết quả đầu ra của bạn, hãy kiểm tra cú pháp của tệp và thử lại:

<img src="https://image.prntscr.com/image/rWV9TxJqS6ObM315YmsgkA.png">
Khởi động lại máy chủ Apache để áp dụng các thay đổi của bạn bằng cách nhập:

```
sudo systemctl restart httpd.service
```
Trong trình duyệt web của bạn, hãy thử truy cập vào tên miền hoặc IP `https://`của bạn với để xem chứng chỉ mới của bạn đang hoạt động.
```
https://elearning365.online/
```
kết quả:
<img src="https://image.prntscr.com/image/9Q1oD0-LSIKA5GVJXwrA0A.png">

### 2. cài đặt Let's Encrypt with Apache trên CentOS 7
#### Bước 1: Cài đặt Certbot
Cần cài đặt Certbot và kích hoạt mod_sslmô-đun Apache trên máy chủ. Certbot là một công cụ đơn giản và dễ sử dụng giúp đơn giản hóa việc quản lý máy chủ bằng cách tự động hóa việc lấy chứng chỉ và cấu hình các dịch vụ web để sử dụng chúng.

Theo mặc định, gói Certbot không có sẵn trong kho lưu trữ hệ điều hành mặc định của CentOS 7. Chúng tôi cần kích hoạt kho EPEL, sau đó cài đặt Certbot.

- Để thêm kho EPEL, hãy chạy lệnh sau:
```
yum install epel-release
```
Sau khi được bật, hãy cài đặt tất cả các gói được yêu cầu bằng lệnh sau:

```
yum install certbot python2-certbot-apache mod_ssl
```
#### Bước 2: Lấy và cài đặt SSL cho miền của bạn
Bây giờ Certbot đã được cài đặt, bạn có thể sử dụng nó để lấy và cài đặt chứng chỉ SSL cho miền của mình.
Chỉ cần chạy lệnh sau để lấy và cài đặt chứng chỉ SSL cho miền của bạn:
```
certbot --apache -d learning365.online
```
Chúng tôi cũng có thể cài đặt một chứng chỉ duy nhất cho nhiều miền và miền phụ được lưu trữ trên máy chủ có cờ '-d', ví dụ:
```
certbot --apache -d domain.com -d www. domain.com -d domain2.com -d test.domain2.com
```
<img src="https://image.prntscr.com/image/NsegRHQoSDCLKh_Kd-J7SA.png">

#### Bước 3: Kiểm tra chứng chỉ

Mở trình duyệt web của bạn và nhập URL https://domain.com. Để kiểm tra chứng chỉ SSL trong Chrome,

<img src="https://image.prntscr.com/image/3PhQwQ0XT1W0d7ittmPqrg.png">

Chúng ta có thể kiểm tra quá trình gia hạn theo cách thủ công bằng lệnh sau.
```
certbot renew --dry-run
```
<img src="https://image.prntscr.com/image/bND6xYn9REmrozvNTyk_PA.png">

Lệnh trên sẽ tự động kiểm tra các chứng chỉ hiện đã được cài đặt và cố gắng gia hạn chúng nếu chứng chỉ ssl còn chưa đầy 30 ngày kể từ ngày hết hạn..
Để làm như vậy, hãy chỉnh sửa crontab bằng lệnh sau:
```
crontab -e
```
thêm dòng sau
```
* */12 * * * root /usr/bin/certbot renew >/dev/null 2>&1
```
- lưu và thoat file

# Nguồn tham khảo

https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-centos-7
https://www.digitalocean.com/community/tutorials/how-to-create-an-ssl-certificate-on-apache-for-centos-7

https://www.rosehosting.com/blog/how-to-install-lets-encrypt-with-apache-on-centos-7/
https://www.rosehosting.com/blog/how-to-install-lets-encrypt-with-apache-on-centos-7/