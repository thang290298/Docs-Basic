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


## 2. Cài đặt SSL Let's Encrypt email server zimbra

### Bước 1: Truy cập ssh vào server zimbra và stop hết các service
```
su zimbra
zmcontrol stop
```

<img src="https://image.prntscr.com/image/2IQmpmc_Te_LjD2WxfvxcA.png">

### Bước 2: Cài đặt git cho Server


```
yum install git -y
```
### Bước 3: Download Let's Encrypt

```

yum -y install epel-release
git clone https://github.com/letsencrypt/letsencrypt
cd letsencrypt

```
<img src="https://github.com/thang290298/work-Document/blob/master/Images/check-mk/letsencrypt.png?raw=true">

### Bước 4: Chạy auto chứng chỉ Let's Encrypt cho tên miền jaeger292.xyz



```
./letsencrypt-auto certonly --standalone -d mail.jaeger292.xyz

```
Sau khi chạy lệnh trên hệ thống sẽ hiển thị thông tin cần nhập

```
Nhập địa chỉ email ví dụ như support@jaeger292.xyz
Đồng ý / Hủy bỏ - Chọn :  A
Có / Không – Chọn : Y
```

Như đoạn ví dụ ở dưới

```
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator standalone, Installer None
Enter email address (used for urgent renewal and security notices) (Enter 'c' to
cancel): support@jaeger292.xyz

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please read the Terms of Service at
https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf. You must
agree in order to register with the ACME server at
https://acme-v02.api.letsencrypt.org/directory
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(A)gree/(C)ancel: A

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Would you be willing to share your email address with the Electronic Frontier
Foundation, a founding partner of the Let's Encrypt project and the non-profit
organization that develops Certbot? We'd like to send you email about our work
encrypting the web, EFF news, campaigns, and ways to support digital freedom.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: Y
Obtaining a new certificate

```

### Bước 5: Kiểm tra lại key đã được tạo ra trong đường dẫn `/etc/letsencrypt/live/$domain` với `$domain` là tên domain mail.congtynhanhoa.space vừa nhập ở bước trên. Kết quả sẽ hiển thị giống ảnh bên dưới.



<img src="https://image.prntscr.com/image/hNPSU4ahQOat94B79FtxOQ.png">

### Bước 7: Cần sửa lại file chain.pem trong thư mục trên để trust root CA

Mở file `/etc/letsencrypt/live/$domain/chain.pem` và chèn thêm đoạn mã sau vào cuối file (Thay thế $domain bằng tên miền mail.jaeger292.xyz sử dụng ở bước trên)

```
-----BEGIN CERTIFICATE-----
MIIDSjCCAjKgAwIBAgIQRK+wgNajJ7qJMDmGLvhAazANBgkqhkiG9w0BAQUFADA/
MSQwIgYDVQQKExtEaWdpdGFsIFNpZ25hdHVyZSBUcnVzdCBDby4xFzAVBgNVBAMT
DkRTVCBSb290IENBIFgzMB4XDTAwMDkzMDIxMTIxOVoXDTIxMDkzMDE0MDExNVow
PzEkMCIGA1UEChMbRGlnaXRhbCBTaWduYXR1cmUgVHJ1c3QgQ28uMRcwFQYDVQQD
Ew5EU1QgUm9vdCBDQSBYMzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AN+v6ZdQCINXtMxiZfaQguzH0yxrMMpb7NnDfcdAwRgUi+DoM3ZJKuM/IUmTrE4O
rz5Iy2Xu/NMhD2XSKtkyj4zl93ewEnu1lcCJo6m67XMuegwGMoOifooUMM0RoOEq
OLl5CjH9UL2AZd+3UWODyOKIYepLYYHsUmu5ouJLGiifSKOeDNoJjj4XLh7dIN9b
xiqKqy69cK3FCxolkHRyxXtqqzTWMIn/5WgTe1QLyNau7Fqckh49ZLOMxt+/yUFw
7BZy1SbsOFU5Q9D8/RhcQPGX69Wam40dutolucbY38EVAjqr2m7xPi71XAicPNaD
aeQQmxkqtilX4+U9m5/wAl0CAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAOBgNV
HQ8BAf8EBAMCAQYwHQYDVR0OBBYEFMSnsaR7LHH62+FLkHX/xBVghYkQMA0GCSqG
SIb3DQEBBQUAA4IBAQCjGiybFwBcqR7uKGY3Or+Dxz9LwwmglSBd49lZRNI+DT69
ikugdB/OEIKcdBodfpga3csTS7MgROSR6cz8faXbauX+5v3gTt23ADq1cEmv8uXr
AvHRAosZy5Q6XkjEGB5YGV8eAlrwDPGxrancWYaLbumR9YbK+rlmM6pZW87ipxZz
R8srzJmwN0jP41ZL9c8PDHIyh8bwRLtTcm1D9SZImlJnt1ir/md2cXjbDaJWFBM5
JDGFoqgCWjBH4d1QB7wCCZAA62RjYJsWvIjJEubSfZGL+T0yjWW06XyxV3bqxbYo
Ob8VZRzI9neWagqNdwvYkQsEjgfbKbYK7p2CNTUQ
-----END CERTIFICATE-----
```
<img src="https://image.prntscr.com/image/mDBV-aSnR92QPVRiARokFw.png">

