# Checklist sử dụng CPanel
# Mục Lục
[I. Hướng dẫn cài đặt Cpanel trên Centos7](https://github.com/thang290298/work-Document/blob/master/Linux/checklist-Cpanel-Centos7.md#i-h%C6%B0%E1%BB%9Bng-d%E1%BA%ABn-c%C3%A0i-%C4%91%E1%BA%B7t-cpanel-tr%C3%AAn-centos7)

[1. Đăng ký tài khoản dùng thử 15 ngày](https://github.com/thang290298/work-Document/blob/master/Linux/checklist-Cpanel-Centos7.md#1-%C4%91%C4%83ng-k%C3%BD-t%C3%A0i-kho%E1%BA%A3n-d%C3%B9ng-th%E1%BB%AD-15-ng%C3%A0y)

[2. Tiến hành cài đặt](https://github.com/thang290298/work-Document/blob/master/Linux/checklist-Cpanel-Centos7.md#2-ti%E1%BA%BFn-h%C3%A0nh-c%C3%A0i-%C4%91%E1%BA%B7t)

  - [2.1 cài đặt trên Centos 7](https://github.com/thang290298/work-Document/blob/master/Linux/checklist-Cpanel-Centos7.md#21-c%C3%A0i-%C4%91%E1%BA%B7t-tr%C3%AAn-centos-7)

  - [2.2 Cài đặt trên Portal](https://github.com/thang290298/work-Document/blob/master/Linux/checklist-Cpanel-Centos7.md#22-c%C3%A0i-%C4%91%E1%BA%B7t-tr%C3%AAn-portal)

[II. tìm hiểu tính năng trên Cpanel](https://github.com/thang290298/work-Document/blob/master/Linux/checklist-Cpanel-Centos7.md#ii-t%C3%ACm-hi%E1%BB%83u-t%C3%ADnh-n%C4%83ng-tr%C3%AAn-cpanel)

[1 Giới Thiệu](https://github.com/thang290298/work-Document/blob/master/Linux/checklist-Cpanel-Centos7.md#1-gi%E1%BB%9Bi-thi%E1%BB%87u)


[2 File Modules](https://github.com/thang290298/work-Document/blob/master/Linux/checklist-Cpanel-Centos7.md#2-file-modules)

[3. Quản lý domain – Tên miền](https://github.com/thang290298/work-Document/blob/master/Linux/checklist-Cpanel-Centos7.md#3-qu%E1%BA%A3n-l%C3%BD-domain--t%C3%AAn-mi%E1%BB%81n)

## I. Hướng dẫn cài đặt Cpanel trên Centos7
### 1. Đăng ký tài khoản dùng thử 15 ngày
- đăng ký tài khoản dùng thử 15 ngày tại [đây](https://cpanel.net/products/trial/)
- sau khi đăng kí dùng thử sẽ nhận được thông tin email thoong báo cài đặt dùng thử :


<img src="https://image.prntscr.com/image/DAH_b9r0QIGBcf-qJ9ZFXQ.png">

- kiểm tra thông tin phiên bản tại [đây](https://verify.cpanel.net/app/verify)


<img src="https://image.prntscr.com/image/PWQV_esGR-_b1zn5fBgpfw.png">

### 2. Tiến hành cài đặt
#### 2.1 cài đặt trên Centos 7
- ssh vào bằng tài khoản có quyền sudo
- Mặc định, cPanel sẽ không hỗ trợ Network Manager service. Do đó để có thể cài đặt được, bạn cần phải tắt service này đi theo các bước sau:
```
systemctl stop NetworkManager.service
systemctl disable NetworkManager.service
```
- để cài đặt tiến hành chạy lệnh
```
cd /home && curl -o latest -L https://securedownloads.cpanel.net/latest && sh latest
```
sau khi cài đặt thành công sẽ hiển thị thông tin đang nhập WHM

<img src="https://image.prntscr.com/image/V_Or8cQxQy_eiPdajiTgTQ.png">

đăng nhập bằng tài khoản `root` và tiến hành cấu hình cài đặt:

<img src="https://image.prntscr.com/image/PUXAMjaASIyML5306ruaeQ.png">

kết quả: 
<img src="https://image.prntscr.com/image/-0sgApEqQga6TlS3O9Qxjg.png">

#### 2.2 Cài đặt trên Portal
- Đăng nhập tài khoản Portal
- Chon Server muốn cài đặt và tiến hành rebuild server

<img src="https://image.prntscr.com/image/F7vkipxLQRmxRa8tQNa1qQ.png">
- tiến hành cài đặt Cpanel trên CentOS 7

<img src="https://image.prntscr.com/image/MDfCs0bzTc2rcwA93nlsSQ.png">
- sau khi cài đăt thành công bạn sẽ nhận được email thông tin 
<img src="https://image.prntscr.com/image/M4NK0jmAQpG5oC2xUvqw2A.png">
- Thực hiện setup trên WebGUi
```
https://45.117.80.147:2087
```
<img src="https://image.prntscr.com/image/_Hm2yr5MQlWYaOx1Y9I8vw.png">

## II. tìm hiểu tính năng trên Cpanel
### 1 Giới Thiệu
cPanel hosting là Linux web hosting đã có cài đặt sẵn cPanel. cPanel có ưu điểm và nhược điểm, nhưng với hầu hết các trường hợp, nó đều hoạt động hiệu quả. Vì vậy cPanel là lựa chọn tốt cho tất cả những ai đang tìm kiếm giải pháp control panel cho hosting. Bạn có thể tham khảo đánh giá của chúng tôi:
- Ưu điểm:
   - Dễ tìm hiểu
   - Dễ sử dụng
   - Tiết kiệm thời gian và tiền bạn
   - Đã được thử nghiệm kỹ càng
   - Có trình cài đặt tự động
   - Nhiều hướng dẫn/bài viết trên mạng
- Nhược điểm:
   - Có nhiều tính năng không cần thiết
   - Dễ vô tình thay đổi các thông số quan trọng mà
   - Một số host chạy bản cPanel cũ
   - Tốn kém hơn vì thường cPanel không đính kèm trong các gói hosting miễn phí
### 2 File Modules:
<img src="https://image.prntscr.com/image/Gn7ynH5oQci5Gd8QUy66Cw.png">

Những modules này cho phép bạn trực tiếp upload và quản lý file từ trong cPanel mà không cần tài khoản FTP client. Bạn có thể cài đặt mức độ bảo mật, backup và nhiều thứ khác. Những modules thông dụng nhất là:
   - Backup
   - Backup Wizard
   - Directory Privacy
   - Disk Usage
   - File Manager
   - Images
   - Web Disk
   - FTP Accounts
   - FTP Connections


### 3. Quản lý domain – Tên miền

<img src="https://image.prntscr.com/image/X5haGoMkRyWtmHbnHWUThQ.png">

  - Subdomains: Tên miền con
  - Addon Domain: Với cùng 1 tài khoản hosting có thể chạy thêm domain và website
  - Parker Domains : Cho phép chạy 1 site trên nhiều domain khác nhau
  - Redirects: Chuyển hướng domain
  - Zone Editor: Cập nhật các bản ghi DNS cho domain
  ### 4. E-mail

<img src="https://image.prntscr.com/image/lV-3Yad8S2OD202ahpmKFQ.png">

Không phải tất cả web hosting đều bao gồm email, nhưng nếu gói hosting của bạn có cả email và cPanel vậy thì phần này là để quản lý Email. Các modules thông dụng nhất là:
  - Address Importer
  - Apache SpamAssassin
  - Autoresponders
  - Default Address
  - Email Wizard
  - Encryption
  - Forwarders
  - Global Filters
  - MX Entry
  - Track Delivery
  - User Filters
### 5. Metrics
<img src="https://image.prntscr.com/image/46uORfV7SCyAKb91cm-Qlg.png">

Nếu bạn đang chạy một website và đang quan tâm đến thống kê truy cập của nó. Vậy bạn cần tìm đến khu vực Metrics này. Khu vực này để đưa ra cho bạn toàn bộ thông số thống kê mà có thể giúp bạn đánh giá website có hoạt động hiệu quả không. Các modules thông dụng là:
  - Awstats
  - Bandwidth
  - CPU and Concurrent Connection Usage
  - Errors
  - Raw Access
  - Visitors
  - Webalizer
  - Webalizer FTP
### 6. SECURITY

<img src="https://image.prntscr.com/image/GnVbVvTWSjW8aibTINbjQA.png">

Bảo mật là ưu tiên hàng đầu của nhiều webmaster, đặc biệt là nếu website của bạn chứa các thông tin nhạy cảm như usnername, password và thông tin tài chính. Module này sẽ giúp bạn quản lý các vấn đề liên quan đến bảo mật, làm website của bạn an toàn hơn. Các modules thông dụng nhất là:
  - Hotlink Protection
  - IP Blocker
  - Leech Protection
  - SSH Access
  - SSL/TLS
  - Let's Encrypt™ SSL

### 7. Software

<img src="https://image.prntscr.com/image/s75QmFaDQfC3RazXivOlLA.png">

Module này chủ yếu dùng nhiều các phần mềm PHP và Perl, người dùng thông thường không cần lắm những tính năng trong này. Các modules thông dụng nhất là:
  - Softaculpis Apps Installer
  - Optimize Website
  - Perl Modules
  - PHP PEAR Packages
  - CloudFlare
  - PHP Version Selector

### 8. Advanced

<img src="https://image.prntscr.com/image/-gs69L1xS7e0BS2pboPRsQ.png">

Như tiêu đề, những thông số này dành cho người dùng chuyên nghiệp. Các modules thông dụng nhất:
  
   - Apache Handlers
   - Cron Jobs
   - Error Pages
   - Indexes
   - MIME Types
   - Track DNS

### 9. Preferences

<img src="https://image.prntscr.com/image/nrYqUpsUTKax9VUQG3cSUQ.png">

Đây là nơi bạn tùy biến giao diện của cPanel để làm cho nó tiện nhìn hơn. Những modules thông dụng nhất là:
   - Change Language: đổi ngôn ngữ cPanel
   - Change Main Domain: đổi tên miền
   - Getting Started Wizard: quy trình khi mới dùng
   - Manage Resources: Quản lý tài nguyên
   - Shortcuts
   - Update Contact Info: cập nhật thông tin cá nhân
   - Video Tutorials: hướng dẫn bằng video
   









