# Tổng quan DirectAdmin
## I. Giới thiệu về DirectAdmin
### 1. DirectAdmin là gì?

 - DirectAdmin là một trong những Bảng điều khiển (Control Panel) dành cho người quản trị Web Hosting được ưa chuộng hiện nay với giao diện trực quan, dễ sử dụng. DirectAdmin cung cấp các tính năng như xem, thay đổi thiết lập phần cứng và phần mềm của máy chủ. Đồng thời nâng cao tính bảo mật và kiểm soát tài khoản người dùng. Điều tạo nên sự khác biệt giữa DirectAdmin và các hệ quản trị hosting khác là gì? 

<img src="https://github.com/thang290298/work-Document/blob/master/Images/DirectAdmin/directadmin-la-gi-khai-niem-ve-directadmin.jpg?raw=true">

 - DirectAdmin là một phần mềm quản trị được xây dựng trên nền tảng Linux
 - DirectAdmin hướng đến sự đơn giản, tiện dụng, tốc độ và sự ổn định. Nhưng vẫn có đầy đủ các tính năng cần thiết cho một quản trị hosting server. Đặc biệt khi sử dụng DirectAdmin, các nhiệm vụ đều sẽ được tự động hoá. Việc quản trị máy chủ và chia sẻ trang web sẽ được thực hiện một cách dễ dàng hơn.
### 2. Ưu và Nhược điểm của DirectAdmin
2.1 Ưu điểm.
- Các ưu điểm :
   - Phương thức sử dụng đơn giản
   - Tốc độ xử lý cực nhanh, ít tiêu tốn ít tài nguyên
   - Ổn định
   - Giá bản quyền thấp
   - Đảm bảo tính sẵn sàng cao: Hệ thống được phục hồi ở khoảng thời gian nhanh nhất hạn chế mức tối da thời gian hệ thống hoạt động không có hiệu quả.


2.2 Nhược điểm

Dĩ nhiên không có gì là hoàn hảo, dù có nhiều ưu điểm nhưng DirectAdmin vẫn tồn tại hai vấn đề sau:
  - Các tính năng chưa được hoàn thiện đầy đủ như cPanel hay một số phần mềm quản trị khác.
  - DirectAdmin không tương thích với dòng font unicode nên rất khó để để sửa khi file sử dụng các ngôn ngữ không phải là tiếng Anh.
### 3. Cấu hình tối thiểu
- Bộ xử lý: 500 MHz.
- Bộ nhớ: 1 GB, với ít nhất 2 GB bộ nhớ swap.
- Không gian ổ cứng: tối thiểu 2 GB không gian còn trống.
### 4. Tính năng và các cấp độ quản lý DirectAdmin
#### 4.1 Tính năng cho người quản trị (admin)
Admin là cấp cao nhất, có thể tạo các tài khoản Users, Resellers, Admin, có đầy đủ các quyền quản lý cũng như phần cấu hình trong máy chủ.
- Version 1.57.x
<img src="https://support.cloud365.vn/images/img-da-cloud-app/Screenshot_709.png">

<img src="https://support.cloud365.vn/images/img-da-cloud-app/screenshot_1.png">


   - Tạo và thay đổi các tài khoản quản lý và đại lý.
   -Gói dịch vụ: Tạo ra các gói tài nguyên cho các tài khoản đại lý và phân phối cho các tài khoản người dùng cuối.
   - Danh sách người dùng: Cho phép xem danh sách các tài khoản người dùng, sắp xếp và thay đổi thông tin.
   - Quản trị DNS: Tạo/ sửa/ xóa bất kỳ bản ghi DNS nào trên máy chủ.
   - Mục đích sử dụng IP: Cài đặt Ip trên máy chủ và quy định mục đích sử dụng IP cho các tài khoản người dùng cuối (IP chia sẻ hay Ip riêng).
   - Thông tin hệ thống: Truy cập tức thời tới thông tin và trạng thái hoạt động của các dịch vụ trên máy chủ.
   - Thống kê quá trình sử dụng: Thống kê các thông số trạng thái của hệ thống và các thông tin liên quan, thống kê về tài nguyên đã sử dụng.
#### 4.2 Tính năng cho đại lý (reseller)
Resellers là cấp đại lý, có thể tạo Users, phân phối tài nguyên và có các bảng điều khiển các user mình quản lý.
- Version 1.57.x
<img src="https://support.cloud365.vn/images/img-da-cloud-app/Screenshot_710.png">

