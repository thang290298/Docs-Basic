# Tổng quan về TCP Wrappers
## 1. TCP Wrappers là gì ?
- Các TCP Wrapper là danh sách điều kiển truy cập (ACL - Access Control List) dựa trên máy, sử dụng để lọc truy cập mạng với các dịch vụ địa phương
- chúng xuất hiện vào những năm 1990 để bảo vệ các máy trạm Unix khỏi các cuộc tấn công mạng
- Ưu điểm : TCP / Wrappers có một lợi thế lớn so với tường lửa thông thường: chúng hoạt động trong lớp 7 (Ứng dụng), do đó, chúng có thể, trong số những thứ khác, có thể lọc các truy vấn ngay cả khi sử dụng mã hóa.
- Nhược điểm : Tất cả các ứng dụng dịch vụ Unix phải được biên dịch để hoạt động với thư viện libwrap. Wrappers không hoạt động với các dịch vụ gọi thủ tục từ xa (RPC) qua TCP).
## Cài đặt TCP Wrappers

- TCP Wrappers có sẵn trong kho chính thức của hầu hết các hệ điều hành Linux.
- Cài đặt tcp_wrapper trên centos7
```
# sudo apt-get install tcp_wrappers
```
## Hạn chế quyền truy cập vào máy chủ Linux bằng các sử dụng TCP Wrappers

### Cấu hình
- TCP Wrappers thực hiện kiểm soát truy cập với sự trợ giúp của hai tệp cấu hình: /etc/hosts.allow và /etc/hosts.deny .Hai tệp danh sách kiểm soát truy cập này quyết định liệu các máy khách cụ thể có được phép truy cập máy chủ Linux của bạn hay không.
    - /etc/hosts.allow : Tệp này chứa tên của các máy chủ được phép sử dụng các dịch vụ mạng.
    - /etc/hosts.deny : Tệp này chứa tên của máy chủ không thể sử dụng dịch vụ mạng.
    - Nếu cùng một máy khách, người dùng hoặc ip được liệt kê trong cả hai tệp, hosts.allow có mức độ ưu tiên hơn hosts.deny, hãy cẩn thận với điều này.

- Cú pháp của tệp hosts.allow và hosts.deny
   - Cú pháp các tệp lệnh như sau:
   ```
   list_of_service : list_of _ client [ : lệnh _ shell ]
   ```
Trong đó:
  - service_list là danh sách các tên tiến trình của trình nền cần xem xét.
  - client_list là danh sách tên máy chủ, địa chỉ IP, mẫu đặc biệt hoặc ký tự đại diện sẽ được so sánh với từng máy khách được kết nối.

#### Cách tiếp cận được đề xuất để bảo mật máy chủ của bạn
- Để bảo mật máy chủ Linux là chặn tất cả các kết nối đến và chỉ cho phép một vài máy chủ hoặc mạng cụ thể. Để làm như vậy, chỉnh sửa tệp /etc/hosts.deny :

```
sudo vi /etc/hosts.deny
```
thêm dòng sau. Dòng này từ chối kết nối tất cả dịch vụ và tất cả các mạng
```
   ALL:ALL
```
<img src="https://image.prntscr.com/image/0xrXFaU-T4SbMqn3e5yU0w.png">

- sau đó chỉnh sửa tệp `etc/hosts.allow`
```
sudo vi /etc/hosts.allow
```
Thêm địa chỉ mạng muốn kết nối:
```
.sshd : 192.168.18.1
```
Theo quy tắc trên, tất cả các kết nối đến sẽ bị từ chối cho tất cả các máy chủ ngoại trừ máy chủ 192.168.18.1.
<img src="https://image.prntscr.com/image/YcRX9DN4SiORr2SqIdNXqQ.png">

- Bạn có thể xác minh điều này từ các tệp nhật ký của máy chủ Linux của bạn như hiển thị bên dưới.
```
cat /var/log/secure
```


- Bạn có thể cho phép các kết nối đến từ tất cả các máy chủ, nhưng không phải từ một máy chủ cụ thể. Ví dụ, để cho phép các kết nối đến từ tất cả các máy chủ trong mạng con 192.168.18. , nhưng không phải từ máy chủ 192.168.18.137 , hãy thêm dòng sau vào tệp /etc/hosts.allow .
```
ALL: 192.168.18. EXCEPT 192.168.18.137
```