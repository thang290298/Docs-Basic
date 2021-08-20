# Cơ bản về KVM

## I. KVM là gì?
- KVM(Kernel-based Virtual Machine): là công nghệ ảo hóa trong nhân linux cho phép hạt nhân hoạt động như một trình ảo hóa. Do đó máy chủ KVM được cung cấp riêng tài nguyên để sử dụng tránh việc tranh chấp tài nguyên với máy chủ khác.

- Máy chủ gốc được cài hệ điều hành linux nhưng KVM hỗ trợ tạo máy chủ ảo có thể chạy cả Linux, Windows. Nó cũng hỗ trợ cả X86 và X86-64 system

- KVM cung cấp ảo hóa hỗ trợ phần cứng cho nhiều hệ điều hành khách khác nhau.

- KVM ban đầu được phát triển bởi Qumranet – một công ty nhỏ, sau đó được Redhat mua lại vào tháng 9 năm 2008. Ta có thể thấy KVM là thế hệ tiếp theo của công nghệ ảo hóa. KVM được sử dụng mặc định từ bản RHEL (Redhat Enterprise Linux) từ phiên bản 5.4 và phiên bản Redhat Enterprise Virtualization dành cho Server.
  - Intel VT-x: Intel® Virtualization Technology (VT-x) trên CPU Intel.
  - AMD -v: AMD Virtualization (AMD-V) trên CPU AMD.

- Thiết bị phần cứng phải hỗ trợ ảo hóa thì mới áp dụng được công nghệ KVM vào để ảo hóa phần cứng.

## II. KVM để làm gì ?
KVM giúp ta sử dụng hệ thống máy chủ để tạo ra môi trường để tạo các máy ảo phục vụ cho mục đích mình cần.

KVM chuyển đổi một nhân Linux (Linux kernel) thành một bare metal hypervisor và thêm vào đó những đặc trưng riêng của các bộ xử lý Intel như Intel VT-X hay AMD như AMD-V.

Khi đã trở thành một hypervisor, KVM hoàn toàn có thể setup các máy ảo với các hệ điều hành khác nhau và không phụ thuộc vào hệ điều hành của máy chủ vật lý.

Trong kiến trúc của KVM, Virtual machine được thực hiện tương tự như là quy trình xử lý thông thường của Linux, được lập lịch hoạt động như các scheduler tiểu chuẩn của Linux.

Trên thực tế, mỗi CPU ảo hoạt động như một tiến trình xử lý của Linux. Do đó, KVM được quyền thừa hưởng những ưu điểm từ các tính năng của nhân Linux.

## III. Loại ảo hóa của KVM
KVM thuộc loại ảo hóa phần cứng Hardware assisted virtualization

Và thuộc loại Hypervisor type 2: Host Based. KVM có thể cài đặt trên tất cả các Distro khác nhau của Linux.

### 1. Ưu điểm của KVM
- **Linh hoạt**: Tuy máy chủ gốc được cài đặt Linux, nhưng KVM hỗ trợ tạo máy chủ ảo có thể chạy cả Linux, Windows. Sử dụng kết hợp với QEMU, KVM có thể chạy Mac OS X. KVM cũng hỗ trợ cả x86 và x86-64 system.

- **Tính độc quyền cao**: Cấu hình từng gói VPS KVM sẽ chỉ một người sở hữu và toàn quyền sử dụng tài nguyên đó (CPU, RAM, diskspace…) mà không hề bị chia sẻ hay ảnh hưởng bởi các VPS khác trên cùng hệ thống.

- **Bảo mật**: Tích hợp các đặc điểm bảo mật của Linux như SELinux với các cơ chế bảo mật nhiều lớp, KVM bảo vệ các máy ảo tối đa và cách ly hoàn toàn.

- **Hỗ trợ, độ mở rộng cao**: Được phát triển trên nền tảng mã nguồn mở hoàn toàn miễn phí, được hỗ trợ từ cộng đồng và từ nhà sản xuất thiết bị, KVM ngày càng lớn mạnh và trở thành một lựa chọn hàng đầu cho doanh nghiệp với chi phí thấp, hiệu quả sử dụng cao.

