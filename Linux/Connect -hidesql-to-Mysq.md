# Hướng dẫn kết nối hideSql tới MySql
- HeidiSQL là một công cụ tất cả trong một để quản lý, phát triển và quản trị cơ sở dữ liệu
## 1. Cấp phép kết nối từ xa đến MySql thông qua IP 
<img src="https://github.com/thang290298/work-Document/blob/master/Images/1.png?raw=true"> 

## 2. Thu thập chi tiết cơ sở dữ liệu MySql
- Vì chúng ta đã định vị tên máy chủ MySQL từ xa ở bước trước, chúng ta sẽ chỉ cần  tên cơ sở dữ liệu và người dùng .
<<<<<<< HEAD
<img src="https://image.prntscr.com/image/ZattBWIIRdCIE8Zd2ieMcA.png">

- Sử dụng thông tin Database và User để truy cập từ xa

<img src="https://i.imgur.com/biTsGRg.png">

## 3. Cấu hình kết nối máy khách HeidiSQL
- Mở máy khách cơ sở dữ liệu và nhấn `Mới` để tạo mục nhập.
-Sau đó, bạn sẽ cần đặt tên cho mục nhập và điền vào cấu hình cơ sở dữ liệu MySQL.

<img src="https://i.imgur.com/om6xUdK.png">

Đảm bảo hoàn thành các trường sau:

- Loại mạng - đặt nó thành MySQL (TCP / IP).
- Tên máy chủ / IP - nhập tên máy chủ MySQL từ xa ở bước 1 của hướng dẫn này.
- Người dùng - Nhập người dùng cơ sở dữ liệu MySQL ở bước 2.
- Mật khẩu - Điền mật khẩu người dùng.
- Cổng - Cổng MySQL mặc định cho các kết nối cục bộ và từ xa là 3306 .
- Cơ sở dữ liệu - Nhập tên cơ sở dữ liệu MySQL được tìm thấy trong bước 2.

Sau khi hoàn tất, hãy nhấn nút Mở và bạn sẽ ở bên trong cơ sở dữ liệu của mình.

<img src="https://i.imgur.com/1Jij9B2.png">

Xin chúc mừng! Giờ đây, bạn có thể truy cập cơ sở dữ liệu của mình từ xa bằng ứng dụng HeidiSQL.

# Nguồn Tham khảo
https://www.hostinger.com/tutorials/heidisql-remote-mysql-connection