- Version 1.59.x
<img src="https://support.cloud365.vn/images/img-da-cloud-app/screenshot_2.png">

   - Mục đích sử dụng IP: Cài đặt IP trên máy chủ và quy định sử dụng IP cho các tìa khoản người dùng cuối thông qua các tùy chọn có sẵn do quản trị hệ thống quy định ( IP chia sẻ hay Ip riêng).
   - Thống kê đối với tài khoản đại lý: Đại lý có thể xem thống kê đầu đủ tài nguyên sử dụng đối với tài khoản của mình và các khách hàng của mình, sắp xếp thông tin theo cá tình huống cần xử lý.
   - Tạo/ sửa tài khoản: Tạo tài khoản, danh sách, thay đổi/ sửa/ xóa một cách dễ dàng.
   - Gói tài nguyên: Đại lý có thể tạo các gói tài nguyên riêng của mình và áp dụng cho các khách hàng mà không cần quy định lại mỗi khi tạo tài khoản mới cho khác hàng.
   - Thông tin hệ thống: Truy cập tức thời tới thông tin về trạng thái hoạt động của các dịch vụ trên máy chủ.
   - Tạo ra thông tin máy chủ ảo của mình đối với khách hàng.
#### 4.3 Tính năng cho ngường dùng (user)
User là cấp quản lý hosting cho người dùng. Đây là mức thấp nhất trong DirectAdmin.
- Version 1.57.x
<img src="https://support.cloud365.vn/images/img-da-cloud-app/Screenshot_711.png">

- Version 1.59.x
<img src="https://support.cloud365.vn/images/img-da-cloud-app/screenshot_3.png">

   - Email: Tạo các tải khoản Emai, thiết lập các rule cho email trên tất cả cá tên miền do tài khoản quản lý như chuyển tiếp, tự động trả lời, tự động từ chối, lọc, bản ghi MX, webmail.
   - FTP: Tạo/sửa/xóa các tài khoản FTP
   - DNS: Thay đổi DNS, bản ghi A, bản ghi CNAME, bản ghi NS, bản ghi MX, bản ghi PTR.
   - Thống kê: Kiểm tra lượng tài nguyên đã sử dụng( dung lượng, băng thông), nhật ký truy cập site, xem các thông tin về tài khoản, sử dụng Phpmyadmin…
   - MS Frontpage: Tối ưu hóa việc sử dụng cá website tại bởi MS FrontPage
   - Tên miền phụ: Tạo/ xóa/ thống kê các tên miền phụ, tạo các tài khoản FTP cho từng tên miền phụ.
   - Trình quản lý file: Quản lý, sao chép, di chuyển, tổi tên, xóa và thay đổi quyền truy cập , sửa, tạo file.
   - CSDL MySQL: Tạo/ xóa CSDL, tạo các tài khoản có quyền truy cập, thay đổi mật khẩu truy cập, sử dụng PhpMyadmin
   - Tạo các bản sao lưu website đầy đủ, khôi phục dữ liệu website từ các bản sao lưu.
   - Bảo vệ thư mục: Người dùng có thể tạo các tài khoản và mật khẩu để hạn chế quyền truy cập vào một số thư mục nhất định.
   - Cài đặt xác thực SSL, xem các thông tin về máy chủ…
### 5. Backup/Restore Direct Admin
#### 5.1 Backup
- Bước 1: Đăng nhập Direct Admin với tài khoản user quản lý website
<img src="https://news.cloud365.vn/wp-content/uploads/2020/06/image-53-1024x649.png">
- Bước 2: Chọn `Backup/restore` Backups để tạo backup
<img src="https://news.cloud365.vn/wp-content/uploads/2020/06/image-54-1024x600.png">

- Bước 3: Chọn các mục muốn backup. Ở đây DA cho phép bạn backup toàn bộ dữ liệu từ tài khoản của bạn. Ở đây tôi chỉ backup website và database nên tôi chọn mục 1 và 2. Sau đó chọn Create backup để thực hiện backup
<img src="https://news.cloud365.vn/wp-content/uploads/2020/06/image-55-1024x570.png">

Đợi ít phút để hệ thống thực hiện backup.

Bạn có thể download file backup này về máy tính cá nhân của mình để thực hiện lưu trữ.
<img src="https://news.cloud365.vn/wp-content/uploads/2020/06/image-56-1024x641.png">

#### 5.2 Restore
- Bước 1: Đăng nhập vào bảng điều khiển DirectAdmin thông qua tài khoản admin
- Bước 2: Chọn mục Admin Backup/Transfer

<img src="https://github.com/thang290298/work-Document/blob/master/Images/DirectAdmin/admin_VPS_png.png?raw=true">

- Bước 3: Tại mục Restore Backup chọn User cần restore và ấn submit

<img src="https://github.com/thang290298/work-Document/blob/master/Images/DirectAdmin/restore_backup_png.png?raw=true">

# Nguồn tham Khảo
https://kb.nhanhoa.com/pages/viewpage.action?pageId=37454051

https://news.cloud365.vn/directadmin-huong-dan-backup-website-len-direct-admin-phan-4/

https://www.vietiso.com/ho-tro/vps-cloud/huong-dan-va-thu-thuat/huong-dan-restore-du-lieu-vps-trong-directadmin.html
