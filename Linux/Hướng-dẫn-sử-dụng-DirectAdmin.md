# Hướng dẫn sử dụng DirectAdmin dưới góc độ người dùng.
## I. Sủ dụng các tính năng có trên User: Admin
### 1. Server Management
- Create Admininstrator: tạo mới tài khoản quản trị Admin
<img src="https://image.prntscr.com/image/kn_YvQELTWutdHcXCv2EmQ.png">

  - Để tạo mới tài khoản Admin, điền đầy đủ thông tin :
    - tên user: tên đăng nhập
    - email: email người dùng
    - Password: chúng ta có thể tích chọn password random 

<img src="https://image.prntscr.com/image/pKYGj61ITveLZRBe99wkpw.png">

  - Sau khi tạo mới tài khoản chọn login để thay đổi mật khẩu: 

  <img src="https://image.prntscr.com/image/PIStvZJ-SlqyeuoE_nkX5g.png">

- List Managerment: hiển thị danh sách admin cùng tính năng thêm và xóa admin
<img src="https://image.prntscr.com/image/cGVYdB9tSzaXjUqXW74Syw.png">
  - để xóa user có thể tích chọn vào cột select và bấm chọn delete

- Change Pasword : thay đổi mật khẩu 
- Manage Tickets : quản lý các yêu cầu cần xử lý
- Create Reseller: Tạo mới tài khoản người dùng reseller
- List Resellers: Hiển thị danh sách người dùng reseller cùng tính năng thêm mói và xóa
- Manage Reseller Packages: Quản lý thêm mới sửa xóa các gói packages dành cho reseller ( mỗi tài khoản reseller đều được gán cho 1 gói packages, 1 gói packages có thể gán cho nhiều reseller)
- Show all user: hiển thị thông tin toàn bộ Admin, reseller và user và có thể xóa user

### 2. Admin Tools
- IP Management: Quản lý IP, nếu VPS của bạn có nhiều địa chỉ IP.
- DNS Administration: Quản lý DNS, có thể thay đổi danh sách máy chủ DNS tại đây
<img src="https://image.prntscr.com/image/N3h4GIa2QuupWJXOZUznJg.png">
- Admin Backup/Transfer: Thực hiện backup và Transfer các tài khoản
- Multi Server Setup: Cài đặt thiết lập kết nối nhiều server 
   - Nhập thông tin ip ( Tên miền ), port và tài khoản để kết nối
<img src="https://image.prntscr.com/image/B9IcynyxR6mxy-nMiny1Fg.png">

- Mail Queue Administration:  Quản lý email trong queue
- Move Users between Resellers: Di chuyển các user giữa các tài khoản reseller
<img src="https://image.prntscr.com/image/u96T1SzUR1ez5D9bmMH5vQ.png">
- System Information: Kiểm tra thông tin hệ thống
   
<img src="https://image.prntscr.com/image/5PZoyXYYQUicMKgkr4pwpw.png">

- Service Monitor: Kiểm tra các dịch vụ như MySQL; Apache; Exim, ... có thể chủ động khởi động lại các service này tại đây.
<img src="https://image.prntscr.com/image/r0PmkI4XSN6iCw3UxYaJbQ.png">

- System Backup: Thiết lập cấu hình backup
- Log Viewer: Xem log
- File Editor: Chỉnh sửa file
- Process Monitor: Giám sát các tiến trình đang xử lý.

### 3. Extra Feature

- Complete Usage Statistics: Thống kê mức độ sử dụng
- Custom HTTPD Configurations: Tối ưu tùy chỉnh cấu hình dịch vụ Apache cho hệ thống
- PHP SafeMode Configuration :Cấu hình safemode cho PHP
- Brute Force Monitor: Xem lịch sử các cuộc tấn công hoặc scan port.
- ConfigServer Firewall&Security :Cấu hình cài đặt firewall cho VPS
 

- Administrator Settings: Thiết lập một số chức năng quản trị
- Licensing / Updates :Update bản quyền
- Plugin Manager: Quản lý các plugin cài đặt.
- All User Cron Jobs: kiểm tra các crontab đang hoạt động trên hệ thống
## II. Sủ dụng các tính năng có trên User: Reseller
Sau khi đăng nhập vào tài khoản Reseller , bạn sẽ thấy tài khoản Reseller có giao diện như sau:
<img src="https://image.prntscr.com/image/bopHMkd3TKShCAtpW5ZpeA.png">
Khung bên phải màu xanh là thống kê về tài khoản Reseller của bạn. Cột Used hiển thị tổng số tài nguyên mà bạn đã dùng, Cột Max hiển thị tài nguyên tối đa mà tài khoản Reseller của bạn được phép sử dụng. Ý nghĩa của các thông số là:
- Disk space (MB): Dung lượng lưu trữ

