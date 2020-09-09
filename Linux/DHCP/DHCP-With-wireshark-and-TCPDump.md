# Phân tích gói tin bằng WireShark và Tcpdump
## 1. Phân tích gói tin DHCP bằng Wireshark

### Giới thiệu Wireshark.
- Wireshark, hay còn gọi là Ethereal, công cụ này có lẽ không quá xa lạ với phần lớn người sử dụng chúng ta, vốn được xem là 1 trong những ứng dụng phân tích dữ liệu hệ thống mạng, với khả năng theo dõi, giám sát các gói tin theo thời gian thực, hiển thị chính xác báo cáo cho người dùng qua giao diện khá đơn giản và thân thiện. Trong bài viết dưới đây, chúng tôi sẽ giới thiệu với các bạn một số đặc điểm cơ bản cũng như cách dùng, phân tích và kiểm tra hệ thống mạng bằng Wireshark.
- Sau đây là những ví dụ về sử dụng wireshark để bắt gói tin DHCP
<img src="https://image.prntscr.com/image/EFSfKoqAQXycBPvf_aT9ow.png">

- DHCP ACK

<img src="https://image.prntscr.com/image/Iv5teaOiTCamPNn_kXVbiw.png">
  - option (53): Kiểu tin nhắn.
  - option (54): DHCP server
  - option (51): thời gian cấp địa chỉ IP.
  - option (1) : subnet mask.
  - option (28): địa chỉ broacast.
  - option (15): Domain Name.
  - option (6) : DNS.
  - option (3) : Deafault gateway.

- DHCP request
<img src="https://image.prntscr.com/image/RCQ7FUQ7SWOpNqga9qvSZw.png">
  - option (53): Kiểu tin nhắn.
  - option (54): DHCP server
  - option (50): địa chỉ IP yêu cầu (192.168.18.169)
  - option (55): Danh sách tham số yêu cầu

- DHCP Offer
<img src="https://image.prntscr.com/image/ioRDivc3RH6nve97wdAtbA.png">
  - option (53): Kiểu tin nhắn.
  - option (54): DHCP server
  - option (51): thời gian cấp địa chỉ IP.
  - option (1) : subnet mask.
  - option (28): địa chỉ broacast.
  - option (15): Domain Name.
  - option (6) : DNS.
  - option (3) : Deafault gateway.

- DHCP Discover
 <img src="https://image.prntscr.com/image/2PyasXGIRG29Sh5qsvcn5Q.png">

  - option (53): Kiểu tin nhắn.
  - option (50): địa chỉ IP yêu cầu (192.168.18.169)
  - option (55): Danh sách tham số yêu cầu

## 2. Phân tích gói tin DHCP bằng TCPDUMP

### Giới thiệu về TCPDUMP
- TCPDUMP là gì ?

  - TCPDUMP thực chất là công cụ được phát triển nhằm mục đích nhận diện và phân tích các gói dữ liệu mạng theo dòng lệnh. TCPDUMP cho phép khách hàng chặn và hiển thị các gói tin được truyền đi hoặc được nhận trên một mạng có sự tham gia của máy tính.

  - Hiểu đơn giản, TCPDUMP là phần mềm bắt gói tin trong mạng làm việc trên hầu hết các phiên bản hệ điều hành unix/linux. Tcpdump cho phép bắt và lưu lại những gói tin bắt được, từ đó chúng ta có thể sử dụng để phân tích.
  - TCPDUMP được xem là trụ cột trong việc gỡ rối và kiểm tra vấn đề kết nối mạng và bảo mật.

<img src="https://image.prntscr.com/image/2PyasXGIRG29Sh5qsvcn5Q.png">