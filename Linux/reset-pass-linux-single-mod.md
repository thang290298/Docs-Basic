# Mục Lục
[Reset pass root single-mod linux](#resetpas)
- [1. Khởi động lại hệ thống](#restart)
- [2. Chỉnh thông số entry cần thiết](#edit)
- [3. remount filesystem và chuyển chế độ chroot](#remount)
- [4. relabel SELINUX](#relabel)
- [5. remount và reboot](#reboot)
- [6. Nguồn tham khảo ](#nguonthamkhao)
<a name="resetpass"></a>

# Reset pass root single-mod linux
<a name="restart"></a>

## 1. Khởi động lại hệ thống
– Khởi động lại hệ thống và tinh chỉnh chế độ GRUB2 ở màn hình boot GRUB2.
– Bấm nút ESC để màn hình dừng lại, sau đó ấn nút ‘e’ để thực hiện chỉnh sửa.
 <img src="https://i.imgur.com/I9q1wGB.jpg">
 <a name="edit"></a

## 2. Chỉnh thông số entry cần thiết
– Tìm đến dòng entry cấu hình “linux16” hoặc “linuxefi” đối với hệ thống UEFI.

– Xoá 2 thông số “rhgb quiet” để kích hoạt log message hệ thống khi thực hiện đổi mật khẩu root.
– Thêm vào cuối dòng “linux16..” thông số sau.
```
rd.break
```

 <img src="https://i.imgur.com/LpkoQZT.jpg">
 – Ấn Ctrl+X để lưu và tự động boot vào môi trường initramfs.
 <img src="https://i.imgur.com/8Ij7blg.jpg">
 
<a name="remount"></a>

 ## 3. remount filesystem và chuyển chế độ chroot
 – Hệ thống filesystem hiện tại đang ở chế độ “read only” được mount ở thư mục /sysroot/, để thực hiện khôi phục mật khẩu root thì ta cần thêm quyền ghi (write) trên filesystem. Ta sẽ tiến hành remount lại filesystem /sysroot/ với quyền đọc-ghi (read-write).
 – Kiểm tra lại xem filesystem đã được remount quyền đọc-ghi hay chưa.
 ```
switch_root:/# mount -o remount, rw /sysroot
switch_root:/# mount | grep -w “/sysroot“

```
 <img src="https://i.imgur.com/8ztYoui.jpg">
 – Lúc này filesystem đã được mount và ta sẽ chuyển đổi sang môi trường filesystem (prompt: sh-4.2#).

 ```
switch_root:/# chroot /sysroot

```
– Tiến hành reset password user root.
<img src="https://i.imgur.com/tigphc3.png">
<a name="relabel"></a

## 4. relabel SELINUX
– Chạy lệnh sau để update lại các thông số cấu hình SELINUX, nếu bạn có sử dụng SELINUX. Nguyên nhân khi ta update file /etc/passwd chứa mật khẩu thì các thông số SELINUX security contex sẽ khác nên cần update lại.

 ```
sh-4.2# touch /.autorelabel

```
<a name="reboot"></a

## 5. remount và reboot
– Remount filesystem “/“ ở chế độ read-only.
 ```
sh-4.2# mount -o remount, ro /
```
– Thoát môi trường chroot và Khởi động lại hệ thống.
```
sh-4.2# exit
switch_root:/# exec /sbin/reboot
```
<img src="https://i.imgur.com/7Jl96IU.png">
<a name="nguonthamkhao"></a>

## 6. Nguồn tham khảo
https://cuongquach.com/khoi-phuc-mat-khau-root-tren-centos7-rhel7.html