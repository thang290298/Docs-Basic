# Linux Bridge

## Phần I. Tổng quan vê Linux Bridge
### 1.1 Giới thiệu

- Linux bridge là một soft switch – 1 trong 3 công nghệ cung cấp switch ảo trong hệ thống Linux (bên cạnh macvlan và OpenvSwitch), giải quyết vấn đề ảo hóa network bên trong các máy vật lý.

- Bản chất, linux bridge sẽ tạo ra các switch layer 2 kết nối các máy ảo (VM) để các VM đó giao tiếp được với nhau và có thể kết nối được ra mạng ngoài. Linux bridge thường sử dụng kết hợp với hệ thống ảo hóa KVM-QEMU.

- Linux Bridge thật ra chính là một switch ảo và được sử dụng với ảo hóa KVM/QEMU. Nó là 1 module trong nhân kernel. Sử dụng câu lệnh `brctl` để quản lý .

Mô tả linux bridge: 

<p align="center"><img src = "..\..\Images\1.png"></p>

***Lưu ý***: Linux bridge được dùng kết hợp với các card ethernet của máy host. Không sử dụng với card wireless.



### 1.2 Cấu trúc hệ thống sử dụng Linux bridge

<p align="center"><img src = "..\..\Images\2.png"></p>

Khái niệm về physical port và virtual port"
-  `Virtual Computing Device`: Thường được biết đến như là máy ảo VM chạy trong host server

- `Virtual NIC (vNIC)`: máy ảo VM có virtual network adapters(vNIC) mà đóng vai trò là NIC cho máy ảo.

- `Physical swtich port`: Là port sử dụng cho Ethernet switch, cổng vật lý xác định bởi các port RJ45. Một port RJ45 kết nối tới port trên NIC của máy host.

- `Virtual swtich port`: là port ảo tồn tại trên virtual switch. Cả virtual NIC (vNIC) và virtual port đều là phần mềm, nó liên kết với virtual cable kết nối vNIC



## Phần II. Tìm hiểu Linux Bridge
### 2.1 Cấu trúc và các thành phần

Cấu trúc Linux Bridge:

<img src="https://github.com/thang290298/work-Document/blob/master/KVM/Images/cautruclinuxbridge.png?raw=true">

