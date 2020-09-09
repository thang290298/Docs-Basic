# Tổng quan về NTP
## I. Giới thiệu về NTP
### 1. NTP là gì
- Network Time Protocol (NTP) là một thuật toán phần mềm giữ cho các máy tính và các thiết bị công nghệ khác nhau có thể đồng bộ hóa thời gian với nhau. NTP đã đạt được thành công trong việc giữ các thiết bị đồng bộ hóa hiệu quả trong chỉ trong vài milliseconds (1/1000s), nhưng để có thể làm được điều này nó cần phải có một hệ thống thời gian đáng tin cậy để sử dụng làm điểm thời gian chính cho việc đồng bộ.
- NTP hoạt động bằng cách sử dụng một nguồn thời gian chính duy nhất (NTP Server), nó sử dụng để đồng bộ tất cả các thiết bị trên mạng.
- NTP là một trong những giao thức Internet lâu đời nhất vẫn còn được sử dụng (từ trước năm 1985). NTP được thiết kế đầu tiên bởi Dave Mills tại trường đại học Delaware, hiện ông vẫn còn quản lý nó cùng với một nhóm người tình nguyện.
- NTP sử dụng thuật toán Marzullo, và nó cũng hỗ trợ các tính năng như giây nhuận. NTPv4 thông thường có thể đảm bảo độ chính xác trong khoảng 10 mili giây (1/100s) trên mạng Internet công cộng, và có thể đạt đến độ chính xác 200 micro giây (1/5000s) hay hơn nữa trong điều kiện lý tưởng của môi trường mạng cục bộ.

### 2. NTP Server là gì?
- NTP Server là gì? Máy chủ NTP hay máy chủ thời gian là các thuật ngữ cùng mô tả một khái niệm: một thiết bị được sử dụng để nhận biết yêu cầu đồng bộ thời gian và phân phối tín hiệu thông tin thời gian. Thật ra, một máy chủ NTP Server cũng chỉ sử dụng Network Time Protocol (NTP), trong vô vàn các giao thức thời gian khác nhau tồn tại thì NTP được sử dụng phổ biến tới hơn 90%.
<img src="https://github.com/thang290298/work-Document/blob/master/Images/ntp/ntp-server.png?raw=true">
- Các tín hiệu thời gian được sử dụng bởi hầu hết các máy chủ NTP là nguồn thời gian UTC. UTC (Coordinated Universal Time) là thời gian toàn cầu dựa trên thời gian đồng hồ nguyên tử. Bằng cách sử dụng UTC, máy chủ NTP có thể tác động, đồng bộ hóa mạng cùng thời gian với hàng triệu mạng máy tính khắp nơi trên thế giới. Nếu không có UTC, nhiều giao dịch trực tuyến sẽ không thể nào thực hiện được. Như vậy là bạn đã thấy tầm quan trọng của UTC rồi đúng không nào.

- Tín hiệu thời gian có thể được nhận bởi NTP server hoặc (time server) qua một số cách như mạng Internet toàn cầu, thời gian của các quốc gia, tần số truyền (sóng dài) hoặc mạng GPS (hệ thống định vị toàn cầu). Khi nhận được tín hiệu, time server kiểm tra tính xác thực của tín hiệu này (trừ các nguồn internet không thể xác thực), đánh giá tính chính xác của nó và phân phối nó trong mạng.
### 3. Lợi ích của NTP server
#### 3.1 Backup dữ liệu theo lập lịch
- Backup dữ liệu rất quan trọng với bất kỳ tổ chức nào, nếu hệ thống quá sai về thời gian sẽ khiến việc sao lưu không chính xác.
#### 3.2 Tăng tốc độ mạng
- Nhiều thiết bị sử dụng cache và hệ thống tập tin diện rộng có thể dựa vào tem thời gian  (timestamp) để xác định phiên bản nào của đoạn dữ liệu ứng với thời điểm hiện tại. Đồng bộ thời gian không chính xác có thể khiến hệ thống như cache server hoạt động không chính xác, sử dụng sai phiên bản dữ liệu.
#### 3.2 Hệ thống quản lý mạng
- Khi có vấn đề gì đó, việc kiểm tra log hệ thống là một phần chính của debug lỗi.
- Nhưng nếu thời gian trong những file log này không đồng bộ/không chính xác thì có thể bạn sẽ mất khoảng thời gian dài hơn để tìm ra nguyên nhân và khắc phục lỗi hệ thống.
#### 3.3 Phân tích xâm nhập
- Trong trường hợp nếu có sự xâm nhập mạng trái phép, việc tìm hiểu xem mạng của bạn bị xâm nhập như thế nào và dữ liệu nào được truy cập có thể được kiểm tra rõ ràng nếu bạn có log thời gian chính xác việc login trên router hoặc máy chủ.
- Hacker thường sẽ xóa log nếu có, nhưng nếu họ không xóa thì bạn cần thời gian chính xác để chuẩn đoán đó.
#### 3.5 Tuân thủ các quy định
- Sarbanes Oxley, HIPAA, GLBA và các quy định khác có thể sẽ cần trong tương lai vì vậy đòi hỏi thời gian chính xác trong các giao dịch cũng như dữ liệu.
### 4. NTP hoạt động như thế nào?
- Thời gian dưới dạng là timestamps (tạm dịch là tem thời gian), cung cấp một chuẩn duy nhất giữa tất cả các thiết bị trên mạng và cách mà một máy chủ NTP hoạt động thì khá đơn giản.
<img src="https://github.com/thang290298/work-Document/blob/master/Images/ntp/how-ntp-works.png?raw=true">
- NTP client gửi một gói tin trong đó chứa tem thời gian được chuyển tiếp đến máy chủ ở dạng số ngày càng tăng từ một điểm thời gian cố định trước đó (unixtime): ngày 1 tháng 1 năm 1990.
- Máy chủ NTP sử dụng tem thời gian để tính toán, nếu thời gian trên mạng không khớp sẽ được cộng trừ thêm số giây để khớp với đồng hồ/máy chủ NTP cấp cao hơn đang tham chiếu. Sau đó gửi trả lại NTP client một gói tin khác, có thẻ thời gian là thời điểm nó gửi gói tin đó đi.
- NTP client nhận được gói tin đó, tính toán độ trễ, dựa và thẻ thời gian mà nó nhận được cùng với độ trễ đường truyền, NTP client sẽ set lại thời gian của nó.
- NTP chính xác trong khoảng 1/100s trên môi trường internet và thực hiện tốt hơn trên mạng LAN và WAN với độ chính xác là 1/5000s.

