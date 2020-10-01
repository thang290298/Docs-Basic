# Tổng quan về Mail Zimbra
## I. Zimbra là gì?
- Zimbra được biết đến là bộ phần mềm bao gồm máy chủ email và máy khách website, hay nói cách khác dễ hiểu hơn, Zimbra Collaboration Suite(Zimbra) là một trong những ứng dụng nguồn mở miễn phí nổi tiếng về tính năng, độ định và bảo mật cao. Zimbra không chỉ đơn giản là tên của một ứng dụng về email mà nó còn là một giải pháp, một hệ thống khá hoàn chỉnh để triển khai môi trường chia sẻ công tác phục vụ cho quản lý và công việc thông qua các tính năng chính sau:
  - Thư điện tử: một hệ thống thư điện tử hoàn chỉnh gồm Mail server (SMTP, POP3, IMAP, antivirus, antispam, openLDAP, backup, …, có đầy đủ các tính năng như auto-reply, auto-forward, mail filter, …) và Mail client (Zimbra desktop và Zimbra Web Client).
  - Lịch công tác (calendar): lịch cá nhân và lịch nhóm, tự động gửi mail mời họp,…
  - Sổ địa chỉ (Contacts): sổ cá nhân và sổ chung của nhóm
  - Danh mục công việc (Task): của cá nhân và nhóm.
  - Tài liệu (Documents): tài liệu dưới dạng wiki của cá nhân hoặc soạn tập thể
  - Cặp hồ sơ (Briefcase): lưu file dùng riêng hoặc chung.
  - Chat: chat nội bộ trong mạng LAN hoặc trên Internet.
  - Tất cả các mục trên đều có phần chạy trên máy chủ (nằm trong Zimbra Server), lưu trên máy chủ để có thể dùng chung được và truy cập được từ bất kỳ đâu có Internet. (nếu cài trên máy chủ có Internet). Các mục đó đều có khả năng share (kể cả các thư mục email: Inbox, Sent) cho người khác dùng chung.
  - Zimbra có hai phần mềm client: Zimbra desktop và Zimbra Web client là giao diện với người dùng. Zimbra desktop (tương tự như Outlook, KMail,…) cài được trên Windows, Mac, Linux. Ngoài ra có thể dùng các mail client khác như Outlook, Evolution, KMail, Thunderbird, … Hai loại mail client trên ứng với hai cách làm việc:
    - Làm việc online, dùng Zimbra web client. Mọi thông tin sẽ lưu trên máy chủ Zimbra. Zimbra Web Client có hai giao diện: dạng html thông thường, nhanh nhưng ít tính năng và dạng Ajax (tương tự Yahoo Mail). Zimbra Web Client là một trong những Web Client hoàn chỉnh nhất hiện nay (hỗ trợ hầu hết tính năng của Zimbra Server, kể cả chat).
    - Làm việc offline, dùng các mail client còn lại. Riêng Outlook, Apple Desktop và Evolution có thể đồng bộ email, calendar, contacts và task với máy chủ Zimbra, các mail client khác chỉ dùng đọc và gửi email.
- Zimbracũng hỗ trợ làm việc với các điện thoại di động iPhone, Blackberry, …
Về kiến trúc bên trong, Zimbra vẫn sử dụng các bộ phần mềm chức năng (nguồn mở) phổ biến như OpenLDAP, Postfix, SpamAssassin, Amavisd, Tomcat, … cùng với một số phần mềm riêng tạo nên một hệ thống tích hợp chặt chẽ. Có thể không dùng OpenLDAP mà dùng Windows Active Directory, hoặc import user từ một máy chủ Exchange sang.
Hiện tại, Zimbra Server có các bản cài trên RedHat, Fedora, CentOS, Debian, SUSE, Ubuntu và MacOS. Nếu chỉ cài trên một máy chủ độc lập thì cách cài đặt khá đơn giản và nhanh.
Zimbra có thể cài theo nhiều cấu hình khác nhau từ một hệ thống nhỏ vài chục account trên một máy chủ duy nhất cho đến hệ thống rất lớn hàng nghìn account trên nhiều máy chủ có các chức năng khác nhau. Có khả năng mở rộng (scalability) bằng cách thêm máy chủ dễ dàng.
Hiện đang chạy thử trên một cặp máy chủ clustering bằng drbd và heartbeat và chưa chê được điểm gì. Hoàn toàn có thể thay được cặp Exchange + Outlook (nhất là với trình độ sử dụng như hiện nay). Phải chạy thật và sau một thời gian mới có thể phát hiện xem có lỗi gì không.
  - Zimbra có một kho các Zimlet (một thứ tương tự các extensions của Firefox) mà các quản trị mạng có thể chọn cài để bổ xung tính năng. Mọi người có thể tự viết các Zimlet để kết nối hệ thống Zimbra với các hệ thống thông tin khác hoặc mở rộng tính năng. Đây có lẽ là một trong những điểm mạnh nhất và sẽ gây nghiện cho người dùng giống như các extensions của Firefox vậy.

  - Quản trị hệ thống qua giao diện web khá đầy đủ và chi tiết với nhiều tiện ích. Ví dụ có thể tạo hàng trăm account trong vài phút.

