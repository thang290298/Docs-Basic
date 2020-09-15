# Tổng quan syslog, Rsyslog,Webserver


## I. Log là gì?
- Log ghi lại liên tục các thông báo về hoạt động của cả hệ thống hoặc của các dịch vụ được triển khai trên hệ thống và file tương ứng.

- Các file log có thể nói cho bạn bất cứ thứ gì bạn cần biết, để giải quyết các rắc rối mà bạn gặp phải miễn là bạn biết ứng dụng nào. Mỗi ứng dụng được cài đặt trên hệ thống có cơ chế tạo log file riêng của mình để bất cứ khi nào bạn cần thông tin cụ thể thì các log file là nơi tốt nhất để tìm.

- Các tập tin log được đặt trong thư mục /var/log. Bất kỳ ứng dụng khác mà sau này bạn có thể cài đặt trên hệ thống của bạn có thể sẽ tạo tập tin log của chúng tại /var/log. Dùng lệnh ls -l /var/log để xem nội dung của thư mục này.

- Ý nghĩa một số file log thông dụng có mặc định trên /var/log

    - /var/log/messages – Chứa dữ liệu log của hầu hết các thông báo hệ thống nói chung, bao gồm cả các thông báo trong quá trình khởi động hệ thống.

    - /var/log/cron – Chứa dữ liệu log của cron deamon. Bắt đầu và dừng cron cũng như cronjob thất bại.

    - /var/log/maillog hoặc /var/log/mail.log – Thông tin log từ các máy chủ mail chạy trên máy chủ.

    - /var/log/wtmp – Chứa tất cả các đăng nhập và đăng xuất lịch sử.

    - /var/log/btmp – Thông tin đăng nhập không thành công

    - /var/run/utmp – Thông tin log trạng thái đăng nhập hiện tại của mỗi người dùng.

    - /var/log/dmesg – Thư mục này có chứa thông điệp rất quan trọng về kernel ring buffer. Lệnh dmesg có thể được sử dụng để xem các tin nhắn của tập tin này.

    - /var/log/secure – Thông điệp an ninh liên quan sẽ được lưu trữ ở đây. Điều này bao gồm thông điệp từ SSH daemon, mật khẩu thất bại, người dùng không tồn tại, vv

## 2. Tổng quan Syslog

- Syslog là một giao thức client/server là giao thức dùng để chuyển log và thông điệp đến máy nhận log. Máy nhận log thường được gọi là syslogd, syslog daemon hoặc syslog server. Syslog có thể gửi qua UDP hoặc TCP. Các dữ liệu được gửi dạng cleartext. Syslog dùng port 514.

- Trong chuẩn syslog, mỗi thông báo đều được dán nhãn và được gán các mức độ nghiêm trọng khác nhau. Các loại phần mềm sau có thể sinh ra thông báo: auth, authPriv, daemon, cron, ftp, dhcp, kern, mail, syslog, user,… Với các mức độ nghiêm trọng từ cao nhất trở xuống Emergency, Alert, Critical, Error, Warning, Notice, Info, and Debug.

### Mục đích của Syslog

- Syslog được sử dụng như một tiêu chuẩn, chuyển tiếp và thu thập log được sử dụng trên một phiên bản Linux. Syslog xác định mức độ nghiêm trọng (severity levels) cũng như mức độ cơ sở (facility levels) giúp người dùng hiểu rõ hơn về nhật ký được sinh ra trên máy tính của họ. Log (nhật ký) có thể được phân tích và hiển thị trên các máy chủ được gọi là máy chủ Syslog.

### Định dạng tin nhắn Syslog?

<img src="https://imgur.com/UWD0oNw.png">

- Định dạng nhật ký hệ thống được chia thành ba phần, độ dài một thông báo không được vượt quá 1024 bytes:

    - PRI : chi tiết các mức độ ưu tiên của tin nhắn (từ tin nhắn gỡ lỗi (debug) đến trường hợp khẩn cấp) cũng như các mức độ cơ sở (mail, auth, kernel).

    - Header: bao gồm hai trường là TIMESTAMP và HOSTNAME, tên máy chủ là tên máy gửi nhật ký.

    - MSG: phần này chứa thông tin thực tế về sự kiện đã xảy ra. Nó cũng được chia thành trường TAG và trường CONTENT.

