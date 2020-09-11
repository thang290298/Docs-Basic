# Hướng dẫn tạo Scripts backup database và  Source code
Để tạo Scripts Backup cho WordPress, ta nên tạo 2 file Scripts riêng biệt để Backup Source Code riêng và Backup cho Cơ Sở dữ liệu riêng để dễ dàng quản lý.

## 1. Tạo Scripts backup database.
- Bước 1: Tạo thư mục chưa file backup;
  - tạo thư mục chưa file backup database và chưa file script:
```
mkdir -p /home/Backup/DB
mkdir -p /opt/scripts
```
- Bước 2: Tạo file Scripts
```
cd
vi /opt/scripts/backupdb.sh
```
  - Thêm nội dung dưới đây vào file vừa tạo
```
#!/bin/bash
# Định nghĩa root hoặc DB admin
DBHOST=localhost
DBUSER=nvt292
DBPASS=Thang@292
#Thư mục lưu backup
BACKUPDIR=/home/Backup/DB
# format is YYYYMMDD
DATE=`date +%Y%m%d`
mkdir -p "$BACKUPDIR/$DATE"
cd "$BACKUPDIR/$DATE"

MUTTXT=/home/Backup/DB/backupmysql.txt
#Lấy list databases trên server
DBS=`mysql --host=$DBHOST -p$DBPASS -u $DBUSER --skip-column-names -e "show databases;" | awk  '{ print $1 }' | grep -v "information_schema"`
#Dumping database
for i in $DBS
do
        # format is dbname-YYYYMMDD.gz
        DBOUT=$i.sql.gz
        echo Backing up $i to $DBOUT

        #set umask to protect file
        umask 006

        mysqldump -u $DBUSER -h $DBHOST -p$DBPASS --add-drop-table $i | gzip -9 - > $DBOUT

        echo "Backup successfully done. Please see attached file." > $MUTTXT
        echo "" >> $MUTTXT
        echo "Backup file: $DBOUT" >> $MUTTXT
        echo "" >> $MUTTXT
done
# Xóa các bản backup cũ hơn 30 ngày
echo deleting backups older than 30 days:
find "$BACKUPDIR" -mindepth 1 -a -type d -mtime +30 -exec rm -rf {} \;
```
- Bước 3: Gán quyền thực thì cho file Scripts vừa tạo:
```
chmod +x /opt/scripts/backupdb.sh
```
- Bước 4: Chạy Scripts vừa tạo
``` 
sh /opt/scripts/backupdb.sh
```
Sau khi backup Scripts sẽ tạo thư mục có tên  dạng `date +%Y%m%d`
và 1 file .txt chưa nội dung thông báo backup thành công:

<img src="https://github.com/thang290298/work-Document/blob/master/Images/wordpress/backupdata.png?raw=true">

## 2. Tạo Scrips Backup Source code Wordpress

- Bước 1: Tạo thư mục chưa file backup;
  - tạo thư mục chưa file backup database và chưa file script:
```
mkdir -p /home/Backup/code
```
- Bước 2: Tạo file Scripts
``` 
vi /opt/scripts/backupcode.sh
```
  - Thêm nội dung bên dưới vào file vừa tạo

  ```
  #!/bin/bash
SRCDIR="/var/www/html/*"
DESTDIR="/home/Backup/code/"
FILENAME=wpcode-$(date +%-Y%-m%-d)-$(date +%-T).tgz
tar -P --create --gzip --file=$DESTDIR$FILENAME $SRCDIR
# Xóa các bản backup cũ hơn 30 ngày
echo deleting backups older than 30 days:
find "$FILENAME" -mindepth 1 -a -type d -mtime +30 -exec rm -rf {} \;
```
- Bước 3: Gán quyền thực thì cho file Scripts vừa tạo:
```
chmod +x /opt/scripts/backupcode.sh
```

Bước 4: Chạy Script vừa tạo
```
``` 
sh /opt/scripts/backupcode.sh
```
Sau khi tiến hành backup, file back up sẽ có dạng `wpcode-2020911-00:10:04.tgz`
## 3. Lưu vào Crontab để tự động chạy Scripts hàng ngày
gõ lệnh `crontab -e`
   - Đặt lịch thực thi cho 2 Scripts backup:
   ```

     0 1 * * * /opt/scripts/backupdb.sh >/dev/null 2>&1
     0 1 * * * /opt/scripts/backupcode.sh >/dev/null 2>&1
  ```

  Hai Scripts sẽ tự động chạy vào 1 giờ sáng hàng ngày.



  # Nguồn tham khảo
  https://1hosting.com.vn/scripts-backup-toan-bo-database-mysql-tren-vps-linux/

  https://vpssim.vn/1731-huong-dan-tu-dong-backup-code-va-database-sang-mot-servervps-khac.html