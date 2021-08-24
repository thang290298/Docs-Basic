# Tạo và quản lý IP trong linux Bridge

## Phần I. Cấu hình IP Bridge

### 1. Sử dụng nmcli tạo và cấu hình linux Bridge

#### 1.1 Thực hiên cấu hình

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

#### 1.2 Kiểm tra kết qua

