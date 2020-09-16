# Hướng dẫn cài đặt và cấu hình Card mạng trên Ubuntu 16.04
## I. Hướng dẫn cài đặt Ubuntu 16.04 server
Download file`iso` cài đặt Ubuntu Server 16.04 LTS [tại đây](https://releases.ubuntu.com/16.04/ubuntu-16.04.7-server-amd64.iso)

Khi bạn đã có file ISO rồi thì hãy ghi ra đĩa DVD hoặc tạo USB Boot để cắm vào server máy chủ cần cài đặt Ubuntu Server. Nếu mà xài máy chủ ảo thì bootable file ISO lên cài đặt. Phần này các bạn tự tham khảo thêm nhé.

### Các bước cài đặt Ubuntu Server 16.04 LTS
#### Bước 1: Sau khi bạn lựa chọn ngôn ngữ hiển thị trong suốt quá trình cài đặt Ubuntu Server 16.04 LTS. Thì chương trình sẽ hiển thị bảng menu các option sử dụng, ta sẽ chọn `Install Ubuntu Server` để tiến hành cài đặt nhé.

<img src="https://image.prntscr.com/image/gCdUiZouSzCHcWoj1ZYCcQ.png">

#### Bước 2: Tới phần ‘Select a Language‘ , bạn phải lựa chọn ngôn ngữ sử dụng trong hệ điều hành Ubuntu Server 16.04 . Bạn chọn “English” rồi Enter nhé.

<img src="https://image.prntscr.com/image/AnaBAjiFRSaAQIk28PV0lA.png">

#### Bước 3:  bạn lựa chọn khu vực bạn cài đặt khu vực (location).


<img src="https://image.prntscr.com/image/XbqmOy4iSbOhaN0A7hFLfg.png">

#### Bước 4: Detect hoặc cấu hình bàn phím nếu cần. Hướng dẫn chọn No ko cấu hình thêm về bàn phím.

<img src="https://image.prntscr.com/image/6pW6JkzNT_uUG1FF_Bd5FQ.png">

#### Bước 5: ở bước này bạn sẽ chọn chuẩn cú pháp gõ bàn phím dành cho keyboard của bạn. Thông thường chúng ta đều sử dụng chuẩn tiếng anh, nên sẽ lựa chọn ‘English‘.
<img src="https://image.prntscr.com/image/Gq_uLhTeSGWNHDHvuwFKAQ.png">

#### Bước 6 : Quá trình tự động cấu hình mạng trong lúc cài đặt OS Ubuntu Server đang được thực hiện. Bạn không cần phải làm gì hết.
<img src="https://image.prntscr.com/image/qpOEiy4qTYqQfB7ZalHkIg.png">

#### Bước 7: Lúc này bạn sẽ cấu hình tên dùng đại diện (hostname) cho server Ubuntu của bạn, khi hiển thị trong hệ điều hành. Mình sẽ để tên là ‘ubuntu1604’. Bạn có thể dễ dàng thay đổi hostname trong Ubuntu qua bài viết: Hướng dẫn thay đổi hostname trên Linux.

<img src="https://image.prntscr.com/image/at7TKx4tRaWa3u4RYetxUw.png">

#### Bước 8: bạn sẽ tạo một tài khoản user khác để đăng nhập từ đầu. Thay vì sử dụng user quyền cao nhất là ‘root‘ vì lý do bảo mật. Mình gõ tên của mình cho phần nhập thông tin tên miêu tả đầu tiên và ở hình kế đến là tên user .

<img src="https://image.prntscr.com/image/exXb1GJ0T4qhAc4483LcnA.png">

- Thiết lập mật khẩu cho User:

<img src="https://image.prntscr.com/image/i6kFxqNJSpqX5HlqIqadvw.png">

#### Bước 10: Nó sẽ hỏi bạn có muốn mã hoá thư mục /home không để bảo mật không. Hãy chọn ‘no‘ nhé.

<img src="https://image.prntscr.com/image/COp59E2kTb_VXusDXhbxvg.png">

#### Bước 11: lựa chọn hình thức cấu hình chia các parition ổ cứng. Nếu bạn không rành phần này thì lựa chọn ‘Guided – use entire disk‘. Quá trình cài đặt sẽ tự động chia ổ cứng của bạn.

<img src="https://image.prntscr.com/image/wIXHzEUCRi2dzzdHV7ciUA.png">

#### Bước 12: yêu cầu lựa chọn ổ cứng sẽ cài đặt phân chia parition của OS Ubuntu Server lên máy chủ của bạn.

<img src="https://image.prntscr.com/image/BT5GoUq4Q2mNLMT5ytZLLg.png">

#### Bước 13: xác nhận chép đè thông tin partition lên ổ cứng đã lựa chọn trước đó. Nếu trước đó OS server đã có thông tin phân vùng khác thì sẽ bị mất và không thể khỏi phục lại. Chọn ‘Yes‘.

<img src="https://image.prntscr.com/image/XlT26TnTS7asU1jQzrkYnQ.png">

#### Bước 14: Cấu hình HTTP Proxy nếu cần thiết để update luôn các phiên bản phần mềm đang có trong đĩa ISO cài đặt Ubuntu Server 16.04 . Bỏ trống và chọn ‘Continue‘

<img src="https://image.prntscr.com/image/mhu8OmvISS6iOXyL98t-Bw.png">

#### Bước 15: nếu bạn muốn cập nhật phần mềm tự động trong quá trình cài đặt thì lựa chọn các option phía dưới. Riêng mình thì sẽ cập nhật khi vào OS. Bạn chỉ cần chọn ‘No automatic updates‘.


<img src="https://image.prntscr.com/image/r8y9GCbFReyYIAu6ZkDnYA.png">

#### Bước 16: cài đặt các chương trình chuẩn bị sẵn cho server Ubuntu 16.04 . Chương trình duy nhất ta cần chính là ‘OpenSSH’ , để SSH vào server và một số chương trình tiêu chuẩn khác. Chọn ‘OpenSSH Server‘ và ‘Standard System Ultilities‘.
<img src="https://image.prntscr.com/image/pDABc972Tl_aXw8DVgZoFQ.png">

#### Bước 17: cài đặt GRUB Boot loader lên ổ cứng bạn đã lựa chọn để cấu hình partition . Chọn ‘yes’.

<img src="https://image.prntscr.com/image/JUOnFZwaQXyViYZVcj-LgA.png">

#### Bước 18: sau khi bạn chọn ‘yes’ ở trên, thì quá trình cài đặt OS Ubuntu Server 16.04 sẽ bắt đầu và khi kết thúc sẽ xuất hiện bảng thông báo hoàn thành quá trình. Lúc này bạn ‘Continue‘ và máy tính sẽ tự restart vào OS Ubuntu Server cho bạn.


<img src="https://image.prntscr.com/image/ctr_QEx5Qcmo7G9SGrjXiQ.png">

#### Bước 19: Sau khi cài xong bạn remove file cài đặt ra (file iso) và reboot lại hệ điều hành:

<img src="https://image.prntscr.com/image/DVgZfW_ISUKu3Ne6XVGGYw.png">

## II. Cấu hình IP tĩnh Ubuntu Server 16.04 LTS
- Để thay đổi cấu hình địa chỉ IP, ta cần truy cập vào “/etc/network/interfaces” với câu lệnh sau
```
vi /etc/network/interfaces
```
#### 1. Cấu hình IP động

Sau khi truy cập vào interfaces bạn chỉnh sửa ở mục ens33 và ens34 thành:

```
auto ens33
iface ens33 inet dhcp

```

kết quả: 
<img src="https://image.prntscr.com/image/LMuQ_a11Qe2J5-MmZyawzw.png">

#### 2. Cấu hình IP tĩnh
- thay đổi cấu hình file  `interfaces`:
```
auto ens33
iface ens33 inet static
address 192.168.18.188
netmask 255.255.255.0
gateway 192.168.18.2
```
kết quả:

<img src="https://image.prntscr.com/image/jDjMK3OmTf6Z_f4nDqL91Q.png">

Cấu hình nameservers:
- Để thay đổi cấu hình nameservers, ta cần truy cập vào “/etc/resolv.conf” với câu lệnh sau:
```
vi /etc/resolv.conf
```
và thay đổi tại mục nameservers là địa chỉ ip của máy chủ phân giải tên miền.

ví dụ:
```
nameservers   8.8.8.8
nameservers   8.8.4.4
```
Sau khi thay đổi cấu hình mạng bạn khởi động lại máy ping tới IP 8.8.8.8 và tên miền dantri.com để kiểm tra kết nối mạng:

<img src="https://image.prntscr.com/image/j_D0XDtFRveNr529xCBMzA.png">