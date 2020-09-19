# Check list Directadmin
# Mục lục
[1. Cài đặt DirectAdmin (DA)](https://github.com/thang290298/work-Document/blob/master/Linux/check-list-DA.md#1-c%C3%A0i-%C4%91%E1%BA%B7t-directadmin-da)

[2. Tạo gói Packages](https://github.com/thang290298/work-Document/blob/master/Linux/check-list-DA.md#2-t%E1%BA%A1o-g%C3%B3i-packages)

[3. Tạo client](https://github.com/thang290298/work-Document/blob/master/Linux/check-list-DA.md#3-t%E1%BA%A1o-client)

[4. Tạo domain, tài khoản FTP, database, up site ví dụ wordpress](https://github.com/thang290298/work-Document/blob/master/Linux/check-list-DA.md#4-t%E1%BA%A1o-domain-t%C3%A0i-kho%E1%BA%A3n-ftp-database-up-site-v%C3%AD-d%E1%BB%A5-wordpress)

[5. Tạo email cho các khg theo tên miền.](https://github.com/thang290298/work-Document/blob/master/Linux/check-list-DA.md#5-t%E1%BA%A1o-email-cho-c%C3%A1c-khg-theo-t%C3%AAn-mi%E1%BB%81n)

[6. Gửi email khi tạo gói cho KHG hoặc thay đổi các thông tin của client](https://github.com/thang290298/work-Document/blob/master/Linux/check-list-DA.md#6-g%E1%BB%ADi-email-khi-t%E1%BA%A1o-g%C3%B3i-cho-khg-ho%E1%BA%B7c-thay-%C4%91%E1%BB%95i-c%C3%A1c-th%C3%B4ng-tin-c%E1%BB%A7a-client)

[7. Backup / restore code, db trên chính máy DA](https://github.com/thang290298/work-Document/blob/master/Linux/check-list-DA.md#7-backup--restore-code-db-tr%C3%AAn-ch%C3%ADnh-m%C3%A1y-da)

[8. Cấu hình SSL Let's encrypt](https://github.com/thang290298/work-Document/blob/master/Linux/check-list-DA.md#8-c%E1%BA%A5u-h%C3%ACnh-ssl-lets-encrypt)

[9. Sử dụng custombuid để thay đổi phiên bản các ứng dụng (hay dùng PHP, MySQL, build Multil version PHP)](https://github.com/thang290298/work-Document/blob/master/Linux/check-list-DA.md#9-s%E1%BB%AD-d%E1%BB%A5ng-custombuid-%C4%91%E1%BB%83-thay-%C4%91%E1%BB%95i-phi%C3%AAn-b%E1%BA%A3n-c%C3%A1c-%E1%BB%A9ng-d%E1%BB%A5ng-hay-d%C3%B9ng-php-mysql-build-multil-version-php)

[10. Xác định file log của DA.](https://github.com/thang290298/work-Document/blob/master/Linux/check-list-DA.md#10-x%C3%A1c-%C4%91%E1%BB%8Bnh-file-log-c%E1%BB%A7a-da)

[11. Đặt lịch backup code + DB định kỳ](https://github.com/thang290298/work-Document/blob/master/Linux/check-list-DA.md#11-%C4%91%E1%BA%B7t-l%E1%BB%8Bch-backup-code--db-%C4%91%E1%BB%8Bnh-k%E1%BB%B3)

[12. Change IP của các máy DA khi đổi máy chủ](https://github.com/thang290298/work-Document/blob/master/Linux/check-list-DA.md#12-change-ip-c%E1%BB%A7a-c%C3%A1c-m%C3%A1y-da-khi-%C4%91%E1%BB%95i-m%C3%A1y-ch%E1%BB%A7)

[13. Add thêm IP cho các domain chạy các IP khác nhau](https://github.com/thang290298/work-Document/blob/master/Linux/check-list-DA.md#13-add-th%C3%AAm-ip-cho-c%C3%A1c-domain-ch%E1%BA%A1y-c%C3%A1c-ip-kh%C3%A1c-nhau)

[14. Cấu hình chuyển các mode httpd](https://github.com/thang290298/work-Document/blob/master/Linux/check-list-DA.md#14-c%E1%BA%A5u-h%C3%ACnh-chuy%E1%BB%83n-c%C3%A1c-mode-httpd)

[15. Cài đặt và sử dụng CSF](https://github.com/thang290298/work-Document/blob/master/Linux/check-list-DA.md#15-c%C3%A0i-%C4%91%E1%BA%B7t-v%C3%A0-s%E1%BB%AD-d%E1%BB%A5ng-csf)


## Thực hiện

 ### 1. Cài đặt DirectAdmin (DA)
- đăng nhập tài khoản Portal được cung cấp
- Tiến hành Rebuild server 
<img src="https://image.prntscr.com/image/EPH8aQo0RHiwf22tQYp2qg.png">

- tích chọn hệ điều hành -> Application-> chọn ` CentOS 7.7- DirectAdmin` -> tích `chọn IMAGE `
- Sau khi chọn hệ điều hành ta tiến hành rebiuld server:
<img src="https://image.prntscr.com/image/yzYKD9ncTmyJnGYu4DQG7A.png">
- Hệ thống sẽ gửi mail thông báo thông tin tài khoản:
<img src="https://image.prntscr.com/image/ajslfSwxRV6ffd5UmgZ8TA.png">

### 2. Tạo gói Packages
- đăng nhập tài khoản reseller:
  - tick chọn `manage User package` rồi tiến hành ` add Package.

  <img src="https://image.prntscr.com/image/-mmAMvHbT5ygy55jQgQRcw.png">
  - Tạo gói Packages
  <img src="https://image.prntscr.com/image/c7zvTeNRTtGCmLPXF7UjPw.png">
  tiến hành cấu hình các gói lưu lượng và bấm ` save ` để lưu.
  <img src="https://image.prntscr.com/image/aqO7yF2bTX_PbuzOe2Wpew.png">
  tạo gói thành công.

### 3. Tạo client
 <img src="https://image.prntscr.com/image/WHfiAj1xS2iDfPkv9C3CRQ.png">
 - Trong đó:

   - Username: Tên của user, dùng để đăng nhập vào quản lý hosting của user đó.
   - E-mail: E-mail dùng để liên lạc với user đó, bao gồm việc gửi thông tin về tài khoản và các thông báo từ Reseller.
   - Enter Password: Đặt mật khẩu cho user.
   - Re-enter Password: Gõ lại mật khẩu cho user ( cần gõ chính xác với mật khẩu ở trên)
   - Domain: Tên miền của user.
   - Use User Package: Chọn gói cho user này.
   - IP; Chọn IP cho user, nếu không có IP riêng thì user sẽ sử dụng IP của share hosting.
   - Send Email Notification: Gửi thông tin về tài khoản cho user. Tùy chọn Edit User Message dùng để chỉnh sửa email mà bạn sẽ thông báo cho user này về thông tin tài khoản. Nếu bạn không muốn chỉnh sửa Email thông báo mặc định thì bỏ dấu tích ở tùy chọn này.

Sau đó bạn ấn vào `Submit `để hoàn thành việc tạo 1 user mới.

### 4. Tạo domain, tài khoản FTP, database, up site ví dụ wordpress
- Tạo tên miền :
sau khi đăng nhập bằng tài khoản user hệ thống yêu cầu nhập thông tin tên miền hoặc tạo mới. Chọn `Add domain` và nhập tên miền.

<img src="https://image.prntscr.com/image/VYk-GhmGSG6SgTcSUrcKow.png">
- Tạo tài khoản FTP:

  - chọn vào  `FTP Mangagement` rồi tạo mới tài khoản FTP:
<img src="https://image.prntscr.com/image/hNcPdolSRY_VM9Te_kx_eA.png">
  - điền thông tin tài khoản:
<img src="https://image.prntscr.com/image/eDWJLt8iQfSZwkPDatWQ4g.png">
  - kết quả: 
  <img src="https://image.prntscr.com/image/fRMX4UUpQSuit5mDHxBu0A.png">
- Tạo database:
  - Create new database:

  <img src="https://image.prntscr.com/image/MmFh25HMRa_pAHy5B6z7cQ.png">   

  - điền thông tin database rồi chọn pass `random` và bấm vào `Create` để tạo mới database:

   <img src="https://image.prntscr.com/image/u_YCY_p5TaiTpN38u0CVsQ.png">  

   - sau khi hoàn thành hệ thống sẽ hiển thị thông tin database 
   <img src="https://image.prntscr.com/image/vgCCW0b2TAmbypXvgc7Lqg.png">  
- up site ví dụ wordpress
   1 sử dụng filezilla để đẩy bản nén wordpress:
 <img src="https://image.prntscr.com/image/r5bebSbxRVioL2lMuXMTMQ.png">
   sau khi upload file tiến hành giải nén, coppy vào thư mục public_html và tiến hành cấu hình database như đã tạo bên trên:

 <img src="https://image.prntscr.com/image/KZPeITbETvyIdb29U9UIgA.png">
  
  sau khi cấu hình kiểm tra trên website

  <img src="https://image.prntscr.com/image/95xtV0Y7SQuLBoL4igo3vQ.png">

### 5. Tạo email cho các khg theo tên miền.
- Chọn tên miền muốn sử dụng, ở đây tôi sử dụng tên miền learning365.online:
<img src="https://image.prntscr.com/image/vjFWn8g8T3OpBR-759nrTg.png">

- Vào email Account tích chon `create mail account`
<img src="https://image.prntscr.com/image/GvZ9VhA3TIWEOHAUYmNTcQ.png">
- Điền thông tin và khởi tạo email:
<img src="https://image.prntscr.com/image/WaYXZYUcSpmE7uR2FkdyPg.png">
- thông tin mail theo tên miền sẽ được hiển thị sau khi tạo thành công
<img src="https://image.prntscr.com/image/emQ3Z4EKT0SS_nzXUij8og.png">
- đăng nhập Webmail:
<img src="https://image.prntscr.com/image/ngAY4_b0Tw2mosC2CK8MBA.png">

### 6. Gửi email khi tạo gói cho KHG hoặc thay đổi các thông tin của client
- khi tạo gói cho khách hàng để gửi mail thông báo ta tích chọn vào `Send Email Notification:`
<img src="https://image.prntscr.com/image/6X6P4FbiSKSgWtwDpfNDvg.png">

- sau khi thay đổi cấu hình tiến hành gửi mail thông báo tới khách hàng và những người có liên quan bằng cách gửi thông báo ở nút `send` trong phần ` Resend Welcome E-Mail`
<img src="https://image.prntscr.com/image/oLTywJOETre3vE0qQspQgA.png">

### 7. Backup / restore code, db trên chính máy DA
- Backup: 
   - user:
chọn ` Create Restore/Backups` bỏ tick phần ` E-mail và FTP` sau đó chọn create backups:
<img src="https://image.prntscr.com/image/SoJNBX6XQRynYPtxF8PD_Q.png">

 sau khi backup hệ thống sẽ gửi mail thông báo:
 để xem lại các bản backup ta chọn `Click here for a list of your current backups`
 <img src="https://image.prntscr.com/image/ZInHgdcfSD2Lsug0vLPXsw.png">
   - admin:
        - đối với tài khoản admin có thể đặt lịch backup hay chọn backup theo user hoặc tất cả user
        - có thể sử dụng tính năng backup lưu trữ sang server khác
    
 <img src="https://image.prntscr.com/image/QY1z6aWDRqKVNM_pRxCOcA.png">
       
        - step 1: đối tượng backups
        - step 2: thời gian backups
        - step 3: vị trí lưu
        - Step 4: nội dung backup
- Restore :
    - user:
       - để restore dữ liệu ở mục ` Select a File  to Restore` chọn bản backup phù hợp và chọn restore
<img src="https://image.prntscr.com/image/8fDBmX52SRqaLSDw6_u-AA.png">

    - admin: 
        - có thể restore từ file backups trong máy hoặc up file từ thiết bị khác
<img src="https://image.prntscr.com/image/dpetU8naR4qHsig0zGhsqw.png">

### 8. Cấu hình SSL Let's encrypt
- đăng nhập DA bằng tài khoản user kéo xuống phần `advanced features` chọn `SSL Certificates`

<img src="https://image.prntscr.com/image/5oWWgwZOSP2gZi2qgTDOZQ.png">

Tích chọn ô 1 và 2 như ảnh dưới đây. Mục 3 điền email của quý khách vào . Key Size (bits), Certificate Type chọn như hình dưới đây. Sau đó kéo chuột xuống dưới và click “save”
*Chú ý*: SSL is currently enabled for this domain.



<img src="https://image.prntscr.com/image/pIC9ZewVTmW1Vn2rZY6URg.png">
sau khi cài đặt hệ thống sẽ sinh ra keyl, tiếp tục điều hường ssl sang https và chứng thực chứng chỉ với tổ chức phát hành

<img src="https://image.prntscr.com/image/azQWWJL5SIChqwZcKNL9vQ.png">
Sau khi cài đạt kiểm tra chwusng chỉ SSL:
<img src="https://image.prntscr.com/image/Noubw_teRBOO_-35M6mxig.png">

### 9. Sử dụng custombuid để thay đổi phiên bản các ứng dụng (hay dùng PHP, MySQL, build Multil version PHP)
- đăng nhập hệ thống với tài khoản `Admin` và phần `CustomBuild 2.0`
<img src="https://image.prntscr.com/image/hLnJt7TdRfWqmSo0GEI9EQ.png">
- tới phần ` Edit Opition` chọn các phiên bản muốn cài đặt và lưu lại

<img src="https://image.prntscr.com/image/A3Tjxy08TUO-qxP8IrlZ7g.png">


### 10. Xác định file log của DA.
- Sau khi bạn đăng nhập vô tài khoản DirectA dmin bằng quyền user, xong rồi các bạn vô trong mục “site summary / statistics / logs” như hình bên dưới 
<img src="https://image.prntscr.com/image/sFHf_1djQuq-0VifqA3ofA.png">

Bạn có thể xem log ở nhiều dạng khác nhau: xem toàn bộ log, xem 100 dòng đầu tiên hoặc 10 dòng đầu tiên
<img src="https://image.prntscr.com/image/VtuBC_erQWK0Gp5mAR9zsA.png">

sau đây mình hướng dẫn các bạn cách xem và phân tích một đoạn log cơ bản

<img src="https://image.prntscr.com/image/HG9Xu_bsRlW_E5g3N9UdoQ.png">

  - Thường thì bạn nên lưu file log đó thành file text sau đó mình sẽ phân tích cho dễ, trên đó mình sẽ nhìn thấy trực quan hơn. Những thông tin quan trọng thường bạn hay quan tâm đó:

    - ip: những ip nào thường xuyên truy cập, đối với ddos thì điều này rất quan trọng.
    -thời gian: thời gian cho chúng ta biết đối tượng phá hoại hành động vào lúc nào, từ đó mình sẽ dễ theo dõi và xác định đối tượng dùng tool hay dùng tay.
    - đường dẫn: đây là một thông tin khá quan trọng, nhất là đối với lỗ hổng website, giúp bạn biết được đối tượng đánh vào vị trí nào, file nào.
    - thông tin trình duyệt cũng là một yếu tố cũng rất có lợi cho bạn, bạn có thể ngăn chặn ddos, thường thì đối tượng nếu dùng tool đời cũ sẽ có lỗ hổng về chỗ này, các trình duyệt nó thống nhất với nhau, bạn có thể dễ dàng chặn được.

còn các yếu tố khác, tùy tho từng trường hợp mà các bạn có cách ứng phó và khắc phục khác nhau, chúc các bạn thành công.

### 11. Đặt lịch backup code + DB định kỳ
để đặt lịch Backup cho DA bạn đăng nhập hệ thống bàng tài khoản Admin.
  <img src="https://image.prntscr.com/image/N69FIawGQNygTCv_idm99Q.png">

  <img src="https://image.prntscr.com/image/NMJ90r-UTRqIJmg-EDKDuA.png">

### 12. Change IP của các máy DA khi đổi máy chủ

Sau khi đã đổi IP hoặc migrate dữ liệu thành công, login vào server thông qua giao thức SSH với tài khoản root
``` 
ssh root@45.117.80.147
```
Di chuyển đến thư mục chứa các script hỗ trợ của DA
```
cd /usr/local/directadmin/scripts
```
Chạy script đổi IP trong đó:

   103.124.94.180 là IP cũ
   45.117.80.147 là IP mới

```
./ipswap.sh 103.124.94.180 45.117.80.147
```
Nếu thực hiện thành công, tại màn hình Terminal ta sẽ thấy kết quả như sau
```
*** Done swapping 103.124.94.180 to 45.117.80.147 ***
```

<img src="https://image.prntscr.com/image/ujtZ2NDIQV6pS4n3u7RxNQ.png">

Restart các service
```
systemctl restart httpd
systemctl restart proftpd
systemctl restart exim
systemctl restart dovecot
```

### 13. Add thêm IP cho các domain chạy các IP khác nhau
Phần này bao gồm việc hiểu các danh mục IP, thêm, chỉ định và xóa địa chỉ IP.
Từ menu Administrator menu, nhấp vào liên kết "IP ManagerP". Bạn sẽ thấy một trang trông giống như sau:
<img src="https://image.prntscr.com/image/I9kBHc-gRNy6kr1r0vMq2w.png">
Trình quản lý IP cho phép bạn thêm địa chỉ IP vào bảng điều khiển và phân bổ chúng cho Người bán lại của bạn.

để add ip cho user bấm chọn `ADD IP`:
<img src="https://image.prntscr.com/image/wUZvhUvASZ_jhN-hASdfzw.png">
Bạn phải cho người quản lý IP biết địa chỉ IP nào được cấp cho máy chủ của bạn. Để thêm địa chỉ IP, hãy nhấp vào nút "Thêm IP" ở đầu màn hình, nhập địa chỉ IP mong muốn của bạn và nhấp lại vào nút "Thêm IP". Địa chỉ IP sau đó sẽ xuất hiện trong bảng với trạng thái miễn phí.

Giá trị Netmask thường là 255.255.255.0 nhưng bạn có thể thay đổi giá trị này nếu cần.
<img src="https://image.prntscr.com/image/2ft_lAz2TrewM6pvP8rykA.png">
   - assgin: Để chỉ định địa chỉ IP cho Người bán lại, hãy đặt dấu kiểm bên cạnh (các) địa chỉ IP bạn muốn chỉ định, sau đó chọn tên Người bán lại từ menu thả xuống. Sau đó, nhấp vào nút "Chỉ định" ở đầu bảng.
   - Removing IP Addresses from Resellers: Để xóa địa chỉ IP khỏi Người bán lại, hãy đặt dấu kiểm bên cạnh (các) địa chỉ IP bạn muốn xóa và nhấp vào nút "Xóa khỏi người bán lại". Xin lưu ý rằng bạn chỉ có thể xóa các địa chỉ IP "miễn phí". Nghĩa là, nếu địa chỉ IP thuộc sở hữu của Người bán lại hoặc một trong những Người dùng của họ, chức năng xóa sẽ không hoạt động.
   - clear NS: xóa nameserver
   - Delete : xóa ip

### 14. Cấu hình chuyển các mode httpd
sử dụng tính năng `custombuild 2.0` để chuyển đổi các chế đội httpd
<img src="https://image.prntscr.com/image/jGCeLsv6SmeT-yuL9jSB9A.png">

kéo xuống phần `WEB Server Settings` chọn ` Apache_mpm`
<img src="https://image.prntscr.com/image/JwJQFz8wSdqUJN7k20dhmA.png">
chọn chế độ httpd mong muốn.

### 15. Cài đặt và sử dụng CSF
#### Bước 1: Cài đặt các module cần thiết cho CSF

```
yum install perl-libwww-perl -y
```

#### Bước 2: Tải CSF

```
cd /tmp
wget https://download.configserver.com/csf.tgz
```

#### Bước 3: Cài đặt CSF

```
tar -xzf csf.tgz
cd csf
sh install.sh
```

#### Bước 4: Cấu hình CSF

Cấu hình mặc định của CSF ở chế độ `Testing`, điều đó có nghĩa hệ thống chưa được bảo vệ toàn diện. Để tắt chế độ `Testing` bạn cần cấu hình các lựa chọn TCP_IN, TCP_OUT, UDP_IN và UDP_OUT cho phù hợp với nhu cầu:

Mở file cấu hình CSF

```
vi /etc/csf/csf.conf
```

Tắt chệ độ Testing bằng cách chuyển dòng `TESTING="1"` thành `
```
TESTING="0"
```

Lưu cấu hình lại.

#### Bước 5: Khởi động CSF và cho phép CSF khởi động cùng hệ thống

```
 systemctl start csf
 systemctl enable csf
```

#### 3. Những file cấu hình của CSF

Toàn bộ thông tin cấu hình và quản lý CSF được lưu ở các file trong folder /etc/csf. Nếu bạn chỉnh sửa các file này thì cần khởi động lại CSF để thay đổi có hiệu lực.

- **csf.conf:** File cấu hình chính để quản lý CSF.

- **csf.allow:** Danh sách địa chỉ IP cho phép qua firewall.

- **csf.deny:** Danh sách địa chỉ IP từ chối qua firewall.

- **csf.ignore:** Danh sách địa chỉ IP cho phép qua firewall và không bị block nếu có vấn đề.

- **csf.*ignore:** Danh sách user, IP bị ignore.

#### 4. Một số lệnh thường dùng trong CSF

Một số câu lệnh sử dụng để add (-a) hoặc deny (-d) một địa chỉ IP.

```
csf -d IPADDRESS //Block địa chỉ IP
csf -dr IPADDRESS //Xóa địa chỉ IP đã bị block
csf -a IPADDRESS //Allow địa chỉ IP
csf -ar IPADDRESS //Xóa địa chỉ IP đã được allow
csf -g IPADDRESS //Kiểm tra địa chỉ IP có bị block không
csf -r //Khởi động lại CSF
csf -x //Tắt CSF
csf -e //Mở CSF
```

#### 5. Xóa cài đặt CSF

Nếu muốn xóa cài đặt CSF, chỉ cần sử dụng lệnh

```
/etc/csf/uninstall.sh
```

Việc này sẽ xóa toàn bộ CSF nên bạn cần cân nhắc khi dùng. Nếu muốn tạm thời tắt CSF thì có thể chuyển chế độ TESTING sang 1.

#### 6. Sủ dụng CSF trên DA
sử dụng tính năng `ConfigServer Security & Firewall`

<img src="https://image.prntscr.com/image/ZNLbuv_UQHSA4UugFlZMNw.png">

một số tính năng
<img src="https://image.prntscr.com/image/KdKQZBAaTeWekg9Y3NpTxA.png">

  - Quick Allow ip: Cho phép địa chỉ IP thông qua tường lửa và thêm vào tệp cho phép (csf.allow).
  - QuickDeny IP : Chặn địa chỉ IP trong tường lửa và thêm vào tệp từ chối (csf.deny).
  - Quick Ignore IP: Bỏ qua địa chỉ IP trong lfd, thêm vào tệp bỏ qua (csf.ignore) và khởi động lại lfd
  - Quick unblock IP:Xóa địa chỉ IP từ tường lửa (các khối tạm thời và cố định)
  - Search IP: Tìm kiếm địa chỉ IP trên iptables