Trong đó: 
- `Bridge`: là 1 Switch ảo tương đương với switch layer 2 thật.
- `Port`: tương đương với port của switch thật`
- `Tap (tap interface)`: có thể hiểu là giao diện mạng để các VM kết nối với bridge cho linux bridge tạo ra
- `fd (forward data)`: chuyển tiếp dữ liệu từ máy ảo tới bridge

Switch ảo do Linux bridge tạo ra có chức năng tương tự với 1 con switch vật lý.

<img src="https://github.com/thang290298/work-Document/blob/master/KVM/Images/3.png?raw=true">


- Hình trên mô tả rõ hơn cách kết nối interner. khi máy chủ kết nói với internet (không phải qua card wireless). Trên Swich ảo sẽ tạo ra một kết nối ra ngoài interner, cụ thể là qua card mạng trên máy chủ vật lý. Có thể hình dung card mạng vât lý được gắn vào Switch ảo nên sẽ có chung địa chỉ MAC. Khí đó địa chỉ Ip được gắn trên Card vật lý sẽ được chuyển sang gắn trên card mạng ảo
- Lúc này các VM muốn kết nối với nhau hay là đi ra interner ddeur phải kết nối qua Switch ảo. Card mang trên VM sẽ được gắn với 1 cổng  của Switch ảo thông qua Tap Interface.
- Khi kết nối Switch ảo các VM sẽ nhận địa chỉ IP cùng với dải địa chỉ IP của card đã được add. Những địa chỉ IP này sẽ đươc cấp bởi dịch vụ DHCP trên router.


### 2.2 Các tính năng

- `STP`: Spanning Tree Protocol – giao thức chống lặp gói tin trong mạng
- `VLAN`: chia switch (do linux bridge tạo ra) thành các mạng LAN ảo, cô lập traffic giữa các VM trên các VLAN khác nhau của cùng một switch.
- `FDB (forwarding database)`: chuyển tiếp các gói tin theo database để nâng cao hiệu năng switch. Database lưu các địa chỉ MAC mà nó học được. Khi gói tin Ethernet đến, bridge sẽ tìm kiếm trong database có chứa MAC address không. Nếu không, nó sẽ gửi gói tin đến tất cả các cổng.

## III. Một số khái niệm liên quan

### 3.1 Port

- Trong networking, khái niệm `Port` đại diện cho điểm vào ra của dữ liệu trên máy tính hoặc các thiết bị mạng. Port có thể là khái niệm phần mềm hoặc phần cứng. Software port là khái niệm tồn tại trong hệ điều hành. Chúng thường là các điểm vào ra cho các lưu lượng của ứng dụng. Tức là khái niệm port mức logic. Ví dụ: port 80 trên server liên kết với Web server và truyền các lưu lượng HTTP.
- `Hardware port` (port khái niệm phần cứng): là các điểm kết nối lưu lượng ở mức khái niệm vật lý trên các thiết bị mạng như switch, router, máy tính, … ví dụ: router với cổng kết nối RJ45 (L2/Ethernet) kết nối tới máy tính của bạn.
- `Physical switch port`: Thông thường chúng ta hay sử dụng các switch L2/ethernet với các cổng RJ45. Một đầu connector RJ45 kết nối port trên switch tới các port trên NIC của máy tính.
- `Virtual switch port`: giống như các physical switch port mà tổn tại như một phần mềm trên switch ảo. cả virtual NIC và virtual port đều duy trì bởi phần mềm, được kết nối với nhau thông qua virtual cable.

### 3.2 Uplink port

- Uplink port là khái niệm chỉ điểm vào ra của lưu lượng trong một switch ra các mạng bên ngoài. Nó sẽ là nơi tập trung tất cả các lưu lượng trên switch nếu muốn ra mạng ngoài

<p align="center"><img src = "..\..\Images\4.png"></p>

- Khái niệm `virtual uplink switch port` được hiểu có chức năng tương đương, là điểm để các lưu lượng trên các máy guest ảo đi ra ngoài máy host thật, hoặc ra mạng ngoài. Khi thêm một interface trên máy thật vào bridge (tạo mạng bridging với interface máy thật và đi ra ngoài), thì interface trên máy thật chính là virtual uplink port.


### 3.3 Tap interface

`Ethernet port` trên máy ảo VM (mô phỏng pNIC) thường gọi là vNIC (Virtual NIC). Virtual port được mô phỏng với sự hỗ trợ của KVM/QEMU.

- `Port` trên máy ảo VM chỉ có thể xử lý các frame Ethernet. Trong môi trường thực tế (không ảo hóa) interface NIC vật lý sẽ nhận và xử lý các khung Ethernet. Nó sẽ bóc lớp header và chuyển tiếp payload (thường là gói tin IP) tới lên cho hệ điều hành. Tuy nhiên, với môi trường ảo hóa, nó sẽ không làm việc vì các virtual NIC sẽ mong đợi các khung Ethernet.

- `Tap interface` là một khái niệm về phần mềm được sử dụng để nói với Linux bridge là chuyến tiếp frame Ethernet vào nó. Hay nói cách khác, máy ảo kết nối tới tap interface sẽ có thể nhận được các khung frame Ethernet thô. Và do đó, máy ảo VM có thể tiếp tục được mô phỏng như là một máy vật lý ở trong mạng.

Nói chung, `tap interface` là một port trên switch dùng để kết nối với các máy ảo VM.



### 3.4 Cấu hình linux bridge khởi động cùng hệ điều hành

- Khi tạo bridge bằng command brctl addbr thì bridge là non-persistent bridge (tức là sẽ không có hiệu lực khi hệ thống khởi động lại).
```
brctl addbr br1
```

- Ban đầu, khi mới được tạo, bridge sẽ có một địa chỉ MAC mặc định ban đầu. Khi thêm một NIC của host vào thì MAC của bridge sẽ là MAC của NIC luôn. Khi del hết các NIC của host trên bridge thì MAC của bridge sẽ về là 00:00:00:00:00:00 và chờ khi nào có NIC khác add vào thì sẽ lấy MAC của NIC đó.


<p align="center"><img src = "..\..\Images\5.png"></p>

- Khi cấu hình bằng câu lệnh brctl, các ảnh hưởng của nó sẽ biến mất sau khi khởi động lại hệ thống host server. Để lưu lại thông tin cấu hình trên bridge và khởi động lại cùng hệ thống thì nên lưu lại cấu hình vào file (Ghi vào file, khi boot lại hệ thống, thông tin trong file cũng được cấu hình lại. Những thông tin được lưu dưới dạng file, thì luôn khởi động cùng hệ thống - nên có thể coi là vĩnh viễn - trừ khi tự tay stop lại dịch vụ.)

- Cấu hình trong file /etc/network/interfaces

```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).
# The loopback network interface
auto lo 
iface lo inet loopback
# Set up interfaces manually, avoiding conflicts with, e.g., network manager
iface em1 inet manual
iface em3 inet manual
# Bridge setup
auto br0
iface br3 inet static
    bridge_ports em1 em3
    address 192.168.1.2         # Địa chỉ của br1 có thể là cùng dải địa chỉ của eth0 hoặc eth1 tùy ý. 
    broadcast 192.168.1.255
    netmask 255.255.255.0
    gateway 192.168.1.1
