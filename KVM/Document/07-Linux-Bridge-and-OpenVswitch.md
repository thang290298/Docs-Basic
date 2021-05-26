# Giao tiếp máy ảo Linux Bridge và OpenVSwitch

# Linux Bridge
## I. Khái niệm
  KVM được biết đến là một cơ sở hạ tầng ảo hóa cho nhân Linux. KVM cũng cung cấp các mô hình mạng trong ảo hóa Network, mô hình bao gồm

- NAT
- Host-Only
- Linux Bridge

  Trong đó Linux-Bridge là một phần mềm được tích hợp vào nhân linux  để giải quyết vấn đề ảo hóa Network trong các máy chủ vật lý. Về mặt vật lý Linux-Bridge tạo ra một Switch ảo để để cho chác VM kết nối vào và thực hiện giao tiếp với nhau cũng như để kết nối ra bên ngoài

## II. Cấu trúc


<img src="https://github.com/thang290298/work-Document/blob/master/KVM/Images/cautruclinuxbridge.png?raw=true">

Trong đó: 
- Bridge ở đây là switch ảo
- Tap hay tap interface là giao diện mạng để các VM kết nối với switch do Linux bridge tạo ra
- fd: Forward data có nhiệm vụ chuyển dữ kiệu từ VM tới switch.

Switch ảo do Linux bridge tạo ra có chức năng tương tự với 1 con switch vật lý.

<img src="https://github.com/thang290298/work-Document/blob/master/KVM/Images/3.png?raw=true">

 - Hình trên mô tả rõ hơn cách kết nối interner. khi máy chủ kết nói với internet (không phải qua card wireless). Trên Swich ảo sẽ tạo ra một kết nối ra ngoài interner, cụ thể là qua card mạng trên máy chủ vật lý. Có thể hình dung card mạng vât lý được gắn vào Switch ảo nên sẽ có chung địa chỉ MAC. Khí đó địa chỉ Ip được gắn trên Card vật lý sẽ được chuyển sang gắn trên card mạng ảo
 - Lúc này các VM muốn kết nối với nhau hay là đi ra interner ddeur phải kết nối qua Switch ảo. Card mang trên VM sẽ được gắn với 1 cổng  của Switch ảo thông qua Tap Interface.
 - Khi kết nối Switch ảo các VM sẽ nhận địa chỉ IP cùng với dải địa chỉ IP của card đã được add. Những địa chỉ IP này sẽ đươc cấp bởi dịch vụ DHCP trên router.

### III.Cấu hình Bridge networking

#### 1. Trường hợp 1

```
# add bridge "br0"
nmcli connection add type bridge autoconnect yes con-name br0 ifname br0
# set IP for br0
nmcli connection modify br0 ipv4.addresses 10.10.29.1/24 ipv4.method manual
# set Gateway for br0
nmcli connection modify br0 ipv4.gateway 10.10.29.1
# set DNS for "br0"
nmcli connection modify br0 ipv4.dns 8.8.8.8
# remove the current setting
nmcli connection delete eth0
# add an interface again as a member of br0
nmcli connection add type bridge-slave autoconnect yes con-name eth0 ifname eth0 master br0
# restart
```
#### 2. Trường hợp 2
- Cấu hình config trên `em1`
```
# vi /etc/sysconfig/network-scripts/ifcfg-em1
TYPE=Ethernet
NAME=em1
DEVICE=em1
ONBOOT=yes
HWADDR=b8:2a:72:d1:bb:23
BRIDGE=br1
```
- Khởi tạo và cấu hình `Brigde br1`
```
vi /etc/sysconfig/network-scripts/ifcfg-br1
DEVICE=br1
TYPE=Bridge
BOOTPROTO=static
IPADDR=172.16.2.237
GATEWAY=172.16.10.1
NETMASK=255.255.240.0
ONBOOT=yes
DNS1=8.8.8.8

```

# OpenvSwitch
## I. Khái niệm
- 
- OpenvSwitch là phần mềm Switch mã nguồn mở hỗ trợ giao thức OpenFlow, được sử dụng để kết nối giữa các máy ảo trên cùng 1 host vật lý và các máy ảo trên các host vật ký khách nhau.OpenvSwitch được sử dụng trên một số thiết bị chuyển mạch vật lý
- Open vSwitch là một trong những thành phần quan trọng hỗ trợ SDN (Software Defined Networking - Công nghệ mạng điều khiển bằng phần mềm)
- Tính Năng:
  - Hỗ trợ VLAN tagging và chuẩn 802.1q trunking
  - Hỗ trợ STP (spanning tree protocol 802.1D)
  - Hỗ trợ LACP (Link Aggregation Control Protocol)
  - Hỗ trợ port mirroring (SPAN/RSPAN)
  - Hỗ trợ Flow export (sử dụng các giao thức sflow, netflow)
  - Hỗ trợ các giao thức đường hầm (GRE, VXLAN, IPSEC tunneling)
  - Hỗ trợ kiểm soát QoS
  - Cơ sở dữ liệu cấu hình giao dịch với các liên kết C và Python
  - OpenFlow 1.0 cộng với nhiều tiện ích mở rộng
  - Chuyển tiếp hiệu suất cao sử dụng mô-đun nhân Linux

  Mô-đun nhân Linux đi kèm hỗ trợ Linux 3.10 trở lên.

  Open vSwitch có thể hoạt động trong không gian người dùng mà không cần hỗ trợ từ nhân  kernel module. Việc triển khai không gian người dùng này sẽ dễ dàng hơn so với kernel-based switch

  ## II. Cấu trúc Open vSwitch

   ![](../images/OpenvSwitch.png)


- Open Vswitch được sử dụng để kết nối các VM trong cùng 1 host. Nó quản lý cả các port vật lý (eth0, eth1) và các port ảo (ví dụ như tap port của các VMs).

Các thành phần chính:
- VOS-Switchd: một công cụ thục hiện chuyển đổi cùng với một số kernel module Linux để chuyển đổi dựa trên luồng
- ovsdb-server: một máy chủ cơ sở dữ liệu nhẹ mà ovs-vswitchd truy vấn để có được cấu hình của nó.
- ovs-dpctl : hỗ trợ thiết lập cấu hình kernel module chuyển đổi
- Tập lệnh và thông số kỹ thuật để xây dựng RPM cho Citrix XenServer và Red Hat Enterprise Linux. Các RPM của XenServer cho phép cài đặt Open vSwitch trên máy chủ Citrix XenServer như một công cụ thay thế cho công tắc của nó, với chức năng bổ sung.
- ovs-vsctl, một tiện ích để truy vấn và cập nhật cấu hình của ovs-vswitchd.
- ovs-appctl, một tiện ích gửi lệnh để chạy các daemon Open vSwitch.

Các công cụ hỗ trợ:
- ovs-ofctl: Hỗ trợ truy vấn và điều khiển các bộ điều khiển OpenFlow.
- ovs-pki: tiện ích tạo và quản lý cơ sở hạ tầng OpenFlow.
- ovs-testcontroller, một bộ điều khiển OpenFlow
- Một bản vá cho tcpdump cho phép nó phân tích cú pháp các tin nhắn OpenFlow.