# Tìm hiểu file XML trong KVM
## Mục lỤC
## I. Tổng quan về XML
XML (viết tắt từ tiếng Anh: eXtensible Markup Language, tức “Ngôn ngữ đánh dấu mở rộng”) là ngôn ngữ đánh dấu với mục đích chung do W3C đề nghị, để tạo ra các ngôn ngữ đánh dấu khác. Đây là một tập con đơn giản của SGML, có khả năng mô tả nhiều loại dữ liệu khác nhau. Mục đích chính của XML là đơn giản hóa việc chia sẻ dữ liệu giữa các hệ thống khác nhau, đặc biệt là các hệ thống được kết nối với Internet.

VM trong KVM có hai thành phần chính đó là VM’s definition được lưu dưới dạng file XML mặc định ở thư mục /etc/libvirt/qemu và VM’s storage lưu dưới dạng file image.

File domain XML chứa những thông tin về thành phần của máy ảo (số CPU, RAM, các thiết lập của I/O devices…)

Ngoài domain XML, KVM cũng có các file XML khác để lưu các thông tin liên quan tới network, storage…

 ![](../Images/xml.png)

 ## II. Các thành phần trong file domain XML
 Thẻ không thể thiếu trong file domain xml là domain. Nó có 2 thành phần chính: type cho biết hypervisor đang sử dụng, id là mã nhận dạng của máy ảo.

 ### 1. Metadata

![](../Images/metadata.png)

- `name`: Tên máy ảo, chỉ bao gồm kí tự chữ và số và không được trùng với những máy ảo đang chạy.
- `uuid`: Mã nhận dạng quốc tế duy nhất cho máy ảo. Format theo RFC 4122. Nếu thiếu trường uuid khi khởi tạo, mã này sẽ được tự động generate.
- `title`: Tiêu đề của máy ảo.
- `description`: Đoạn mô tả của máy ảo, nó sẽ không được libvirt sửa dụng.
- `metadata`: Chứa những thông tin về file xml.

### 2. Operating system booting

Có nhiều các để boot máy ảo và mỗi cách lại có những lợi ích và hạn chế riêng. Bài viết này sẽ chỉ đưa ra 2 ví dụ đó là boot từ BIOS và kernel

### 3. BIOS Bootloader
Boot thông qua BIOS được hỗ trợ bởi những hypervisors full virtualization. Người dùng sẽ phải thiết lập thứ tự ưu tiên các thiết bị boot.

![](../Images/Bootloader.png)



- type: Chỉ ra loại OS được boot để tạo thành VM. hvm cho biết OS cần chạy trên `bare metal`, yêu cầu full virtualization. arch chỉ ra loại kiến trúc CPU dùng để ảo hóa, machine chỉ la loại máy sử dụng.

- boot : dev chỉ ra thiết bị dùng để khởi động. Nó có thể là fd, hd, cdrom hoặc network. Nếu có nhiều thiết bị được khai báo, nó sẽ được sắp xếp làm thứ tự ưu tiên.

- bootmenu : Chỉ ra có cho khởi động boot menu hay không. Tùy chọn enable có giá trị yes hoặc no. timeout là thời gian đợi trước khi sử dụng chế độ mặc định.

### 4. Direct kernel boot

![](../Images/Direct-kernel-boot.png)


loader : readonly có giá trị yes hoặc no chỉ ra file image writable hay 

readonly. type có giá trị rom hoặc pflash chỉ ra nơi guest memory được kết nối.

kernel : đường dẫn tới kernel image trên hệ điều hành máy chủ

initrd: đường dẫn tới ramdisk image trên hđh máy chủ

cmdline: xác định giao diện điều khiển thay thế


### 5. CPU Allocation
![](../Images/CPU-Allocation.png)

### 6. vcpu
Trạng thái của từng cpu cụ thể

### 7. Memory Allocation

 ![](../Images/Memory-Allocation.png)


