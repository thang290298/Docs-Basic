# Các chế độ card mạng trong KVM

Cung giống như ảo hóa VMware có 3 chế độ card mạng đó là Nat, Bridge và host-only thì KVM có 3 tùy chọn cho card mạng NAT, Public Bridge và Private Bridge.

## I. NAT


- Đây là chế độ mặc định trong KVM, chế độ NAT sẽ tạo ra một dải mạng local để cung cấp IP cho nhưng máy ảo có trên KVM.
- Cơ chế ở đây hiểu đơn giản là một bridge cho card mạng ảo kết nối với card mạng thật để ra internet.

- Card mạng ảo của vm gắn vào 1 bridge (vibr0), vibr0 mặc định có gateway, các gói tin của máy ảo sẽ đi qau đường này để đến card máy ảo thật và ra ngoài internet.

- KVM cấp DHCP cho các máy dùng chế độ NAT.

## II. Public Bridge

- đây là chế độ mà trên cùng 1 card mạng (eth0), các VM cho phép 1 hay nhiều địa chỉ IP cùng hoặc khác dài IP có liên kết với nhau đi qua cùng 1 cổng mạng.
- để thiết lập 1 Public Bridge cần thiết lập thêm brigde và cho phép kết kết đến cổng vật lý


## III. Private Bridge

- Chế độ này sẽ sử dụng một dải IP riêng biệt, các VM sẽ liên lạc với nhau qua IP này và không ảnh hưởng đến địa chỉ IP có kết nối internet của host.

- IP Private được quy định bao gồm các dải:
  - 10.x.x.x
  - 172.16.x.x
  -192.168.x.x
  