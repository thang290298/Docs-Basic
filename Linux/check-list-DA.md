1. Cài đặt DirectAdmin (DA)
- đăng nhập tài khoản Portal được cung cấp
- Tiến hành Rebuild server 
<img src="https://image.prntscr.com/image/EPH8aQo0RHiwf22tQYp2qg.png">

- tích chọn hệ điều hành -> Application-> chọn ` CentOS 7.7- DirectAdmin` -> tích `chọn IMAGE `
- Sau khi chọn hệ điều hành ta tiến hành rebiuld server:
<img src="https://image.prntscr.com/image/yzYKD9ncTmyJnGYu4DQG7A.png">
- Hệ thống sẽ gửi mail thông báo thông tin tài khoản:
<img src="https://image.prntscr.com/image/ajslfSwxRV6ffd5UmgZ8TA.png">

2. Tạo gói Packages
- đăng nhập tài khoản reseller:
  - tick chọn `manage User package` rồi tiến hành ` add Package.

  <img src="https://image.prntscr.com/image/-mmAMvHbT5ygy55jQgQRcw.png">
  - Tạo gói Packages
  <img src="https://image.prntscr.com/image/c7zvTeNRTtGCmLPXF7UjPw.png">
  tiến hành cấu hình các gói lưu lượng và bấm ` save ` để lưu.
  <img src="https://image.prntscr.com/image/aqO7yF2bTX_PbuzOe2Wpew.png">
  tạo gói thành công.
3. Tạo client
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

4. Tạo domain, tài khoản FTP, database, up site ví dụ wordpress
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

5. Tạo email cho các khg theo tên miền.
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

6. Gửi email khi tạo gói cho KHG hoặc thay đổi các thông tin của client
- khi tạo gói cho khách hàng để gửi mail thông báo ta tích chọn vào `Send Email Notification:`
<img src="https://image.prntscr.com/image/6X6P4FbiSKSgWtwDpfNDvg.png">

- sau khi thay đổi cấu hình tiến hành gửi mail thông báo tới khách hàng và những người có liên quan bằng cách gửi thông báo ở nút `send` trong phần ` Resend Welcome E-Mail`
<img src="https://image.prntscr.com/image/oLTywJOETre3vE0qQspQgA.png">

7. Backup / restore code, db trên chính máy DA
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

8. Cấu hình SSL Let's encrypt
9. Sử dụng custombuid để thay đổi phiên bản các ứng dụng (hay dùng PHP, MySQL, build Multil version PHP)
10. Xác định file log của DA.
11. Đặt lịch backup code + DB định kỳ
12. KIểm tra log http, ram, cpu
13. Change IP của các máy DA khi đổi máy chủ
14. Add thêm IP cho các domain chạy các IP khác nhau
15. Cấu hình chuyển các mode httpd
16. Cài đặt và sử dụng CSF