### Bước 8: Verify certificate

-  Copy Let’s Encrypt folder trong /etc/letsencrypt/live/$domain tới thư mục /opt/zimbra/ssl/letsencrypt
```
mkdir /opt/zimbra/ssl/letsencrypt
cp /etc/letsencrypt/live/mail.congtynhanhoa.space/* /opt/zimbra/ssl/letsencrypt/
chown zimbra:zimbra /opt/zimbra/ssl/letsencrypt/*
```
<img src="https://image.prntscr.com/image/FFtzwijsRTKAfr2xpZg8Jg.png">

### Bước 9: Verify chứng chỉ, với phiên bản zimbra 8.7 trở lên (Với phiên bản từ 8.6 trỏ xuống dùng user root nên bỏ qua lệnh su zimbra).


```
su zimbra
cd /opt/zimbra/ssl/letsencrypt
/opt/zimbra/bin/zmcertmgr verifycrt comm privkey.pem cert.pem chain.pem
```

<img src="https://image.prntscr.com/image/-u-L2fFTQ86iZJUBMEcCpw.png">

### Bước 10: Deploy Let’s Encrypt SSL certificate mới, lệnh bên dưới sử dụng với quyền user root

- Backup thư mục SSL của zimbra
```
cp -a /opt/zimbra/ssl/zimbra /opt/zimbra/ssl/zimbra.$(date "+%Y%m%d")
```
- Copy private key tới đường dẫn Zimbra SSL commercial
```
cp /opt/zimbra/ssl/letsencrypt/privkey.pem /opt/zimbra/ssl/zimbra/commercial/commercial.key
chown zimbra:zimbra /opt/zimbra/ssl/zimbra/commercial/commercial.key
```
- Deploy SSL
```
su zimbra
cd /opt/zimbra/ssl/letsencrypt
/opt/zimbra/bin/zmcertmgr deploycrt comm cert.pem chain.pem
```
-*Lưu ý*: Lệnh deploy SSL áp dụng với zimbra version 8.7 trỏ lên, với zimbra version 8.6 trở xuống bỏ qua su zimbra

### Bước 11: Restart service zimbra
```
su zimbra
zmcontrol restart
```
- Kiểm tra sau khi cài đặt SSL Let's Encrypt
<img src="https://image.prntscr.com/image/ZNK4CPwORs6w5viwwbdIwg.png">


<img src="https://image.prntscr.com/image/A0_XUNkCQtmtxb-UOhQexw.png">


## 3. Chỉnh sửa quota account email zimbra

Khi tạo một account email trong email server zimbra hệ thống sẽ tự động phân chia quota cho mỗi account theo mặc định. Trong thực tế việc thiết lập quota cho account khác nhau với giá trị khác nhau là cần thiết tùy thuộc vào nhu cầu sử dụng của account đó.


- Truy cập `Home` => `Account Manager`
<img src="https://image.prntscr.com/image/rGBTeOKBTkGAqmHbz67uAQ.png">

- lựa chọn tài khoản muốn chỉnh sửa quota -> chuột phải-> edit 

<img src="https://image.prntscr.com/image/sy2PrfN_RaO8fSkgeA9gIg.png">

- Click `Advanced` => `Quota`

<img src="https://image.prntscr.com/image/YWRC36tOTj2oyKRAZs7WYA.png">

