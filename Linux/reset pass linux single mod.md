# Reset pass linux
## 1. Khởi động lại hệ thống
– Khởi động lại hệ thống và tinh chỉnh chế độ GRUB2 ở màn hình boot GRUB2.
– Bấm nút ESC để màn hình dừng lại, sau đó ấn nút ‘e’ để thực hiện chỉnh sửa.
 <img src="https://i.imgur.com/I9q1wGB.jpg">
## 2. Chỉnh thông số entry cần thiết
– Tìm đến dòng entry cấu hình “linux16” hoặc “linuxefi” đối với hệ thống UEFI.
– Xoá 2 thông số “rhgb quiet” để kích hoạt log message hệ thống khi thực hiện đổi mật khẩu root.
– Thêm vào cuối dòng “linux16..” thông số sau.
```
rd.break
```