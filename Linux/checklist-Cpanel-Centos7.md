# Checklist sử dụng CPanel
# Mục Lục
[I. Hướng dẫn cài đặt Cpanel trên Centos7]
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

để kích hoạt phiên bản tiến hành chạy file `/usr/local/cpanel/cpkeyclt`
```
  cd /usr/local/cpanel
  sh ./cpkeyclt
```
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
### 2.1 File Modules:
<img src="https://image.prntscr.com/image/Gn7ynH5oQci5Gd8QUy66Cw.png">

Những modules này cho phép bạn trực tiếp upload và quản lý file từ trong cPanel mà không cần tài khoản FTP client. Bạn có thể cài đặt mức độ bảo mật, backup và nhiều thứ khác. Những modules thông dụng nhất là:
   - Backup
   - Backup Wizard
   - Directory Privacy
   - Disk Usage
   - File Manager
   - Images
   - Web Disk


### 2.1 Quản lý domain – Tên miền

<img src="https://image.prntscr.com/image/X5haGoMkRyWtmHbnHWUThQ.png">

  - Subdomains: Tên miền con
  - Addon Domain: Với cùng 1 tài khoản hosting có thể chạy thêm domain và website
  - Parker Domains : Cho phép chạy 1 site trên nhiều domain khác nhau
  - Redirects: Chuyển hướng domain




