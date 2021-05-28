# Hướng dẫn cài đặt máy ảo KVM trên Centos 7
# I. Cài đặt KVM

## 1. Kiểm tra hỗ trợ ảo hóa
Để kiểm tra máy có hỗ trợ ảo hóa hay không?
```
# egrep -c "svm|vmx" /proc/cpuinfo
48
```
Nếu kết quả trả về 0 thì máy không hỗ trợ ảo hóa. Còn khác 0 tức là máy có hỗ trợ ảo hóa.

<img src="../Images/createkvm/checksupportkvm.png">

## 2. Cài đặt các gói cần thiết

```
yum -y install qemu-kvm libvirt virt-install bridge-utils virt-manager
```

Trong đó: 
  - qemu-kvm: Phần mềm phụ trợ cho KVM
  - libvirt: Quản lý qemu và kvm bằng libvirt
  - bridge-utils: Tiện ích cần thiết để tạo và quản lý các thiết bị bridge
  - virt-manager: Cung cấp giao diện quản lý máy ảo
  - virt-install: Cung cấp lệnh để cài đặt máy ảo

Sau khi cài đặt hoàn tất, kiểm tra các module KVM

```
lsmod | grep kvm
```

<img src="../Images/createkvm/modulekvm.png">


## 3. Bật libvirt và khởi động cùng hệ thống

```
systemctl start libvirt
systemctl enable libvirtd

```

reboot
```
init 6
```

# II. Cài đặt VM
## 2.1 Sử dụng công cụ Virt-manager để cài VM

Cấu hình cài đặt NAT từ dải mạng `192.168.27.0/24` đi ra internet.

- Truy cập ` vỉrt-manager`
```
virt-manager
```
<img src="../Images/createkvm/virtmanager.png">


- chọn đường dẫn đến file ios cài đặt VM

<img src="../Images/createkvm/mapiso.png">


