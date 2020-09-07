# Cấu hình chế độ Slow Queries cho MySQL hoặc MariaDB

## Giới thiệu

Enable Slow query MySQL® hoặc MariaDB có thể là một công cụ hữu ích để chẩn đoán các vấn đề về hiệu suất và hiệu quả ảnh hưởng đến máy chủ.

Bằng cách xác định các truy vấn đặc biệt chậm trong quá trình thực thi của chúng, bạn có thể giải quyết chúng bằng cách cấu trúc lại ứng dụng kích hoạt các truy vấn.

## Các bước thực hiện

### Bước 1: Đăng nhập vào SSH bằng quyền root

### Bước 2: Chỉnh sửa cấu hình

Ta chỉnh cấu hình tại file `/etc/my.cnf` để bật chế độ Slow Query.

`vi /etc/my.cnf`

Thêm cấu hình sau vào cuối file:

```
slow_query_log = 1
long_query_time = 1
slow_query_log_file = /var/log/slow-query.log
log_queries_not_using_indexes
```

**Chú ý**: Từ phiên bản MySQL 5.6 trở lên , hãy sử dụng log-slow-queries thay cho biến slow-query_log_file.

### Bước 3: Tạo file log và gán quyền cho user mysql

Với việc cấu hình trên, ta phải tạo file log tại đường dẫn `/var/log/mysql/slow-query.log` mới có thể thành công được. Sau đó gán quyền truy cập cho user `mysql`

```
touch /var/log/slow-query.log
chown mysql:mysql /var/log/slow-query.log
```

### Bước 4: Khởi động lại MySQL hoặc MariaDB

```

sudo systemctl restart mysql

```

## Kiểm tra log slow query

- Hiển thị tất cả các bản ghi Slow query, ta sử dụng lệnh `mysqldumpslow`:

`mysqldumpslow -a /var/log/slow-query.log`

- Xem slow query log:

`sudo tail -f /var/log/slow-query.log`

## Tài liệu tham khảo
https://blog.cloud365.vn/logging/Enable-slow-query-log-mysql/