- Ánh Xạ cổng sử dụng ứng dụng 
  <img src="https://image.prntscr.com/image/rKwLAJA7RpO3cMqfuBUrlg.png">
  
## II. Check list
## 1. Cài đặt mail Zimbra trên CentOS 7
### 1.1 chuẩn bị
#### Thiết lập bản ghi DNS
```
mail.jaegre292.xyz	A	45.117.80.147	 
autodiscover	CNAME	mail.jaegre292.xyz.	 
autoconfig	CNAME	mail.jaegre292.xyz.	 
@	MX	mail.jaegre292.xyz.	10
```
<img src="https://image.prntscr.com/image/qEHlTGZITYSxt8yoAIzyIQ.png">

#### Chuẩn bị môi trường cho máy chủ mail
- Cấu hình:
  - Phiên bản: zimbra 8.8 trên CentOS 7

  - Cấu hình tối thiểu: RAM: 2GB, Disk: 30GB, CPU: 2 core

  - Chuẩn bị tên miền: Một tên miền đã trỏ bản ghi mail (điều này là cần thiết vì trong quá trình cài đặt sẽ yêu cầu tên miền phân giải được bản ghi mail).

  - Tên miền: jaeger292.xyz
  - ip: 45.117.80.147
- Update OS
```
yum update -y 
reboot
```
- Thiết lập Firewall, selinux và một số package cơ bản

```
sudo systemctl disable firewalld
sudo systemctl stop firewalld
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
yum install -y git wget byobu


service sendmail stop
service iptables stop
service ip6tables stop
chkconfig sendmail off
chkconfig iptables off
chkconfig ip6tables off
service httpd stop
chkconfig httpd off

init 6
```
#### Cài đặt mail server Zimbra
- Cài package cần thiết
```
yum install unzip net-tools sysstat openssh-clients perl-core libaio nmap-ncat libstdc++.so.6 nano wget -y 
```

- Đổi host name, add hostname
```
hostnamectl set-hostname "mail.jaeger.xyz"
exec bash

vim /etc/hosts 
45.17.80.147 mail.jaeger292.xyz mail  
```
*Lưu ý*: File `/etc/resolv.conf` phải khai báo `nameserver 8.8.8.8` để có thể connect tới server download bộ cài `zimbra`.
- Kiểm tra xem có dịch vụ nào đang sử dụng port mà zimbra sử dụng không bằng cách
- Nếu chưa cài đặt `netstat`  
```
yum -y install net-tools
netstat -tulpn | grep -E -w '25|80|110|143|443|465|587|993|995|5222|5223|9071|7071'
```
- Nếu có service nào đang chạy trên các port trên thì tìm tách tắt đi hoặc thay thế
- Download và cài đặt Zimbra 8.8

```
 # mkdir zimbra && cd zimbra
 # wget https://files.zimbra.com/downloads/8.8.10_GA/zcs-8.8.10_GA_3039.RHEL7_64.20180928094617.tgz --no-check-certificate
 # tar zxpvf zcs-8.8.10_GA_3039.RHEL7_64.20180928094617.tgz
 # cd zcs-8.8.10_GA_3039.RHEL7_64.20180928094617
 # ./install.sh
```
Ở bước này lưu ý một số tùy chọn cài đặt như sau:

<img src="https://image.prntscr.com/image/UgXWvaWaQ0yQqGppLrWGSQ.png">

   - Xác nhận thay đổi tên domain và nhập domain

```
It is suggested that the domain name have an MX record configured in DNS
Change domain name? [Yes] yes
Create domain: [mail.jaeger292.xyz] jaeger292.xyz
```

<img src="https://image.prntscr.com/image/E4iu2r_pRlOhLWTMvIB2iA.png">

- Hệ thống sẽ báo password account admin zimbra chưa được nhập, cần đặt lại password admin zimbra
```
Chọn 7 -> Chọn 4 -> Nhập pass => Enter

Address unconfigured (**) items  (? - help) 7

Select, or 'r' for previous menu [r] 4

Password for admin@congtynhanhoa.space (min 6 characters): [94llsjSBXp] Thang@2020!@#
```
Chọn `r `để quay lại menu chính
```
Select, or 'r' for previous menu [r]
```
Chọn `a ` để apply cấu hình
<img src="https://image.prntscr.com/image/9UjWkbjJQT2kNMXJQlGK4Q.png">

Chờ quá trình lưu cấu hình hoàn tất.
```
Notify Zimbra of your installation? [Yes] Yes
Configuration complete - press return to exit
```
- Truy cập
```
https://mail.jaeger292.xyz:7071
```
<img src="https://image.prntscr.com/image/Uy-UN-j1R_aM0N57yHuOSQ.png">

<img src="https://image.prntscr.com/image/xCiDXKViSdCCQZtJAbkcNQ.png">

### Thiết lập các bản ghi DKIM, DMARC
- Trên VPS sử dụng user zimbra thực hiện lệnh sau để tạo DKIM cho domain


<img src="https://image.prntscr.com/image/nvzllZjJRMacsGZ9nkb8kQ.png">

- Truy cập lại trang zonedns khai báo các bản ghi còn lại


<img src="https://image.prntscr.com/image/y63KMAEWQ9qPOXXk0ViLig.png">


