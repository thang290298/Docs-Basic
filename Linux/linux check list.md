# Check list các kỹ thuật Linux

## Mục lục 

[1. Kiểm tra tài nguyên sử dụng của MySQL, HTTP](https://github.com/thang290298/work-Decument/blob/master/Linux/linux%20check%20list.md#ki%E1%BB%83m-tra-t%C3%A0i-nguy%C3%AAn-s%E1%BB%AD-d%E1%BB%A5ng-c%E1%BB%A7a-mysql-http)

[2. Kiểm tra log tại thời điểm bị thông báo Out of Memory](https://github.com/thang290298/work-Decument/blob/master/Linux/linux%20check%20list.md#ki%E1%BB%83m-tra-log-t%E1%BA%A1i-th%E1%BB%9Di-%C4%91i%E1%BB%83m-b%E1%BB%8B-th%C3%B4ng-b%C3%A1o-out-of-memory)

[3. Kiểm tra các tiến trình sử dụng nhiều tài nguyên](https://github.com/thang290298/work-Decument/blob/master/Linux/linux%20check%20list.md#ki%E1%BB%83m-tra-c%C3%A1c-ti%E1%BA%BFn-tr%C3%ACnh-s%E1%BB%AD-d%E1%BB%A5ng-nhi%E1%BB%81u-t%C3%A0i-nguy%C3%AAn)

[4. Kiểm tra các IP truy cập vào Apache nhiều nhất](https://github.com/thang290298/work-Decument/blob/master/Linux/linux%20check%20list.md#ki%E1%BB%83m-tra-c%C3%A1c-ip-truy-c%E1%BA%ADp-v%C3%A0o-apache-nhi%E1%BB%81u-nh%E1%BA%A5t)

[Tài liệu tham khảo](https://github.com/thang290298/work-Decument/blob/master/Linux/linux%20check%20list.md#t%C3%A0i-li%E1%BB%87u-tham-kh%E1%BA%A3o)

## Kiểm tra tài nguyên sử dụng của MySQL, HTTP

Để kiểm tra tài nguyên sử dụng của các ứng dụng, ta có thể sử dụng lệnh `ps` cùng với các options để lọc ra những trường mà mình muốn.

Ta có thể sử dụng thêm lệnh `sort` để sắp xếp kết quả

- Kiểm tra tài nguyên RAM của MySQL, HTTP

`ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | grep mysqld`

`ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | grep httpd`

Trong đó:

	- `-eo`: dùng để hiển thị các đầu ra cụ thể được in ra (PID,User, %RAM)

	- `--sort`: Sắp xếp kết quả in ra theo thứ tự từ lớn đến bé với cột %mem
	
	- `grep`: Tuỳ chọn xuất ra tiến trình MYSQL hoặc HTTP

- Kiểm tra tài nguyên CPU của MySQL, HTTP

`ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | grep mysqld`

`ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | grep httpd`

## Kiểm tra log tại thời điểm bị thông báo Out of Memory

Tại thời điểm có thông báo "Out of Memory", lúc này sẽ có log được lưu tại `var/log/messages`. Ta có thể truy cập vào đó để kiểm tra.

`cat /var/log/messages | grep memory`

Sử dụng lệnh `grep` để lọc ra các log có liên quan đến memory.

## Kiểm tra các tiến trình sử dụng nhiều tài nguyên

Để kiểm tra tài nguyên của hệ thống một cách đơn giản, ta sử dụng những lệnh sau:

- `free -m`: Kiểm tra dung lượng RAM.

- `top -c`: Kiểm tra CPU.

- `df -h`: Kiểm tra dung lượng DISK.

Để kiểm tra các tiến trình sử dụng nhiều tài nguyên, ta cũng sẽ sử dung lệnh `ps` cùng với các options để lọc ra các tiến trình chiếm nhiều tài nguyên nhất.

- `ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 10`: Lọc ra 10 tiến trình sử dụng nhiều tài nguyên được sắp xếp từ lớn đến bé với %Ram sử dụng nhiều nhất.

- `ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 10`: Lọc ra 10 tiến trình sử dụng nhiều tài nguyên được sắp xếp từ lớn đến bé với %CPU sử dụng nhiều nhất.

## Kiểm tra các IP truy cập vào Apache nhiều nhất

Để kiểm tra các IP truy cập vào Webserver nói riêng và Apache nói chung, ta sử dụng lệnh `awk` để in ra kết quả tại `access_log` của Apache. Ta có thể sử dụng thêm lệnh `sort` để lọc kết quả.

`awk '{ print $1}' đường dẫn access.log | sort | uniq -c | sort -nr | head -n 10`

Trong đó:

- `awk '{ print $1}' đường dẫn access.log`: In ra cột đầu tiên của access.log.

- `uniq -c`: Báo cáo các dòng lặp lại để tổng hợp IP truy cập nhiều.

- `sort -nr`: Kết quả khi in ra sẽ được sắp xếp theo thứ tự từ lớn đến bé.

- `head -n 10`: Hiển thị ra 10 dòng đầu tiên theo bộ lọc.

## Tài liệu tham khảo

https://www.tecmint.com/find-top-ip-address-accessing-apache-web-server/

https://www.tecmint.com/find-linux-processes-memory-ram-cpu-usage/

https://phoenixnap.com/kb/check-cpu-usage-load-linux

https://linuxhint.com/check_memory_usage_process_linux/
