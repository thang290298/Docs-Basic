# Hướng dẫn Reset passwork quản trị Windown Server
## 1. Chuẩn bị
- Ta cần chuẩn bị một USB cài Boot Windows Server, USB từ 8GB trở lên để đáp ứng được dung lượng cả file ISO Windows Server.
- File ISO là bản cài Windows Server tương ứng với Windows Server hiện tại (2012, 2016,...)
- Phần mềm Rufus để cài USB boot, tham khảo [tại đây](https://quantrimang.com/huong-dan-tao-usb-boot-nhanh-94484)
## 2. Các bước thực hiện
- Bước 1: Boot máy chủ bằng USB boot vừa tạo
<img src="https://i.imgur.com/lzDF97V.png">
- Bước 2: Chọn "Next" và Chọn ”Repair your computer“
<img src="https://i.imgur.com/953FWgT.png">

- Bước 3: Chọn "Trouble Shoot"
<img src="https://i.imgur.com/sLOw73c.png">
- Bước 4: Chọn "Command Prompt" để mở cửa sổ lệnh của Windows
<img src="https://i.imgur.com/yUY3iHr.png">
- Bước 5: Xác định ổ chứa OS Windows Server

Ta phải xác định ổ chứa OS của Windows Server mà ta đã cài đặt, ví dụ trong bài này sẽ là ổ :/D

Các lệnh thực hiện:
```
d: cd windows\system32
ren Utilman.exe Utilman.exe.old
copy cmd.exe Utilman.exe
```
<img src="https://i.imgur.com/TwbCnHM.png">
- Bước 7: Tắt cửa sổ Command Prompt và nhấn Continue.
Sau khi Windows Server khởi động lại thành công, bạn nhấn tổ hợp phím Windows + U, tại màn hình đăng nhập để mở cửa sổ Command Prompt. Sau đó sử dụng lệnh sau:Sau khi Windows Server khởi động lại thành công, bạn nhấn tổ hợp phím Windows + U, tại màn hình đăng nhập để mở cửa sổ Command Prompt. Sau đó sử dụng lệnh sau:

```
net user administrator newpassword
```
Lưu ý: Bạn thay thế chuỗi "P@ssw0rd"của lệnh trên bằng chính mật khẩu mới của tài khoản Administrator.
<img src="https://i.imgur.com/YukOMj4.png">

Bây giờ, bạn có thể đăng nhập vào Windows Server bằng tài khoản quản trị với mật khẩu mới thay đổi.
# Nguồn tham khảo
https://blogchiasekienthuc.com/thu-thuat-may-tinh/cach-reset-mat-khau-windows-server.html