- tùy chỉnh các tham số:
  - Limit user-specified forwarding addresses field to (chars): Giới hạn địa chỉ chuyển tiếp theo người dùng trong phạm vi (ký tự)
  - Maximum number of user-specified forwarding addresses:Số lượng tối đa các địa chỉ chuyển tiếp theo người dùng
  - Account quota (MB):Hạn mức tài khoản (MB) (0 là không có giới hạn)
  - Maximum number of contacts allowed in folder:Số lượng liên hệ tối đa cho phép trong thư mục
  - Percentage threshold for quota warning messages (%): Ngưỡng phần trăm cho các thư cảnh báo hạn mức (%)
  - Minimum duration of time between quota warnings: Khoảng thời gian tối thiểu giữa các cảnh báo hạn mức
  - Quota warning message template: Mẫu thư cảnh báo hạn mức


  <img src="https://image.prntscr.com/image/jlBR3YFQSvGAJHHeAFdQow.png">

  ## 3. Khởi tạo user 
  - Bước 1: Đăng nhập
  Vào trang quản trị admin theo link Nhân Hòa cung cấp, ví dụ: https://mail.jaeger292.xyz:7071/ Nhập user và pass được cấp sau đó Sign in


<img src="https://image.prntscr.com/image/3slLOu-wRua8udxSw6X20Q.png">



- Sau khi đăng nhập chọn manage

<img src="https://image.prntscr.com/image/gVrvU8ZdRba_wJO7n6YYkw.png">

- Chọn cấu hình bên tay phải sau đó vào phần new để khởi tạo user

<img src="https://image.prntscr.com/image/tItlrCaBS1SHfx_KqmK83Q.png">

- Điền tên người dùng ở ô account name và điền last name phần bắt buộc
<img src="https://image.prntscr.com/image/X5iK2HcQQtKzSoKmt3XoRg.png">

Kéo thanh cuốn bên tay phải xuống dưới nhập pass user và nhập lại pass. Sau khi điền chính xác thì click finish. Chú ý:
   - Pass tạo cần tạo pass có độ khó ( trên 10 ký tự, có chữ thường, chữ hoa, số). Nếu dùng pass dễ quá sẽ có báo lỗi.
   - Ở mục must change pass nếu tic vào sẽ yêu cầu người dùng phải đổi pass sau khi đăng nhập lần đầu. Nếu dùng luôn pass admin tạo thì ko cần tic vào phần này.

<img src="https://image.prntscr.com/image/bsa28ZpQSFqQTS4DHwH0-w.png">


## 4. Kiểm tra log gửi/nhận email zimbra
  Việc kiểm tra log gửi/nhận của email server zimbra là rất cần thiết, giúp xác định được một email đã gửi/nhận thành công hay chưa và nếu chưa thành công thì bị dừng ở bước nào và báo lỗi ra sao.
- Đường dẫn file log
```
/var/log/maillog
```
Oct  5 10:51:40 mail postfix/smtpd[23179]: connect from mail-pj1-f48.google.com[209.85.216.48]

Oct  5 10:51:41 mail postfix/smtpd[23179]: Anonymous TLS connection established from mail-pj1-f48.google.com[209.85.216.48]: TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits)

Oct  5 10:51:41 mail postfix/smtpd[23179]: NOQUEUE: filter: RCPT from mail-pj1-f48.google.com[209.85.216.48]: <thangjaeger.292@gmail.com>: Sender address triggers FILTER smtp-amavis:[127.0.0.1]:10026; from=<thangjaeger.292@gmail.com> to=<nvt292@jaeger292.xyz> proto=ESMTP helo=<mail-pj1-f48.google.com>

Oct  5 10:51:41 mail postfix/smtpd[23179]: NOQUEUE: filter: RCPT from mail-pj1-f48.google.com[209.85.216.48]: <thangjaeger.292@gmail.com>: Sender address triggers FILTER smtp-amavis:[127.0.0.1]:10024; from=<thangjaeger.292@gmail.com> to=<nvt292@jaeger292.xyz> proto=ESMTP helo=<mail-pj1-f48.google.com>

Oct  5 10:51:41 mail postfix/smtpd[23179]: E1988A367B: client=mail-pj1-f48.google.com[209.85.216.48]

Oct  5 10:51:41 mail postfix/postscreen[29291]: CONNECT from [45.142.120.78]:21600 to [45.117.80.147]:25

Oct  5 10:51:42 mail postfix/cleanup[23419]: E1988A367B: message-id=<CAPyF0sQrui1ycLw1EUzViEv+fYZ762dgn0xwpVdOMy5c1i_dDQ@mail.gmail.com>
Oct  5 10:51:42 mail postfix/qmgr[29255]: E1988A367B: from=<thangjaeger.292@gmail.com>, size=3921, nrcpt=1 (queue active)

Oct  5 10:51:42 mail postfix/postscreen[29291]: PREGREET 16 after 0.31 from [45.142.120.78]:21600: EHLO localhost\r\n

Oct  5 10:51:42 mail postfix/smtpd[23179]: disconnect from mail-pj1-f48.google.com[209.85.216.48] ehlo=2 starttls=1 mail=1 rcpt=1 data=1 quit=1 commands=7