- Cấp độ cơ sở Syslog (Syslog facility levels)

    - Một mức độ cơ sở được sử dụng để xác định chương trình hoặc một phần của hệ thống tạo ra các bản ghi.

    - Theo mặc định, một số phần trong hệ thống của bạn được cung cấp các mức facility như kernel sử dụng kern facility hoặc hệ thống mail của bạn bằng cách sử dụng mail facility.

    - Nếu một bên thứ ba muốn phát hành log, có thể đó sẽ là một tập hợp các cấp độ facility được bảo lưu từ 16 đến 23 được gọi là “local use” facility levels.

    - Ngoài ra, họ có thể sử dụng tiện ích của người dùng cấp độ người dùng (“user-level” facility), nghĩa là họ sẽ đưa ra các log liên quan đến người dùng đã ban hành các lệnh.

- Mức độ cảnh báo của Syslog?

    - Mức độ cảnh báo của Syslog được sử dụng để mức độ nghiêm trọng của log event và chúng bao gồm từ gỡ lỗi (debug), thông báo thông tin (informational messages) đến mức khẩn cấp (emergency levels).

    - Tương tự như cấp độ cơ sở Syslog, mức độ cảnh báo được chia thành các loại số từ 0 đến 7, 0 là cấp độ khẩn cấp quan trọng nhất.

## 3. Rsyslog

- Rsyslog là một sự phát triển của syslog, cung cấp các khả năng như các mô đun có thể cấu hình, được liên kết với nhiều mục tiêu khác nhau (ví dụ chuyển tiếp nhật ký Apache đến một máy chủ từ xa).

- Rsyslog cũng cung cấp tính năng lọc riêng cũng như tạo khuôn mẫu để định dạng dữ liệu sang định dạng tùy chỉnh.

- Rsyslog có thiết kế kiểu mô-đun. Điều này cho phép chức năng được tải động từ các mô-đun, cũng có thể được viết bởi bất kỳ bên thứ ba nào. Bản thân Rsyslog cung cấp tất cả các chức năng không cốt lõi như các mô-đun. Do đó, ngày càng có nhiều mô-đun. Có 6 modules cơ bản:

    - Output Modules

    - Input Modules

    - Parser Modules

    - Message Modification Modules

    - String Generator Modules

    - Library Modules
## 4. Log Web Server
### 4.1. access log

- Các access log máy chủ ghi lại tất cả các yêu cầu xử lý bởi máy chủ. Các vị trí và nội dung của access log được kiểm soát bởi CustomLog. Các LogFormat chỉ có thể được sử dụng để đơn giản hóa việc lựa chọn các nội dung của các bản ghi. Phần này mô tả làm thế nào để cấu hình các máy chủ để ghi lại thông tin trong access log. 
#### 4.1.1 Common Log Format 
Một cấu hình điển hình cho các access log có thể như sau. 
```
LogFormat "%h %l %u %t \"%r\" %>s %b" common  
CustomLog logs/access_log common 

```
- Các CustomLog thành lập một file log mới sử dụng biệt danh được xác 
định. Các tên tập tin cho access log là tương đối so với ServerRoot trừ khi nó bắt đầu với một dấu gạch chéo. 
Mỗi một phần của dòng log này được mô tả dưới đây: 
  - `%h`: IP máy khách ( Máy chủ tù xa)
  - `- (%l)`:Những "gạch nối" ở đầu ra cho thấy rằng các mảnh yêu cầu các thông tin không có sẵn.  
  - `%u`: Đây là userid của người yêu cầu các tài liệu được xác định bằng cách xác thực HTTP.  
  - `%t`: time zone
  - Thời gian mà máy chủ đã hoàn thành xử lý yêu cầu. Định dạng là: 
  ```
  [day/month/year:hour:minute:second zone]  
  day = 2*digit  
  month = 3*letter  
  year = 4*digit  
  hour = 2*digit  
  minute = 2*digit  
  second = 2*digit  
  zone = (`+' | `-') 4*digit 
  ``` 
  - `%r`: Dòng yêu cầu từ khách hàng được đưa ra trong dấu ngoặc kép
  - `%>s`: Đây là mã trạng thái mà máy chủ gửi lại cho khách hàng
  - `%b`:Các mục cuối cùng chỉ ra kích thước của đối tượng trả lại cho khách hàng, không bao gồm các tiêu đề ứng. Nếu không có nội dung được trả lại cho khách hàng, giá trị này sẽ được " - ". Để đăng nhập " 0 " cho không có nội dung, sử dụng %B để thay thế.
  #### 4.1.2 Combined Log Format  
  Một chuỗi định dạng thường được sử dụng được gọi là Combined Log Format. Nó có thể được sử dụng như sau. 
  ```
  LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{Useragent}i\"" combined 