### 8. memory
Dung lượng RAM tối đa ở thời điểm khởi động.
unit: đơn vị, mặc định là KiB (kibibytes = 1024 bytes), có thể sử dụng b (bytes), KB (Kilobytes = 1000 bytes), MB (Megabytes = 1000000 bytes), M hoặc MiB (Mebibytes = 1,048,576 bytes), GB (gigabytes = 1,000,000,000 bytes), G hoặc GiB (gibibytes = 1,073,741,824 bytes), TB (terabytes = 1,000,000,000,000 bytes), T hoặc TiB (tebibytes = 1,099,511,627,776 bytes)

maxMemory: Dung lượng RAM tối đa có thể sử dụng

urrentMemory: Dung lượng RAM thực tế đang được sử dụng

### 9. Events configuration

![](../Images/Events-configuration.png)

on_poweroff: Hành động được thực hiện khi người dùng yêu cầu tắt máy

on_reboot: Hành động được thực hiện khi người dùng yêu cầu reset máy

on_crash: Hành động được thực hiện khi có sự cố

Những hành động được phép thực thi:

destroy: Chấm dứt và giải phóng tài nguyên

restart: Chấm dứt rồi khởi động lại giữ nguyên cấu hình

preserve: Chấm dứt nhưng dữ liệu vẫn được lưu lại

rename-restart: Khởi động lại với tên mớidestroy và restart được hỗ trợ trong cả 

on_poweroff và on_reboot. preserve dùng trong on_reboot, rename-restart dùng trong on_poweroff

on_crash hỗ trợ 2 hành động:

coredump-destroy: domain bị lỗi sẽ được dump trước khi bị chấm dứt và giải phóng tài nguyên

coredump-restart: domain bị lỗi sẽ được dump trước khi được khởi động lại với cấu hình cũ

### 10. Hypervisor features
![](../Images/Hypervisor-features.png)

pae: Chế độ mở rộng địa chỉ vật lí cho phép sử dụng 32 bit để lưu trữ tới hơn 4GB bộ nhớ.

acpi: Được sử dụng để quản lí nguồn điện

apic: Sử dụng cho quản lí IRQ

hap: Bật/tắt chết độ phần cứng hỗ trợ, mặc định nó sẽ bật.


### 11. Time keeping
Clock

offset : giá trị `utc`, `localtime`, `timezone`và `variable`

![](../Images/clock.png)

### 12. Devices

emulator
* Đường dẫn tới thiết bị mô phỏng nhị phân. Trong KVM, đó là /usr/bin/kvm

![](../Images/emulator.png)

Hard drives, floppy disks, CDROMs

#### 1. Disk

![](../Images/Disk.png)

disk: Mô tả ổ đĩa, bao gồm các giá trị:

type : kiểu ổ đĩa, có thể chọn “file”, “block”, “dir”, “network” hoặc “volume”

device : Cách ổ đĩa tiếp xúc với hệ điều hành. Các giá trị có thể chọn là “floppy”, “disk”, “cdrom”, “lun”. Giá trị mặc định là “disk”.

snapshot : Chọn chế độ mặc định của ổ đĩa khi snapshot. Các giá trị ở đây là “internal”, “external” và “no”

`source :`

file : Đường dẫn tới ổ đĩa

dir: Đường dẫn tới thư mục chứa ổ đĩa

`target:`
dev: tên loại ổ đĩa, ví dụ: vda, hda…

bus: xác định loại thiết bị ổ đĩa để mô phỏng, các giá trị: “ide”, “scsi”, “virtio”, “xen”, “usb”, “sata”, or “sd” “sd”

`driver:`
name: tên trình điều khiển hỗ trợ, ở đây mặc định sẽ là “qemu”

type: “dự bị” cho “name” ở trên, các giá trị có thể chọn : “raw”, “bochs”, “qcow2”, và “qed”

`address:`
type: Loại controller, có thể chọn “pci” hoặc “drive”, đối với “drvie”, các giá trị 

“controller”, “bus”, “target”, và “unit” sẽ được mặc định thêm vào và có giá trị là 0

#### 2. Controller



![](../Images/Disk.png)