### 2. Nhược điểm
- Là công nghệ ảo hóa hoàn toàn phần cứng, VPS KVM yêu cầu cấu hình server vật lý khá cao. Thậm chí yêu cầu phải sử dụng các server của các thương hiệu lớn như IBM, Dell thì mới đảm bảo hoạt động tốt được.

## IV. Cấu trúc KVM

- Linux có tất cả các cơ chế của một VM cần thiết để vận hành các máy ảo. Chính vì vậy các nhà phát triển không xây dựng lại mà chỉ thêm vào đó một vài thành phần để hỗ trợ ảo hóa. KVM được triển khai như một module hạt nhân có thể được nạp vào để mở rộng Linux bởi những khả năng này.
- Trong một môi trường linux thông thường mỗi process chạy hoặc sử dụng user-mode hoặc kernel-mode. KVM đưa ra một chế độ thứ 3, đó là guest-mode. Nó dựa trên CPU có khả năng ảo hóa với kiến trúc Intel VT hoặc AMD SVM, một process trong guest-mode bao gồm cả kernel-mode và user-mode.
- KVM hiện nay được thiết kế để giao tiếp với các hạt nhân thông qua một kernel module có thể nạp được. Hỗ trợ một loạt các hệ thống điều hành máy guest như: Linux, BSD, Solaris, Windows, Haiku, ReactOS và hệ điều hành nghiên cứu AROS. Sử dụng kết hợp với QEMU, KVM có thể chạy Mac OS X.
- Trong kiến trúc của KVM, Virtual machine được thực hiện như là quy trình xử lý thông thường của Linux, được lập lịch hoạt động như các scheduler tiểu chuẩn của Linux. Trên thực tế, mỗi CPU ảo hoạt động như một tiến trình xử lý của Linux. Điều này cho phép KVM được hưởng lợi từ tất cả các tính năng của nhân Linux.


<p align="center"><img src = "..\..\Images\C.png"></p>


### Thành phần chính gồm các phần:

1. **User-facing tools**: Là các công cụ quản lý máy ảo hỗ trợ KVM. Các công cụ có giao diện đồ họa (như virt-manager) hoặc giao diện dòng lệnh như (virsh)

2. **Management layer**: Lớp này là thư viện libvirt cung cấp API để các công cụ quản lý máy ảo hoặc các hypervisor tương tác với KVM thực hiện các thao tác quản lý tài nguyên ảo hóa, vì tự thân KVM không hề có khả năng giả lập và quản lý tài nguyên như vậy.

3. **Virtual machine**: Chính là các máy ảo người dùng tạo ra. Thông thường, nếu không sử dụng các công cụ như virsh hay virt-manager, KVM sẽ sử được sử dụng phối hợp với một hypervisor khác điển hình là QEMU.

4. **Kernel support**: Chính là KVM, cung cấp một module làm hạt nhân cho hạ tầng ảo hóa (kvm.ko) và một module kernel đặc biệt hỗ trợ các vi xử lý VT-x hoặc AMD-V (kvm-intel.ko hoặc kvm-amd.ko)


### Một số lưu ý về KVM và QEMU
- Có thể hình dung KVM giống như driver cho hypervisor để sử dụng được virtualization extension của CPU vật lí nhằm boots performance cho Guest VM. KVM như định nghĩa trên trang chủ thì là Core Virtualization Infrastructure (cơ sở hạ tầng ảo hóa lõi), nó được các hypervisor khác lợi dụng làm back-end để tiếp cận được các công nghệ hardware acceleration (Dịch code để mô phỏng phần cứng)

- QEMU là một Emulator nên nó có bộ dịch của nó là TCG (Tiny Code Generate) để xử lý các yêu cầu trên CPU ảo và giả lập kiến trúc của máy ảo. Nên có thể coi, QEMU như là một hypervisor type 2, nhằm nâng cao hiệu suất của VM. 
    
    Cụ thể, lúc tạo VM bằng QEMU có VirtType là KVM thì khi đó các instruction có nghĩa đối với virtual CPU sẽ được QEMU sử dụng KVM để mapping thành các instruction có nghĩa đối với physical CPU. Làm như vậy sẽ nhanh hơn là chỉ chạy độc lập QEMU, vì nếu không có KVM thì QEMU sẽ phải quay về (fall-back) sử dụng translator của riêng nó là TCG để chuyển dịch các instruction của virtual CPU rồi đem thực thi trên physical CPU

