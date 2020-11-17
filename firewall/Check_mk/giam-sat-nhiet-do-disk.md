# Giám sát nhiệt độ disk

Nhiệt độ bình thường của các thiết bị:

- CPU: 60, 70 độ C
- HDD: 40, 50 độ C
- Các thiết bị khác: 70, 80 độ C

Ở đây chúng ta giám sát nhiệt độ disk bằng plugin S.M.A.R.T

Vào host cần giám sát disk chạy các lệnh sau:

    yum install smartmontools -y && sudo apt-get install smartmontools
    cd /usr/lib/check_mk_agent/plugins
    wget https://raw.githubusercontent.com/uncelvel/tutorial-ceph/master/docs/monitor/check_mk/plugins/smart
    chmod +x smart
    ./smart

Sau đó vào giao diện web checkmk discovery host vừa cài plugin và active change.

Kết quả:

<img src="https://image.prntscr.com/image/j_EeQy-xTmiAlWs1F7JDmw.png">

## Sử dụng smartctl 

- `-H`: Quan sát trạng thái ổ đĩa

<img src="https://image.prntscr.com/image/0lfKQIRmR3WxcVL8jMBtWw.png">

- `-i`: Xem thông tin (infomation) của ổ. Trong một hệ thống có nhiều ổ cứng, việc ghi chép đầy đủ các thông tin này có thể hỗ trợ bạn trong việc biết ổ cứng nào (chẳng hạn như /dev/sda) tương ứng với ổ đĩa vật lý nào

<img src="https://image.prntscr.com/image/1su72jitTPG8_d5Skh-P5A.png">


- `-a`: hiển thị các chi tiết kỹ thuật cho các thuộc tính SMART và lưu ký quá trình test. Nó hiển thị các thông tin trạng thái SMART khác nhau, chẳng hạn như nhiệt độ ổ cứng, ổ cứng đã hoạt động được bao nhiêu giờ,… Nó cũng chỉ thị thời điểm test được thực hiện và các kết quả cho các lần test đó là gì.

<img src="https://image.prntscr.com/image/iBxp2naqQRWeiYf7UWlYuQ.png">

Cuối cùng, smartctl có thể được sử dụng để khởi tạo các quá trình test ngắn và dài cho ổ cứng. Các quá trình này có thể được chạy một cách định kỳ để thực hiện hành động test nhanh, toàn bộ, hay tự test (self-test) ổ đĩa.

    smartctl --test=short /dev/sda
    smartctl --test=long /dev/sda
    smartctl -a /dev/sda