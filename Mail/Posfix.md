# Tổng quan về kiến trúc posfix

`Postfix` là chương trình mã nguồn mở và miễn phí (free and open-source) dùng để gửi thư điện tử (Mail Transfer Agent – MTA) được tạo ra ban đầu tại IBM với mục tiêu là thay thế chương trình gửi mail phổ biến là Sendmail Postfix được phát triển dựa trên mục tiêu là nhanh, dễ quản lý và bảo mật.

## 1. Cách Postfix nhận thư


- Khi một thư vào hệ thống thư Postfix, điểm dừng đầu tiên ở bên trong là hàng đợi đến . Hình bên dưới cho thấy các quy trình chính liên quan đến thư mới. Các tên được theo sau bởi một số là lệnh Postfix hoặc chương trình máy chủ, trong khi các tên không được đánh số bên trong vùng bóng mờ đại diện cho hàng đợi Postfix.

```

trivial-
rewrite(8)
Network	->	smtpd(8)		
^
|	|
v
\
Network	->	qmqpd(8)	->	cleanup(8)	->	incoming
/
pickup(8)	<-	maildrop
^
|
Local	->	sendmail(1)	->	postdrop(1)

```

- Thư mạng vào Postfix qua máy chủ smtpd hoặc qmqpd . Các máy chủ này loại bỏ việc đóng gói giao thức SMTP hoặc QMQP, thực thi một số kiểm tra tỉnh táo để bảo vệ Postfix và cung cấp cho người gửi, người nhận và nội dung thư cho máy chủ dọn dẹp . Máy chủ smtpd có thể được định cấu hình để chặn thư không mong muốn, như được mô tả trong tài liệu SMTPD_ACCESS_README 
- Các đệ trình cục bộ được nhận bằng lệnh tương thích Postfix sendmail và được xếp vào hàng đợi maildrop bằng lệnh postdrop đặc quyền . Sự sắp xếp này thậm chí hoạt động trong khi hệ thống thư Postfix không chạy. Máy chủ nhận cục bộ nhận các bài gửi cục bộ, thực thi một số kiểm tra tỉnh táo để bảo vệ Postfix và cung cấp cho người gửi, người nhận và nội dung thư tới máy chủ dọn dẹp.

- Các đệ trình cục bộ được nhận bằng lệnh tương thích Postfix sendmail (1) và được xếp vào hàng đợi maildrop bằng lệnh postdrop đặc quyền (1) . Sự sắp xếp này thậm chí hoạt động trong khi hệ thống thư Postfix không chạy. Máy chủ nhận cục bộ (8) nhận các bài gửi cục bộ, thực thi một số kiểm tra tỉnh táo để bảo vệ Postfix và cung cấp cho người gửi, người nhận và nội dung thư tới máy chủ dọn dẹp (8) .