CustomLog log/acces_log combined 

```
171.224.179.102 - - [14/Sep/2020:21:51:15 +0700] "GET /wp-admin/admin-ajax.php?action=wp-compression-test&test=yes&_ajax_nonce=ab3825d19c&1600095075896 HTTP/1.1" 200 1 "http://learning365.online/wp-admin/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36 Edg/85.0.564.51"

```
Các trường bổ sung là: 
```
"http://learning365.online/wp-admin/" (\"%{Referer}i\") 

"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36 Edg/85.0.564.51" (\"%{User-agent}i\") 
```

  
- Cấu hình trên sẽ viết entry bản ghi trong một định dạng được gọi là Common Log Format (CLF). Định dạng chuẩn này có thể được sản xuất bởi nhiều máy chủ web khác nhau và đọc bởi nhiều chương trình phân tích log. Các mục file bản ghi sản xuất tại CLF sẽ giống như thế này: 
```
171.224.179.102 - - [14/Sep/2020:21:50:07 +0700] "GET /wp-admin/css/forms.min.css?ver=5.5.1 HTTP/1.1" 200 24500 

```
   - Apache:
<img src="https://image.prntscr.com/image/SCXb5CHATlmzsmt9gz627w.png">

   - Nginx:
<img src="https://image.prntscr.com/image/YjbatdByS3mbCla5o1kQTg.png">   

### 4.2. error log
- Các error log máy chủ, tên và vị trí được thiết lập bởi ErrorLog, là log file rất quan trọng. Đây là nơi mà Apache httpd sẽ gửi thông tin chẩn đoán và ghi lại bất kỳ lỗi nào mà nó gặp trong các yêu cầu xử lý. Đây là nơi đầu tiên để xem xét khi một vấn đề xảy ra với khởi chạy máy chủ hoặc với những hoạt động của máy chủ, vì nó sẽ thường chứa các thông tin chi tiết về những gì đã xảy ra và làm thế nào để sửa chữa nó. 
  - Apache:
```
[Tue Sep 15 06:34:34.895098 2020] [authz_core:error] [pid 10874] [client 192.241.227.222:56358] AH01630: client denied by server configuration: /etc/httpd/var

```
   - Nginx:
```
2020/09/15 11:23:11 [error] 1807#0: *2 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 192.168.18.1, server: _, request: "GET /favicon.ico HTTP/1.1", host: "192.168.18.179", referrer: "http://192.168.18.179/"

```
- Mục đầu tiên trong mục ghi là ngày và thời gian của tin nhắn. Các mục thứ hai liệt kê mức độ nghiêm trọng của lỗi được báo cáo. Các LogLevel chỉ được sử dụng để kiểm soát các loại lỗi được gửi đến các error log bằng cách hạn chế mức độ nghiêm trọng. Các mục thứ ba cung cấp cho các địa chỉ IP của client đã tạo ra lỗi. Ngoài ra là thông điệp chính nó, mà trong trường hợp này chỉ ra rằng các máy chủ đã được cấu hình để từ chối truy cập từclient. Các máy chủ báo cáo các đường dẫn tập tin hệ thống (như trái ngược với con đường web) của tài liệu được yêu cầu. 
- Dưới đây là các mức độ nghiêm trọng của syslog được mô tả :
  - Emergency: Thông báo tính trạng khẩn cấp
  - Alert: Hệ thống cần can thiệp ngay
  - Crit: Tình trạng nguy kịch
  - err: Thông báo lỗi với hệ thống
  - Warning: Mức cảnh báo đối với hệ thống
  - notice : Chú ý dối với hệ thống
  - debug: Quá trình kiểm tra hệ thống

Trong thời gian thử nghiệm, nó thường hữu ích để liên tục theo dõi các error log cho bất kỳ vấn đề. Trên các hệ thống Unix, bạn có thể thực hiện điều này bằng cách sử dụng: 
```
cách sử dụng: 
tail -f error_log 

```
