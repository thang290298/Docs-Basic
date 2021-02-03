# Giao tiếp máy ảo Linux Bridge và OpenVSwitch

# Linux Bridge
## I. Khái niệm
  KVM được biết đến là một cơ sở hạ tầng ảo hóa cho nhân Linux. KVM cũng cung cấp các mô hình mạng trong ảo hóa Network, mô hình bao gồm

- NAT
- Host-Only
- Linux Bridge

  Trong đó Linux-Bridge là một phần mềm được tích hợp vào nhân linux  để giải quyết vấn đề ảo hóa Network trong các máy chủ vật lý. Về mặt vật lý Linux-Bridge tạo ra một Switch ảo để để cho chác VM kết nối vào và thực hiện giao tiếp với nhau cũng như để kết nối ra bên ngoài

## II. Cấu trúc


![](../images/cautruclinuxbridge.png)
<img src="https://github.com/thang290298/work-Document/blob/master/KVM/Images/cautruclinuxbridge.png?raw=true">

Trong đó: 
- Bridge ở đây là switch ảo
- Tap hay tap interface là giao diện mạng để các VM kết nối với switch do Linux bridge tạo ra
- fd: Forward data có nhiệm vụ chuyển dữ kiệu từ VM tới switch.

Switch ảo do Linux bridge tạo ra có chức năng tương tự với 1 con switch vật lý.

![](../images/3.png)

 - Hình trên mô tả rõ hơn cách kết nối interner. khi máy chủ kết nói với internet (không phải qua card wireless). Trên Swich ảo sẽ tạo ra một kết nối ra ngoài interner, cụ thể là qua card mạng trên máy chủ vật lý. Có thể hình dung card mạng vât lý được gắn vào Switch ảo nên sẽ có chung địa chỉ MAC. Khí đó địa chỉ Ip được gắn trên Card vật lý sẽ được chuyển sang gắn trên card mạng ảo
 - Lúc này các VM muốn kết nối với nhau hay là đi ra interner ddeur phải kết nối qua Switch ảo. Card mang trên VM sẽ được gắn với 1 cổng  của Switch ảo thông qua Tap Interface.
 - Khi kết nối Switch ảo các VM sẽ nhận địa chỉ IP cùng với dải địa chỉ IP của card đã được add. Những địa chỉ IP này sẽ đươc cấp bởi dịch vụ DHCP trên router.

 # OpenvSwitch
## I. Khái niệm

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

  ## II. Cấu trúc Open vSwitch

   ![](../images/ovs_arch.png.png)
- Open Vswitch được sử dụng để kết nối các VM trong cùng 1 host. Nó quản lý cả các port vật lý (eth0, eth1) và các port ảo (ví dụ như tap port của các VMs).
- 3 thành phần chính
  - vswitchd:
     - Là ovs daemon chạy trên user space
     - Công cụ tương tác: ovs-dpctl, ovs-appctl, ovs-ofctl, sFlowTrend
  - ovsdb-server:
    - Là database server của Open vSwitch chạy trên user space
    - Công cụ tương tác: ovs-vsctl, ovsdb-client
  - kernel module (datapath):Là module thuộc kernel space, thực hiện công việc chuyển tiếp gói tin