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

<img src="https://github.com/thang290298/work-Document/blob/master/Images/tcpdump.png?raw=true">

- Các hình thức tồn tại của TCPDUMP 
  - TCPDUMP xuất ra màn hình nội dung các gói tin (chạy trên card mạng mà máy chủ đang lắng nghe) phù hợp với biểu thức logic chọn lọc mà khách hàng nhập vào. Với từng loại tùy chọn khác nhau khách hàng có thể xuất những mô tả về gói tin này ra một file “pcap” để phân tích sau, và có thể đọc nội dung của file “pcap” đó với option –r của lệnh tcpdump, hoặc sử dụng các phần mềm khác như là : Wireshark.

- Sau khi kết thúc việc bắt các gói tin, tcpdump sẽ báo cáo các cột sau:
  - Packet capture: số lượng gói tin bắt được và xử lý.
  - Packet received by filter: số lượng gói tin được nhận bởi bộ lọc.
  - Packet dropped by kernel: số lượng packet đã bị dropped bởi cơ chế bắt gói tin của hệ điều hành.
-  Các tùy chọn thường được sử dụng trong TCPDUMP
    - -X : Hiển thị nội dung của gói theo định dạng ASCII và HEX
    - -XX : Tương tự -X, hiển thị giao diện ethernet
    - -D : Liệt kê các giao diện mạng có sẵn
    - -l : Đầu ra có thể đọc được dòng (để xem khi bạn lưu hoặc gửi đến các lệnh khác)
    - -t : Cung cấp đầu ra dấu thời gian có thể đọc được của con người
    - -q : Ít dài dòng hơn với đầu ra
    - -tttt : Cung cấp đầu ra dấu thời gian tối đa có thể đọc được của con người
    - -i : Bắt lưu lượng của một giao diện cụ thể
    - -vv : Đầu ra cụ thể và chi tiết hơn (nhiều v hơn cho đầu ra nhiều hơn)
    - s : Xác định snaplength(kích thước) của gói tin theo byte. Sử dụng -s0 để có được mọi thứ. Nếu không set size packet dump thành unlimit, thì khi tcpdump ra nó bị phân mảnh
    - -c : Chỉ nhận được x số gói và sau đó dừng lại
    - -S : In số thứ tự tuyệt đối
    - -e : Nhận tiêu đề ethernet
    - -q : Hiển thị ít thông tin giao thức
    - -E : Giải mã lưu lượng IPSEC bằng cách cung cấp khóa mã hóa

### Dùng TCPDUMP bắt gói tin DHCP

- Trước tiên chuẩn bị 2 máy để cài đặt Tcpdump và cấp phát DHCP.
- Cài đặt TCPDUMP bằng câu lệnh sau
```
yum install tcpdump
```
- Thực hiện bắt gói tin DHCP
```
tcpdump -nni ens33 -n port 67 and port 68
```
<img src="https://image.prntscr.com/image/PV6VJJ8JQ9KYZpDdCc0Pdg.png">

- Từ hình trên ta có thể thấy Tcpdump bắt được 4 gói tin:
  - Client gửi gói tin DHCP Discover ra toàn mạng, do chưa có địa chỉ IP nên client dùng địa chỉ nguồn 0.0.0.0 ra toàn mạng. Gói tin này có chưa địa chỉ MAC của client.
  - DHCP server nhận được gói tin DHCP Discover, DHCP server sẽ gửi cho client 1 gói tin DHCP offer, gói tin này chưa địa chỉ IP cho thuê một khoảng thời gian nhất định.
  - Client nhận được gói tin DHCP offer, client sẽ gửi trả một gói tin DHCP requet để thông báo cho DHCP server sẽ nhận địa chỉ IP này.
  - DHCP server nhận được gói tin DHCP request, DHCP sẽ gửi gói tin DHCP ACK nhằm thông báo chấp nhận client sử dụng địa chỉ Ip vừa cấp.

# Nguồn tham khảo
https://github.com/phancong0897/Congphan/blob/master/DHCP/DHCP-with-wireshark-and-tcpdump.md