# Tổng quan về Crontab
## 1. Crontab là gì?
- Cron là một tiện ích cho phép thực hiện các tác vụ một cách tự động theo định kỳ, ở chế độ nền của hệ thống. Crontab (CRON TABle) là một file chứa đựng bảng biểu (schedule) của các entries được chạy.
## 2. Crontab là việc như thế nào?
- Một cron schedule đơn giản là một text file. Mỗi người dùng có một cron schedule riêng, file này thường nằm ở /var/spool/cron. Crontab files không cho phép bạn tạo hoặc chỉnh sửa trực tiếp với bất kỳ trình text editor nào, trừ phi bạn dùng lệnh crontab.
Một số lệnh thường dùng:
```
crontab -e: tạo hoặc chỉnh sửa file crontab 
crontab -l: hiển thị file crontab 
crontab -r: xóa file crontab
```
Hầu hết tất cả VPS đều được cài đặt sẵn crontab, tuy nhiên vẫn có trường hợp VPS không có. Nếu bạn sử dụng lệnh crontab -l mà thấy output trả lại -bash: crontab: command not found thì cần tự cài crontab thủ công.

### Cài đặt Crontab
Sử dụng lệnh:
```
yum install cronie
```
Start Crontab tự động chạy mỗi khi `reboot` :
```
service crond start
chkconfig crond on
```
## 3. Cấu trúc của Crontab
- Một crontab file có 5 trường xác định thời gian, cuối cùng là lệnh sẽ được chạy định kỳ, cấu trúc như sau:

```
*     *     *     *     *     command to be executed
-     -     -     -     -
|     |     |     |     |
|     |     |     |     +----- day of week (0 - 6) (Sunday=0)
|     |     |     +------- month (1 - 12)
|     |     +--------- day of month (1 - 31)
|     +----------- hour (0 - 23)
+------------- min (0 - 59)
```
- Nếu một cột được gán ký tự *, nó có nghĩa là tác vụ sau đó sẽ được chạy ở mọi giá trị cho cột đó.

| Field | Giải thích       | Giá trị cho phép          |
|-------|------------------|---------------------------|
| MIN   | phút             | 0 to 59                   |
| HOUR  | Giờ              | 0 to 23                   |
| DOM   | Ngày trong tháng | 1-31                      |
| MON   | Tháng            | 1-12                      |
| DOW   | Ngày trong tuần  | 0-6                       |
| CMD   | Lệnh             | Các lệnh có thể thực hiện |

#### Ví dụ
- Chạy script 15 phút 1 lần:
```
*/30 * * * * command
hoặc
0,15,30,45 * * * * command
```
- Chạy script vào 6 giờ sáng mỗi ngày:
```
0 6 * * * command
```
## 4. Ví dụ cụ thể

Giả sử mình viết một đoạn script sao lưu toàn bộ thư mục /var/www/html/ và chuyển file nén .zip vào thư mục /home/Backup/code/ như sau:
```
#!/bin/bash
SRCDIR="/var/www/html/*"
DESTDIR="/home/Backup/code/"
FILENAME=wpcode-$(date +%-Y%-m%-d)-$(date +%-T).tgz
tar -P --create --gzip --file=$DESTDIR$FILENAME $SRCDIR
```
Script này lưu lại ở đường dẫn /opt/scripts/backup.sh (gán quyền execute – chmod +x nếu là bash script).

Sau đó mình cho script này chạy định kỳ vào 1h sáng  thứ Hai và thứ Năm hàng tuần bằng cách tạo một file crontab như sau:
```
crontab -e
```
nhấp chữ "o"  để thêm nội dung
```
0 1 * * 1,4 /opt/scripts/backupcode.sh 
```

Để lưu lại và thoát bạn nhấn ESC, rồi gõ vào :wq nhấn Enter.

Cuối cùng, nhớ khởi động lại cron daemon
```
/etc/init.d/crond restart
```
## 5. Disable Email
- Mặc định cron gửi email cho người thực thi cron job, nếu bạn muốn tắt chức năng gửi email này đi thì hãy thêm đoạn sau vào cuối dòng
```
>/dev/null 2>&1
```

#### Ví dụ
```
0 1 * * 1,4 /opt/scripts/backupcode.sh >/dev/null 2>&1
```

# Nguồn tham khảo

https://hocvps.com/tong-quat-ve-crontab/

https://viblo.asia/p/lap-lich-tasks-tren-linux-su-dung-crontab-6J3Zg28MKmB