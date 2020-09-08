# Tổng quan về DHCP
## 1. Khái Niệm
- DHCP (Dynamic Host Configuration Protocol) là giao thức cấu hình host động. Nó cung cấp cho máy tính địa chỉ ip ; subnet mask; default gateway. Và nó thường được cấp phát bởi DHPC server được tích hợp sẵn trên router.
- DHCP giao tiếp bằng UDP và sử dụng port 67 và 68. DHCP server sử dụng port 67 để nghe thông tin từ các client và sử dụng port 68 để reply thông tin
- Ưu điểm khi sử dụng DHCP
  - Tập trung quản trị thông tin cấu hình host
  - Cậu hình động các máy
  - Cấu hình IP cho các máy một cách liền mạch.
  - Sự linh hoạt
  - Đơn giản hóa vài trò quản trị của việc cauas hình địa chỉ IP của client.
- DHCP làm việc theo mô hình client server và thành phần chính của DHCP là:
  - DHCP client: Là thiết bị dùng để kết nối vào mạng
  - DHCP server: Là thiết bị dùng để cấp phát địa chỉ cho client
  <img src="https://blog.cloud365.vn/images/img-dhcp/screenshot.png"> 
## 2. Nguyên lý hoạt động DHCP
Thành phần chính của DHCP bao gồm 4 bản tin:
   - DISCOVERY
   - OFFER
   - REQUEST
   - ACK
Quá trình cấp phát địa chỉ IP trong giao thức DHCP bao gồm các bước sau
<img src="https://blog.cloud365.vn/images/img-dhcp/2019-04-09_10-01.png"> 
Kịch bản client xin cấp DHCP từ modem