-> Vậy khi QEMU và KVM kết hợp với nhau thì tạo thành 1 hypervisor type 1.

- QEMU cần KVM để boost performance và ngược lại KVM cần QEMU (modified version) để cung cấp giải pháp full virtualization hoàn chỉnh.

- Do KVM kết hợp QEMU nên các máy ảo và mạng ảo có file cấu hình xml sẽ được lưu lại tại thư mục `/etc/libvirt/qemu/`

## Phần V. Một số đặc điểm của KVM

### 1. Security

- Vì Virtual machine được coi như một tiến trình xử lý của Linux, nên nó kế thừa được mô hình bảo mật tiêu chuẩn của Linux để cung cấp khả năng điều khiển và cô lập tài nguyên. Nhân Linux sử dụng SELinux (Security-Enhanced Linux) để thêm quyền điều khiển truy cập, bảo mật đa mức và bảo mật đa tiêu chí, và thực thi các chính sách bắt buộc. SELinux cung cấp cơ chế cách ly tài nguyên nghiêm ngặt và hạn chế cho các tiến trình chạy trong nhân Linux.

### 2. Memory management

- KVM thừa kế tính năng quản lý bộ nhớ mạnh mẽ của Linux. Vùng nhớ của máy ảo được lưu trữ trên cùng một vùng nhớ dành cho các tiến trình Linux khác và có thể swap. KVM hỗ trợ NUMA (Non-Uniform Memory Access - bộ nhớ thiết kế cho hệ thống đa xử lý) cho phép tận dụng hiệu quả vùng nhớ kích thước lớn.
- KVM hỗ trợ các tính năng ảo mới nhất từ các nhà cung cấp CPU như EPT (Extended Page Table) của Microsoft, Rapid Virtualization Indexing (RVI) của AMD để giảm thiểu mức độ sử dụng CPU và cho thông lượng cao hơn.
- Việc chia sẻ bộ nhớ được hỗ trợ thông qua một tính năng của nhân gọi là Kernel Same-page Merging (KSM). KSM quét tất cả các yêu cầu về vùng nhớ cần thiết cho máy ảo và định danh cho từng máy ảo, sau đó tổ hợp vào thành một yêu cầu về vùng nhớ duy nhất để chia sẻ chung cho các máy ảo, lưu trữ vào một bản copy.

### 3. Storage

- KVM sử dụng khả năng lưu trữ hỗ trợ bởi Linux để lưu trữ các images máy ảo, bao gồm các local disk với chuẩn IDE, SCSI và SATA, Network Attached Storage (NAS) bao gồm NFS và SAMBA/CIFS, hoặc SAN được hỗ trợ iSCSI và Fibre Chanel.

- KVM là một phần trong nhân Linux, nên nó có thể tận dụng hạ tầng lưu trữ đã được chứng minh và đáng tin cậy với sự hỗ trợ từ tất cả các nhà cung cấp hàng đầu trong lĩnh vực Storage.

- KVM cũng hỗ trợ các image của máy ảo trên hệ thống chia sẻ tập tin như GFS2 cho phép các image máy ảo được chia sẻ giữa các host hoặc các logical volume.

- Định dạng image mắc định của KVM là QCOW2 – hỗ trợ việc snapshot cho phép snapshot nhiều mức, nén và mã hóa dữ liệu.

### 4. Live migration

- KVM hỗ trợ live migration cung cấp khả năng di chuyển các máy ảo đang chạy giữa các host vật lý mà không làm gián đoạn dịch vụ. Khả năng live migration là trong suốt với người dùng, các máy ảo vẫn duy trì trạng thái bật, kết nối mạng vẫn đảm bảo và các ứng dụng của người dùng vẫn tiếp tục duy trì trong khi máy ảo được đưa sang một host vật lý mới.

- KVM cũng cho phép lưu lại trạng thái hiện tại của máy ảo để cho phép lưu trữ và khôi phục trạng thái đó vào lần sử dụng tiếp theo.

### 5. Performance and scalability

- KVM kế thừa hiệu năng và khả năng mở rộng của Linux, hỗ trợ các máy ảo với 16 CPUs ảo, 256GB RAM và hệ thống máy chủ lên tới 256 cores và trên 1TB RAM.