### 5. NTP server – Stratum Levels Explained
- Để tránh quá tải các request yêu cầu về thời gian cho máy chủ, các máy nhận tín hiệu thời gian từ máy chủ NTP có thể được sử dụng như là một tham chiếu từ máy chủ NTP. Điều này được gọi là Stratum levels, máy chủ NTP là Stratum 1, một máy nhận tín hiệu trực tiếp từ máy chủ NTP là Stratum 2 và máy nhận tín hiệu từ nó (Stratum 2) sẽ là Stratum 3.

<img src="https://github.com/thang290298/work-Document/blob/master/Images/ntp/ntp-stratum-layer.png?raw=true">

- NTP có thể xử lý 16 tầng khác nhau, càng về tầng cao hơn thì độ chính xác thời gian giảm dần, tuy nhiên để làm hệ thống đáng tin cây hơn thì mỗi client có thể nhận được một nguồn thời gian từ nhiều máy chủ. Dịch vụ chương trình NTP liên tục giám sát số liệu ổn định và chính xác cho tất cả các máy chủ và luôn chọn máy chỉ có số liệu tốt nhất.
## II. Cài đặt và cấu hình Chrony làm NTP
### 1. Mô hình chuẩn bị
-  Chuẩn bị 1 máy Server(Ubuntu 20.04) và client(Centos7/RHEL7)
- Có kết nối Internet
- Đăng nhập thao tác với quyền user `root`
### 2.  cài đặt
#### 2.1 Server (Ubuntu20.04)
Sau khi đổi tên Server cần đồng bộ cấu hình của hostname và /etc/hosts tránh các lỗi phát sinh warning trong quá trình vận hành

 Cấu hình time zone
 ```
 timedatectl set-timezone Asia/Ho_Chi_Minh
 ```
 Kiểm tra timezone sau khi cài đặt.
 ```
   timedatectl
 ```

<img src="https://github.com/thang290298/work-Document/blob/master/Images/ntp/timedate.png">

Mặc định trên Ubuntu 20.04 thì trình đồng bộ thời gian timesync đã được thiết lập sẵn trong OS từ lúc cài đặt. Nó hoạt động vẫn rất ổn định nhưng đối với các ứng dụng cần độ nhạy về thời gian yêu cầu cao hơn thì nó sẽ yêu cầu sử dụng các kỹ thuật phức tạp hơn để có thể đồng bộ liên tục và giữ đồng bộ thời gian hệ thống

 Tiến hành stop dịch vụ timesync
 ```
 timedatectl set-ntp no
 ```

 <img src="https://github.com/thang290298/work-Document/blob/master/Images/ntp/offtimedate.png">

 Cấu hình firewall `ufw`
 ```
 sudo ufw allow ntp 
 ```

- Truy cập SSH vào cả 2 Server. Sau đó chúng ta tiến hành cài đặt Chrony.
```
apt-get install -y chrony
```
- Sau khi cài đặt chúng ta tiến hành start Chrony và cho phép khởi động cùng hệ thống.
```
systemctl enable --now chrony
```
- Kiểm tra  dịch vụ đang hoạt động.
```
systemctl status chrony
```

- Kết quả:

<img src="https://github.com/thang290298/work-Document/blob/master/Images/ntp/statuschronyubuntu.png">

