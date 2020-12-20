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



- type: Chỉ ra loại OS được boot để tạo thành VM. hvm cho biết OS cần chạy trên “bare metal”, yêu cầu full virtualization. arch chỉ ra loại kiến trúc CPU dùng để ảo hóa, machine chỉ la loại máy sử dụng.
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

![](../Images/Memory-Allocation.png)