```

- Khi khởi động lại, hệ thông sẽ đọc file cấu hình, và cấp địa chỉ cho interface br0 (đại điện cho bridge br0) thông qua liên kết giữa eth0 và mạng 192.168.1.0/24. Và các máy VM kết nối tới bridge, lấy chung dải mạng với bridge thông qua liên kết uplink qua eth0 và có thể liên lạc với mạng bên ngoài.Khi khởi động lại, hệ thông sẽ đọc file cấu hình, và cấp địa chỉ cho interface br0 (đại điện cho bridge br0) thông qua liên kết giữa eth0 và mạng 192.168.1.0/24. Và các máy VM kết nối tới bridge, lấy chung dải mạng với bridge thông qua liên kết uplink qua eth0 và có thể liên lạc với mạng bên ngoài.


- Tham khảo thêm cấu hình các thông số khác cho linux bridge trong file /etc/network/interfaces tại: 
```
http://manpages.ubuntu.com/manpages/xenial/man5/bridge-utils-interfaces.5.html
```


## Phần IV. Các thao tác quản lý Linux Bridge

### 4.1 vCài đặt công cụ phần mềm quản lý Linux Bridge

Linux bridge được hỗ trợ từ version nhân kernel từ 2.4 trở lên. Để sử dụng và quản lý các tính năng của linux birdge, cần cài đặt gói bridge-utilities (dùng các câu lệnh brctl để sử dụng linux bridge). Cài đặt dùng lệnh như sau:

```
- CentOS: sudo yum install bridge-ultils -y
- Ubuntu: sudo apt-get install bridge-ultils -y
```

### 4.2 Một số câu lệnh quản lý

#### BRIDGE MANAGEMENT

|ACTION	|BRCTL	|BRIDGE|
|-|-|-|
|creating bridge|	`brctl addbr <bridge>`| |	
|deleting bridge|	`brctl delbr <bridge>`| |
|add interface (port) to bridge	| `brctl addif <bridge> <ifname>`	| |
|delete interface (port) on bridge |	`brctl delbr <bridge>`|  |	


#### FDB MANAGEMENT

|ACTION	|BRCTL	|BRIDGE|
|-|-|-|
|Shows a list of MACs in FDB|	`brctl showmacs <bridge>`	|`bridge fdb show`|
|Sets FDB entries ageing time|	`brctl setageingtime  <bridge> <time>`|	|
|Sets FDB garbage collector interval|	`brctl setgcint <brname> <time>`| |	
|Adds FDB entry	|	|`bridge fdb add dev <interface> [dst, vni, port, via]`|
|Appends FDB entry|		|`bridge fdb append` (parameters same as for fdb add)|
|Deletes FDB entry|		|`bridge fdb delete ` (parameters same as for fdb add)|

#### STP MANAGEMENT

|ACTION	|BRCTL	|BRIDGE|
|-|-|-|
|Turning STP on/off	|`brctl stp <bridge> <state>`| |	
|Setting bridge priority|	`brctl setbridgeprio <bridge> <priority>`	| |
|Setting bridge forward delay|	`brctl setfd <bridge> <time>`	| |
|Setting bridge 'hello' time|	`brctl sethello <bridge> <time>`| |	
|Setting bridge maximum message age|	`brctl setmaxage <bridge> <time>`	| |
|Setting cost of the port on bridge|	`brctl setpathcost <bridge> <port> <cost>`|	`bridge link set dev <port> cost <cost>`|
|Setting bridge port priority	|`brctl setportprio <bridge> <port> <priority>`|	`bridge link set dev <port> priority <priority>`|
|Should port proccess STP BDPUs	|	|`bridge link set dev <port > guard [on, off]`|
|Should bridge might send traffic on the port it was received|		|`bridge link set dev <port> hairpin [on,off]`|
|Enabling/disabling fastleave options on port|		|`bridge link set dev <port> fastleave [on,off]`|
|Setting STP port state	|	|`bridge link set dev <port> state <state>`|

#### VLAN MANAGEMENT

|ACTION|	BRCTL|	BRIDGE|
|-|-|-|
|Creating new VLAN filter entry|		|`bridge vlan add dev <dev> [vid, pvid, untagged, self, master]`|
|Delete VLAN filter entry	|	|`bridge vlan delete dev <dev>` (parameters same as for vlan add)|
|List VLAN configuration|		|`bridge vlan show`|


***Lưu ý*** : Các ảnh hưởng của câu lệnh chỉ là tạm thời cho đến khi máy host khởi động lại, sau khi khởi động lại, toàn bộ thông tin sẽ bị mất. 