- Bandwidth (MB): Băng thông hàng tháng

- E-mails: Số lượng tài khoản e-mail

- Ftp Accounts: Số lượng tài khoản FTP

- Databases: Số lượng cơ sở dữ liệu

- Domains: Số lượng tên miền

- Users: Số lượng người sử dụng
Khung bên trái có 3 mục chính, đó là:
### Account Management
- Account Management: Tạo và quản lý các gói( package) và người sử dụng( user)
<img src="https://image.prntscr.com/image/dpswHAo9RZ_7GPelg9nuig.png">

- Add New User: Thêm người dùng mới
 <img src="https://image.prntscr.com/image/WHfiAj1xS2iDfPkv9C3CRQ.png">
 - Trong đó:

   - Username: Tên của user, dùng để đăng nhập vào quản lý hosting của user đó.
   - E-mail: E-mail dùng để liên lạc với user đó, bao gồm việc gửi thông tin về tài khoản và các thông báo từ Reseller.
   - Enter Password: Đặt mật khẩu cho user.
   - Re-enter Password: Gõ lại mật khẩu cho user ( cần gõ chính xác với mật khẩu ở trên)
   - Domain: Tên miền của user.
   - Use User Package: Chọn gói cho user này.
   - IP; Chọn IP cho user, nếu không có IP riêng thì user sẽ sử dụng IP của share hosting.
   - Send Email Notification: Gửi thông tin về tài khoản cho user. Tùy chọn Edit User Message dùng để chỉnh sửa email mà bạn sẽ thông báo cho user này về thông tin tài khoản. Nếu bạn không muốn chỉnh sửa Email thông báo mặc định thì bỏ dấu tích ở tùy chọn này.

Sau đó bạn ấn vào `Submit `để hoàn thành việc tạo 1 user mới.

- List Users: Danh sách các người dùng đã tạo
- Manage Tickets: Quản lý các yêu cầu gửi bởi người dùng
- Add Package: Thêm gói mới 
- Manage User Packages: Quản lý các gói đã tạo
- Edit User Message: Chỉnh sửa thông báo gửi thông tin tài khoản cho người dùng

### Reseller Tools
- Reseller Toos: Các công cụ hỗ trợ Reseller như: thay đổi mật khẩu user, quản lý backup dữ liệu của user, thống kê tình trạng sử dụng băng thông, lưu trữ, cơ sở dữ liệu...
<img src="https://image.prntscr.com/image/UjV3mWviRDmtNrdkfV4R7Q.png">

- Change Passwords: Thay đổi mật khẩu của người dùng
- Reseller Statistics: Thống kê tình trạng sử dụng
- IP Management: Quản lý IP của các tài khoản
- Skin Manager: Thay đổi giao diện hiện tại
- Manage User Backups: Quản lý( sao lưu, phục hồi) dữ liệu của người dùng
- SSH key : tạo mới và quản lý key ssh
### Extra Features
- Extra Features: Các tính năng mở rộng như: Xem thông tin hệ thống, thay đổi NS, gửi thông báo cho toàn bộ user

<img src="https://image.prntscr.com/image/5UtlZGB6SNyaH2fNvMbqcA.png">

- System Info: Hiển thị thông tin hệ thống
- Nameservers: Thay đổi NS
- Message All Users: Gửi thông báo tới tất cả người dùng
- Contact Administrator: Liên hệ với quản trị viên
- ConfigServer Firewall&Security :Cấu hình cài đặt firewall cho VPS
## III. Sủ dụng các tính năng có trên User: người dùng khách hàng

Sau khi đăng ký hosting bạn sẽ nhận được một email gửi đầy đủ thông tin về đường link truy cập trang quản lý directadmin, username và mật khẩu để truy cập. Nếu tên miền của bạn đã được trỏ đến địa chỉ của server hosting thì bạn cũng có thể dùng đường link sau đây để login vào trang quản trị: http://tenmiencuaban:2222/ (bạn có thể tìm hiểu thêm về cách trỏ tên miền trong bài hướng dẫn quản trị tên miền)

<img src="https://image.prntscr.com/image/PCjb2MG9QZqSfZAk69bphA.png">

### 1. Your Account
- Domain setup: thiết lập tạo mới hoặc chỉnh sửa tên miền
<img src="https://image.prntscr.com/image/WSqn8iaiQ36fWpdM2rZlXw.png">

- Change passwd: Thay đổi mật khẩu người dùng
- Login History : lịch sử đăng nhập
- DNS Managerment : Quản lý bản ghi DNS
- Support Center: Gửi ticket hỗ trợ lên reseller
- Installed Perl Modules : danh sách Modules đã cài đặt
- Create/Restore Backups: tạo mới các bản  backup và restore dữ liệu
- Site Summary / Statistics / Logs: quản lý thông số và file logs
- 