Oct  5 10:51:42 mail postfix/smtpd[21037]: connect from unknown[45.142.120.78]

Oct  5 10:51:43 mail postfix/smtpd[21037]: disconnect from unknown[45.142.120.78] ehlo=1 quit=1 commands=2

Oct  5 10:51:44 mail postfix/submission/smtpd[16952]: connect from unknown[212.70.149.36]

Oct  5 10:51:44 mail postfix/postscreen[29291]: CONNECT from [45.142.120.78]:58484 to [45.117.80.147]:25

Oct  5 10:51:44 mail postfix/postscreen[29291]: PREGREET 16 after 0.28 from [45.142.120.78]:58484: EHLO localhost\r\n
Oct  5 10:51:44 mail postfix/smtpd[23179]: connect from unknown[45.142.120.78]

Oct  5 10:51:45 mail postfix/smtpd[23179]: disconnect from unknown[45.142.120.78] ehlo=1 quit=1 commands=2

Oct  5 10:51:46 mail postfix/postscreen[29291]: CONNECT from [45.142.120.78]:30860 to [45.117.80.147]:25

Oct  5 10:51:47 mail postfix/postscreen[29291]: PREGREET 16 after 0.53 from [45.142.120.78]:30860: EHLO localhost\r\n

Oct  5 10:51:47 mail postfix/smtpd[21037]: connect from unknown[45.142.120.78]

Oct  5 10:51:48 mail postfix/submission/smtpd[16952]: disconnect from unknown[212.70.149.36] ehlo=1 auth=0/1 rset=1 quit=1 commands=3/4
Oct  5 10:51:48 mail postfix/smtpd[21037]: disconnect from unknown[45.142.120.78] ehlo=1 quit=1 commands=2

Oct  5 10:51:49 mail postfix/postscreen[29291]: CONNECT from [45.142.120.78]:3212 to [45.117.80.147]:25

Oct  5 10:51:49 mail postfix/postscreen[29291]: PREGREET 16 after 0.29 from [45.142.120.78]:3212: EHLO localhost\r\n

Oct  5 10:51:49 mail postfix/smtpd[23179]: connect from unknown[45.142.120.78]

Oct  5 10:51:50 mail postfix/smtpd[23179]: disconnect from unknown[45.142.120.78] ehlo=1 quit=1 commands=2

Oct  5 10:51:51 mail postfix/postscreen[29291]: CONNECT from [45.142.120.78]:40084 to [45.117.80.147]:25
Oct  5 10:51:51 mail postfix/postscreen[29291]: PREGREET 16 after 0.28 from [45.142.120.78]:40084: EHLO localhost\r\n
Oct  5 10:51:52 mail postfix/smtpd[21037]: connect from unknown[45.142.120.78]

Oct  5 10:51:52 mail postfix/smtpd[21037]: disconnect from unknown[45.142.120.78] ehlo=1 quit=1 commands=2

Oct  5 10:51:54 mail postfix/postscreen[29291]: CONNECT from [45.142.120.78]:12466 to [45.117.80.147]:25

Oct  5 10:51:54 mail postfix/postscreen[29291]: PREGREET 16 after 0.29 from [45.142.120.78]:12466: EHLO 
localhost\r\n
Oct  5 10:51:54 mail postfix/smtpd[23179]: connect from unknown[45.142.120.78]

Oct  5 10:51:54 mail postfix/smtpd[23179]: disconnect from unknown[45.142.120.78] ehlo=1 quit=1 commands=2

Oct  5 10:51:56 mail postfix/amavisd/smtpd[23757]: connect from localhost[127.0.0.1]

Oct  5 10:51:56 mail postfix/amavisd/smtpd[23757]: 1D1B2A366A: client=localhost[127.0.0.1]

Oct  5 10:51:56 mail postfix/cleanup[23419]: 1D1B2A366A: message-id=<CAPyF0sQrui1ycLw1EUzViEv+fYZ762dgn0xwpVdOMy5c1i_dDQ@mail.gmail.com>

Oct  5 10:51:56 mail postfix/qmgr[29255]: 1D1B2A366A: from=<thangjaeger.292@gmail.com>, size=4852, nrcpt=1 (queue active)

Oct  5 10:51:56 mail postfix/smtp[23420]: E1988A367B: to=<nvt292@jaeger292.xyz>, relay=127.0.0.1[127.0.0.1]:10024, delay=14, delays=0.32/0.02/3/11, dsn=2.0.0, status=sent (250 2.0.0 from MTA(smtp:[127.0.0.1]:10025): 250 2.0.0 Ok: queued as 1D1B2A366A)

```
