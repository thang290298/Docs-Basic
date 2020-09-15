# Tổng quan log Webserver
Trong việc quản một máy chủ web hiệu quả, log file là rất cần thiết để thu
được thông tin phản hồi về hoạt động và hiệu suất của máy chủ cũng như bất kỳ
vấn đề có thể được xảy ra. Apache HTTP Server cung cấp khả năng khai thác log
rất toàn diện và linh hoạt.

- cấu trúc log Webserver Apache:
  - access log
  - error log
  ## Apache
  ### 1. access log

- Các access log máy chủ ghi lại tất cả các yêu cầu xử lý bởi máy chủ. Các vị trí và nội dung của access log được kiểm soát bởi CustomLog. Các LogFormat chỉ có thể được sử dụng để đơn giản hóa việc lựa chọn các nội dung của các bản ghi. Phần này mô tả làm thế nào để cấu hình các máy chủ để ghi lại thông tin trong access log. 
#### 1.1 Common Log Format 
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
  #### 1.2 Combined Log Format  
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
<img src="https://image.prntscr.com/image/SCXb5CHATlmzsmt9gz627w.png">

### 2. error log
- Các error log máy chủ, tên và vị trí được thiết lập bởi ErrorLog, là log file rất quan trọng. Đây là nơi mà Apache httpd sẽ gửi thông tin chẩn đoán và ghi lại bất kỳ lỗi nào mà nó gặp trong các yêu cầu xử lý. Đây là nơi đầu tiên để xem xét khi một vấn đề xảy ra với khởi chạy máy chủ hoặc với những hoạt động của máy chủ, vì nó sẽ thường chứa các thông tin chi tiết về những gì đã xảy ra và làm thế nào để sửa chữa nó. 
```
[Tue Sep 15 06:34:34.895098 2020] [authz_core:error] [pid 10874] [client 192.241.227.222:56358] AH01630: client denied by server configuration: /etc/httpd/var

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

## 2. Nginx
