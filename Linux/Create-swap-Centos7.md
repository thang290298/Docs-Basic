# Tìm hiểu và cấu hình Swap trên CentOS 7
# Mục Lục

[1. Giới thiệu về Swap](https://github.com/thang290298/work-Document/blob/master/Linux/Create-swap-Centos7.md#1-gi%E1%BB%9Bi-thi%E1%BB%87u-v%E1%BB%81-swap)

[2. Kiểm tra Swap](https://github.com/thang290298/work-Document/blob/master/Linux/Create-swap-Centos7.md#2-ki%E1%BB%83m-tra-swap)

[3. Tạo Swap](https://github.com/thang290298/work-Document/blob/master/Linux/Create-swap-Centos7.md#3-t%E1%BA%A1o-swap)

[4.  Điều chỉnh giá trị Swappiness](https://github.com/thang290298/work-Document/blob/master/Linux/Create-swap-Centos7.md#4--%C4%91i%E1%BB%81u-ch%E1%BB%89nh-gi%C3%A1-tr%E1%BB%8B-swappiness)

[5. Xóa Swap](https://github.com/thang290298/work-Document/blob/master/Linux/Create-swap-Centos7.md#5-x%C3%B3a-swap)

[6. Nguồn tham khảo](https://github.com/thang290298/work-Document/blob/master/Linux/Create-swap-Centos7.md#6-ngu%E1%BB%93n-tham-kh%E1%BA%A3o)

## 1. Giới thiệu về Swap
- Swap hay còn được gọi là RAM ảo được sử dụng để hỗ trợ lưu trữ dữ liệu khi bộ nhớ vật lý (RAM) đã đầy. Đôi khi SWAP cũng được dùng song song để tăng dung lượng bộ nhớ đệm. SWAP thường dùng trên các hệ điều hành Linux, Ubuntu hoặc CentOS.
- Tại sao cần sử dụng Swap?
  - Một trong những trường hợp quan trọng cần đến Swap là khi RAM đầy. Theo đó, Swap sẽ hạn chế các sự cố liên quan đến vấn đề bảo mật thông tin, nhất là trong hệ thống điều hành Linux.
  - Swap rất cần thiết trong các hệ điều hành phổ biến hiện nay. Tuy nhiên khi nào bạn cần đến nó
  - Khi dùng một phần mềm yêu cầu hệ thống có hỗ trợ bộ nhớ Swap trong phần cài đặt (ví dụ: Oracle).
  - Khi muốn hoạt động của hệ thống ổn định hơn, đặc biệt quan trọng đối với các hệ thống không có nhiều dung lượng RAM.
  - Nếu bạn đang dùng Ubuntu, hệ điều hành này sẽ yêu cầu Swap cho chế độ ngủ đông.
## 2. Kiểm tra Swap
- Việc đầu tiên cần làm là kiểm tra xem hệ thống của các bạn đã có Swap hay chưa bằng cách chạy lệnh sau:
```
 # swappon --show
```
Nếu bạn không thấy kết quả nào được trả về, điều đó có nghĩa là hệ thống của bạn chưa có swap. Ngược lại nếu bạn thấy kết quả như ảnh dưới đây nghĩa là hệ thống của bạn đã có Swap và bạn không cần làm gì thêm

<img src="https://image.prntscr.com/image/EHFgud2wSHGRGxM7m3KHHw.png">

## 3. Tạo Swap
- Bước 1: Tạo Swap file

 chạy lệnh sau để tạo swapfile
```
     dd if=/dev/zero of=/swapfile bs=1024 count=2048k
```
- Bước 2: Phân quyền cho swapfile


 Để đảm bảo rằng chỉ người dùng root mới có thể đọc và ghi vào swap các bạn chạy lần lượt hai lệnh dưới đây:
```
     chown root:root /swapfile

     chmod 600 /swapfile    
```
- Bước 3: Kích hoạt Swapfile

 Tiếp theo, các bạn chạy lệnh sau để tạo phân vùng swap:
```
     mkswap /swapfile
```
 Chạy lệnh sau để kích hoạt swap:
```
     swapon /swapfile
```
- Bước 4: Thiết lập tự kích hoạt swapfile mỗi khi khởi động lại hệ thống

 Để phân vùng swap không bị mất mỗi khi khởi động lại hệ thống các bạn cần chỉnh sửa file /etc/fstab bằng cách chạy lệnh sau:
```
      echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```
 Để kiểm tra xem swap đã được kích hoạt hay chưa hãy dùng lệnh sau:
```
     free -h
```
<img src="https://image.prntscr.com/image/Cr0xgUUASdmuSRC7_utOwQ.png">

## 4.  Điều chỉnh giá trị Swappiness

- Swappiness là một thuộc tính nhân Linux xác định tần suất hệ thống sẽ sử dụng swap. Swappiness có thể có giá trị từ 0 đến 100.

- Giá trị Swappiness mặc định trên CentOS 7 là 30. Bạn có thể kiểm tra giá trị Swappiness hiện tại bằng cách nhập lệnh sau:
```
     cat /proc/sys/vm/swappiness
```
- Điều này có nghĩa hệ thống sẽ bắt đầu sử dụng swap khi Ram thật chỉ còn trống 30%. Để đặt giá trị swappiness thành 10, hãy chạy lệnh sau:
```
     sysctl vm.swappiness=10

```

- Để tham số này không bị thay đổi mỗi khi khởi động lại, hãy mở file /etc/sysctl.conf

    Thêm dòng sau vào cuối file và lưu lại
```
     vm.swappiness=10
```
<img src="https://image.prntscr.com/image/0TeLjP6DRb_PURJ3k9htQg.png">

- Tiếp theo các bạn mở file /usr/lib/tuned/virtual-guest/tuned.conf tìm và sửa vm.swappiness
```
     vi/usr/lib/tuned/virtual-guest/tuned.conf
```
<img src="https://image.prntscr.com/image/IgjKA3rCR6yDRFXWO8LiWQ.png">

## 5. Xóa Swap

Để hủy kích hoạt và xóa tệp hoán đổi, hãy làm theo các bước sau:

- Đầu tiên để hủy kích hoạt swap các bạn chạy lệnh sau:
```
     swapoff -v /swapfile
```
- Tiếp theo mở file /etc/fstab và xoá dòng dưới đây:
```
     /swapfile none swap sw 0 0
```
- Cuối cùng, xóa swapfile
```
     rm /swapfile
```
- Kiểm tra đã xóa thành công chưa bằng câu lệnh:
```
     swapon-- show
```
Nếu nó không xuất hiện gì thì bạn đã xóa thành công.

## 6. Nguồn tham khảo
https://github.com/phancong0897/Congphan/blob/master/Linux/swap-overview.md

https://blog.hostvn.net/chia-se/huong-dan-tao-swap-tren-centos-7.html