Mặc định trên Ubuntu file cấu hình của Chrony nằm ở /etc/chrony/chrony.conf, tiến hành kiểm tra file cấu hình.
```
cat /etc/chrony/chrony.conf | egrep -v '^$|^#'
```
Tại Server 192.168.18.177 là Server sẽ làm NTP Server.  Chúng ta sẽ cấu hình bổ sung cấu hình cho phép các máy Client 192.168.18.0/24 phía trong có thể đồng bộ thời gian từ Server này.

```
echo "allow 192.168.18.0/24" >> /etc/chrony/chrony.conf
```
- Trong đó 10.10.11.0/24 chính là dải IP Local mà chúng ta cho phép các Client kết nối vào NTP Server này để đồng bộ thời gian.
Kiểm tra lại file cấu hình.
```
cat /etc/chrony/chrony.conf | egrep -v '^$|^#'
```
<img src="https://github.com/thang290298/work-Document/blob/master/Images/ntp/checkconfigubuntu.png">
Restart lại dịch vụ để cập nhật cấu hình.

```
systemctl restart chrony
```
Sử dụng chronyc để kiểm tra đồng bộ.
```
chronyc sources -v
```
<img src="https://github.com/thang290298/work-Document/blob/master/Images/ntp/sources%20-v.png">

Kiểm tra đồng bộ sử dụng `timedatectl`.

<img src="https://github.com/thang290298/work-Document/blob/master/Images/ntp/timedatecen2.png">

Set đồng bộ thời gian cho đồng hồ của BIOS (Đồng hồ phần cứng) `hwclock`.

```
hwclock --systohc
```

#### 2.2 Client ( CentOS 7/RHEL7)

 Cấu hình time zone
 ```
 timedatectl set-timezone Asia/Ho_Chi_Minh
 ```
 Kiểm tra timezone sau khi cài đặt.
 ```
   timedatectl
 ```

<img src="https://github.com/thang290298/work-Document/blob/master/Images/ntp/timedate.png">

Cấu hình allow Firewalld.

```
firewall-cmd --add-service=ntp --permanent 
firewall-cmd --reload 
```
Cấu hình disable SElinux.
```
sudo setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/sysconfig/selinux
```
truy cập ssh vào client và tiến hành cài đặt Chrony
```
yum install -y chrony
```
Sau khi cài đặt chúng ta tiến hành start Chrony và cho phép khởi động cùng hệ thống.
```
systemctl enable --now chronyd
```
Kiểm tra  dịch vụ đang hoạt động.
```
systemctl status chronyd
```
Kết quả:

<img src="https://github.com/thang290298/work-Document/blob/master/Images/ntp/chronycentosstatus.png">

Mặc định trên CentOS/RHEL7 file cấu hình của Chrony nằm ở /etc/chrony.conf, tiến hành kiểm tra file cấu hình.
```
cat /etc/chrony.conf | egrep -v '^$|^#'
```
<img src="https://github.com/thang290298/work-Document/blob/master/Images/ntp/checkconfigcentos7.png">

- Thực chất sau khi cài đặt và khởi động Chrony thì Server này đã tự động đồng bộ thời gian về từ một trong những NTP Server thuộc pool ntp.ubuntu.com
- Bây giờ thay vì đồng bộ thời gian từ Internet chúng ta sẽ đồng bộ từ NTP Server chúng ta cấu hình phía trên.
- Tại Server 192.168.18.177 chỉnh sửa cấu hình chrony.
```
sed -i 's|pool ntp.ubuntu.com        iburst maxsources 4|server 192.168.18.177 iburst|g' /etc/chrony.conf
sed -i 's|spool 0.ubuntu.pool.ntp.org iburst maxsources 1|#|g' /etc/chrony.conf
sed -i 's|pool 1.ubuntu.pool.ntp.org iburst maxsources 1|#|g' /etc/chrony.conf
sed -i 's|pool 2.ubuntu.pool.ntp.org iburst maxsources 2|#|g' /etc/chrony.conf
```

Kiểm tra cấu hình

<img src="https://github.com/thang290298/work-Document/blob/master/Images/ntp/checkconfigcentos7-2.png">
- Khởi động lại Chrony để cập nhật cấu hình.
```
systemctl restart chronyd
```
Sử dụng chronyc kiểm tra đồng bộ.

<img src="https://github.com/thang290298/work-Document/blob/master/Images/ntp/sources%20-v.png">

Kiểm tra đồng bộ sử dụng `timedatectl`.

<img src="https://github.com/thang290298/work-Document/blob/master/Images/ntp/timedatecen2.png">

Set đồng bộ thời gian cho đồng hồ của BIOS (Đồng hồ phần cứng) `hwclock`.

```
hwclock --systohc
```
# Nguồn tham khảo
https://news.cloud365.vn/cai-dat-chrony-tren-ubuntu-18-04/
https://news.cloud365.vn/cai-dat-chrony-tren-centos-rhel-7/