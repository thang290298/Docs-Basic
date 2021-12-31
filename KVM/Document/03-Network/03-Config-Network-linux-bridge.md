# Tạo và quản lý IP trong linux Bridge

## Phần I. Cấu hình IP Bridge

### 1. Sử dụng nmcli tạo và cấu hình linux Bridge


- add bridge br4
```
nmcli connection add type bridge autoconnect yes con-name br4 ifname br4
```
- set IP for br4
```
nmcli connection modify br4 ipv4.addresses 10.10.29.1/24 ipv4.method manual
```
- set Gateway for br4
```
nmcli connection modify br4 ipv4.gateway 10.10.29.1
```
- set DNS for "br4"
```
nmcli connection modify br4 ipv4.dns 8.8.8.8
```
- remove the current setting
```
nmcli connection delete em4
```
- add an interface again as a member of br4
```
nmcli connection add type bridge-slave autoconnect yes con-name em4 ifname em4 master br4
```
- restart
```
systemctl restart network
```
### 2. Chuẩn bị môi trường KVM

Chuẩn bị Một Server có cài đặt KVM - Hệ điều hành CentOS 7
Trên Server có Cổng mạng Vật lý `em1`, trước tiên ta cần cấu hình Cổng vật lý `em1` nối với Bridge `br0`

- Cấu hình trên Cổng vật lý `em1`:

`vi /etc/sysconfig/network-scripts/ifcfg-em1`

```
TYPE=Ethernet
NAME=em1
DEVICE=em1
ONBOOT=yes
HWADDR=20:47:47:86:3b:ac
BRIDGE=br0
```

Lưu ý: phần `HWADDR` kiểm tra đúng thông tin địa chỉ MAC, trước khi cấu hình dùng lệnh `ip a` để kiểm tra địa chỉ MAC.

- Tạo cấu hình cho `br0`:

`vi /etc/sysconfig/network-scripts/ifcfg-br0`

```
DEVICE=br0
TYPE=Bridge
BOOTPROTO=static
IPADDR=103.124.95.135
GATEWAY=103.124.95.1
NETMASK=255.255.255.0
ONBOOT=yes
DNS1=8.8.8.8
```
`BRIDGE=br0` trên cấu hình của `em1` phải đúng với cấu hình `DEVICE=br0` trên cấu hình của `br0`

Sau khi cấu hình xong restart lại network để nhận cấu hình mới.

<img src="https://imgur.com/KehqwOX.png">

### 3. Cài đặt VM trên KVM nhận card Bridge

Chọn Network vào `br0` để VM nhận card mạng `bridge`.

<img src="https://imgur.com/OVfrc0y.png">

Sau khi hoàn thành cài đặt, kiểm tra thấy VM đã nhận IP với dải IP của Card vật lý

<img src="https://imgur.com/MEwMhPc.png">

- Phân tích đường đi của VM khi sử dụng card bridge, ta có thể thấy đường đi sẽ đi theo Gateway của card vật lý rồi đi ra Internet.

<img src="https://imgur.com/609ArVL.png">

## Phần II. Cấu hình VLAN

### Cấu hình công vật lý `em2`

```
TYPE=Ethernet
BOOTPROTO=none
NAME=em2
DEVICE=em2
ONBOOT=yes
```

### Cấu hình cổng `em2` nối với `vlan40` với `vlan41` bằng Bridge

- VLAN40:

```
DEVICE=em2.40
BOOTPROTO=none
ONBOOT=yes
VLAN=yes
BRIDGE=vlan40
TYPE=Ethernet
NM_CONTROLLED=no
```

- VLAN41:

```
DEVICE=em2.41
BOOTPROTO=none
ONBOOT=yes
VLAN=yes
BRIDGE=vlan40
TYPE=Ethernet
NM_CONTROLLED=no
```

### Cấu hình vlan

- VLAN40:

```
DEVICE=vlan40
TYPE=Bridge
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED=no
IPADDR=10.10.40.2
NETMASK=255.255.255.0
GATEWAY=10.10.40.1
```

- VLAN41:

```
DEVICE=vlan41
TYPE=Bridge
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED=no
IPADDR=10.10.41.2
NETMASK=255.255.255.0
GATEWAY=10.10.41.1
```

Sau khi cấu hình xong, restart lại network: `systemctl restart network`

Cấu hình Network:

<img src="https://imgur.com/W6bMwth.png">

Kiểm tra ping đến địa chỉ trên Switch Local `10.10.40.254` và `10.10.41.254`:

<img src="https://imgur.com/Tuz9Gyp.png">