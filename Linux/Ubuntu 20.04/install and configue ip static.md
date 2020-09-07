# Hướng dẫn cài đặt và cấu hình IP tĩnh Ubuntu 20.04 LTS Server
# Mục Lục
[I. Hướng dẫn cài đặt Ubuntu 20.04 LTS Server](##huongdancaidatubuntu)
- [1. Download Ubuntu-Server 20.04](#Download)
- [2. Setup](#Setup)

[II. Hướng dẫn cấu hình IP Tĩnh](#IPstatic)

[III. Nguồn tham khảo](#nguonthamkhao)

<a name="huongdancaidatubuntu"></a>

## I. Hướng dẫn cài đặt Ubuntu 20.04 LTS Server
<a name="Download"></a>

### 1. Download Ubuntu-Server 20.04
[Ubuntu-20.04-live-server-amd64.iso](https://mirrors.bkns.vn/ubuntu-releases/20.04.1/ubuntu-20.04.1-live-server-amd64.iso)
<a name="Setup"></a>
### 2. Setup
Sau khi chọn boot thì màn hình hiện lên sẽ như sau. Và ta sẽ thực hiện theo từng bước như bài hướng dẫn này nhé.
 <img src="https://news.cloud365.vn/wp-content/uploads/2020/04/image-97.png">    

 Nhấn enter để tiếp tục chạy
  <img src="https://news.cloud365.vn/wp-content/uploads/2020/04/image-98.png">

Sau khi chạy xong thì đầu tiên ta sẽ chọn ngôn ngữ cho hệ điều hành của mình muốn sử dụng 
<img src="https://news.cloud365.vn/wp-content/uploads/2020/04/image-99.png">

Tiếp theo ta sẽ lựa chọn loại bàn phím mà ta sẽ dùng là gì.
<img src="https://news.cloud365.vn/wp-content/uploads/2020/04/image-100.png">

Ta sẽ cài đặt IP cho máy mình muốn sử dụng.
 - Chọn done để nhận IP theo DHCP
 - Chọn vào edit để có thể cài IP static
 <img src="https://news.cloud365.vn/wp-content/uploads/2020/04/image-101.png">

 Cài đặt proxy. Bạn chọn done để nhận proxy theo mặc định với cú pháp ở dưới cùng
 <img src="https://news.cloud365.vn/wp-content/uploads/2020/04/image-102.png">

 Cài đặt địa chỉ mirror cho ubuntu. Nhấn done để nhận mặc định
 <img src="https://news.cloud365.vn/wp-content/uploads/2020/04/image-103.png">

 Phân vùng ổ cứng. chọn done để không chia chỉ sử dụng 1 phân vùng.
 <img src="https://news.cloud365.vn/wp-content/uploads/2020/04/image-104.png">

 Chọn phân vùng để cài đặt hệ điều hành chọn done
 <img src="https://news.cloud365.vn/wp-content/uploads/2020/04/image-105.png">

  Xác nhận để tiếp tục cài đặt hệ điều hành
 <img src="https://news.cloud365.vn/wp-content/uploads/2020/04/image-106.png">

Cài đặt tên máy được sử dụng. Cài đặt user và password để đăng nhập vào máy. Rồi chọn done để hoàn thành việc cài đặt
 <img src="https://news.cloud365.vn/wp-content/uploads/2020/04/image-107.png">

 lựa chọn có cài đặt dịch vụ SSH cho máy hay là không. Nếu có cài đặt thì có sử dụng mật khẩu cho dịch vụ ssh hay là không. Và chọn có cho ssh bằng password hay là không. Rồi chọn done
  <img src="https://news.cloud365.vn/wp-content/uploads/2020/04/image-108.png">

Cài đặt thêm một số gói. Nếu không cần thì chọn done để tiếp tục.
 <img src="https://news.cloud365.vn/wp-content/uploads/2020/04/image-109.png">

 Đợi để hệ thống được cài đặt
 <img src="https://news.cloud365.vn/wp-content/uploads/2020/04/image-110.png">

 Chọn reboot hệ thống để hoàn thành!
 <img src="https://news.cloud365.vn/wp-content/uploads/2020/04/image-111.png">

 Đăng nhập user và password.
<a name="IPstatic"></a>

 ## Hướng dẫn cấu hình IP Tĩnh
  Đầu tiên, xem tên card mạng bằng lệnh sau:
   - networkctl status
<img src="https://news.cloud365.vn/wp-content/uploads/2020/03/O0nvpQI.png">
Để cấu hình IP tĩnh cho máy ảo. Ta có thể dùng một trong các trình soạn thảo vi, vim, nano để chỉnh sửa file /etc/netplan/50-cloud-init.yaml.
Nội dung file như sau:
<img src="https://news.cloud365.vn/wp-content/uploads/2020/03/d36TfYG.png">
Nội dung trên có nghĩa là card mạng ens33 đang được cấu hình dhcp.
Ta sửa file lại như sau:
<img src="https://imgur.com/a/aciJm5z">
Trong đó:

ens33 là Network Interface
- 192.168.10.11 là địa chỉ IP tĩnh ta đặt cho máy
- 192.168.10.2 là Default Gateway
- 8.8.8.8, 8.8.4.4 là địa chỉ DNS Server

Ta lưu lại thay đổi và thoát.

Sau đó thực hiện khởi động lại dịch vụ mạng với một trong các lệnh:
 -  sudo netplan apply
 -  sudo systemctl restart NetworkManager.service
 -  sudo service network-manager restart

- Kết quả:
<img src="https://imgur.com/JJqbrLB">
Máy đã nhận địa chỉ IP tĩnh mà ta cấu hình bên trên.

Để cấu hình IP động, ta chỉ cần sửa file /etc/netplan/50-loud-init.yaml lại như ban đầu là xong.
<a name="nguonthamkhao"></a>

 ## Nguồn tham khảo
 https://news.cloud365.vn/huong-dan-cai-dat-ubuntu-20-04/

 https://news.cloud365.vn/ubuntu-cau-hinh-ip-tinh-tren-ubuntu-server-20-04-ban-develop-voi-netplan/