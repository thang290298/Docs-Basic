# Hướng dẫn thay đổi Port SSH
- Vì một số lí do bảo mật, quý khách có nhu cầu thay đổi port SSH sang một port khác để tránh bị hacker khai thác hoặc bruteforce. Quý khách có thể tham khảo bài viết này để thay đổi.
- Bước 1: SSh vào máy chủ server với quyền root
- Bước 2: Kiểm tra port đang listen
Đầu tiên ta cần kiểm tra port nào đang được SSH mở sử dụng để listen các kết nối SSH vào máy chủ Linux.
```
# netstat -atnp | grep "ssh"
```
<img src="https://i.imgur.com/veNXobp.png">
Như output lệnh trên ay dodoì dịch vụ SSH đang sử dụng port số 22 (port SSH mặc định) để listen các kết nối đến.
- Bước 3: Thực hiện thay đổi port SSH trên Linux
  -  Trước mắt bạn cần xác định bạn sẽ sử dụng port số mấy cho sự thay đổi port SSH này. Mình lấy ví dụ là port số “292” nhé. Sau khi đã quyết định được số SSH port mới, thì ta cần kiểm tra xem có dịch vụ nào đang sử dụng port ‘292‘ không nhé.
```
# netstat -atnp | grep ":292"
```
  - Nếu output không có chương trình dịch vụ nào đang sử dụng thì tức port ‘292‘ có thể xài được. Giờ ta sẽ thực hiện edit file cấu hình dịch vụ SSH ‘/etc/ssh/sshd_config‘ dưới quyền user root.
```
  # vi /etc/ssh/sshd_config
```
  - Tìm kiếm dòng ‘#Port 22‘, bỏ dấu # ở đầu và thay bằng port bạn muốn dùng. Nếu trong file cấu hình đang xài port số khác thì thay nội dung “Port <number>” bằng số port bạn muôn. Ví dụ 292. Bạn nên tránh lựa chọn các port số thuộc dạng well-known port tức port thông dụng dành cho các dịch vụ khác.

  ```
  Port 292
  ```
  <img src="https://i.imgur.com/NxOFlSe.png">
    - Lưu lại file cấu hình và kiểm tra cú pháp cấu hình dịch vụ SSH, xem có chỉnh sửa cú pháp sai không. Nếu sai cú pháp thì sửa lại cho đúng rồi mới được làm tiếp.
```
sshd -t
```
- Bước 4: Mở Firewall rule cho port ssh mới
  - Nếu bạn đang sử dụng firewall trên hệ thống Linux thì bạn cần mở port cho phép các kết nối đến port SSH mới (292) cấu hình trước khi restart lại dịch vụ SSH. Ví dụ dưới là sử dụng firewall ‘iptables‘.
```
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 2345 -j ACCEPT
```

- Bước 5: Khởi động lại dịch vụ ssh và kiểm tra
```
    systemctl restart sshd
```
Tiến hành truy cập Server sử dụng dịch vụ ssh với port `292` qua ứng dụng mobaXterm

<img src="https://i.imgur.com/tOFCGKs.png">


Kết quả:
<img src="https://i.imgur.com/ujwDWH3.png">

# Nguồn tham khảo
https://cuongquach.com/thay-doi-port-ssh-tren-linux.html
