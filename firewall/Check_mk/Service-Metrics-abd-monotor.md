# Dịch vụ, Metrics và giám sát

https://checkmk.com/cms_intro.html

Như đã nói ở phần 2:

Service: một dịch vụ có thể là bất cứ thứ gì. Dịch vụ là một phần ảnh hưởng đến việc host có OK hay không. State của dịch vụ thường được xác định chỉ khi host trong điều kiện UP. Các trạng thái của dịch vụ là OK (ok), WARN (cảnh báo), CRIT (nghiêm trọng), UNKNOWN (không biết).

Các trạng thái dịch vụ:

![Imgur](https://i.imgur.com/nrxwwS7.png)

- OK: Dịch vụ hoàn toàn ok. Tất cả các giá trị giám sát đều nằm trong khoảng đã cho trước
- WARN: Dịch vụ hoạt động bình thường nhưng các giá trị đã nằm ngoài khoảng cho trước
- CRIT: Dịch vụ không hoạt động hoặc các giá trị nằm trong khoảng báo động
- UNKOWN: Không thể xác định được trạng thái chính xác của dịch vụ. Agent giám sát gửi dữ liệu bị khiếm khuyết hoặc thành phần được giám sát đã biến mất.
- PEND: Dịch vụ mới được thêm vào giám sát, dữ liệu chưa được cấp nhật.

Phân biệt với các trạng thái của host:

![Imgur](https://i.imgur.com/NyYPDnZ.png)

Các trạng thái của dịch vụ sắp xếp theo mức độ nghiêm trọng tăng dần:

![Imgur](https://i.imgur.com/8CjpijL.png)

Ví dụ một host có thể có các dịch vụ memory (RAM), CPU load, CPU utilization, 	Filesystem /, vân vân.

Bên trong một dịch vụ thì có nhiều Metric khác nhau. Ví dụ trong dịch vụ memory thì có RAM install, RAM used, SWAP installed, SWAP used, Free RAM, Free SWAP, vân vân.

Vd các service trong một host

![Imgur](https://i.imgur.com/O81gilX.png)

Đối với mỗi dịch vụ này, về nguyên tắc có ba khả năng:

- Undecided: Bạn chưa quyết định có giám sát dịch vụ này hay không
- Monitored: Dịch vụ đang được giám sát
- Disabled: Không giám sát dịch vụ này

Ban đầu, tất cả các dịch vụ đều là undecided. Click vào nút `Fix all missing/vanished`. 
 
Sau khi chỉnh sửa, click vào nút `Activate affected` sẽ thấy các dịch vụ được giám sát. 

Các icon quan trọng:

![Imgur](https://i.imgur.com/p8LkO8a.png)

- ![Imgur](https://i.imgur.com/HTPHABw.png) host/service đang trong trạng thái down có kế hoạch
- ![Imgur](https://i.imgur.com/FOBHeoo.png) host đang trong trạng thái down có kế hoạch
- ![Imgur](https://i.imgur.com/4rLXIhM.png) host/service không ở trong chu kỳ cảnh báo
- ![Imgur](https://i.imgur.com/tZGyk2J.png) Cảnh báo cho host/service này đang bị tắt
- ![Imgur](https://i.imgur.com/VwSysAP.png) Việc kiểm tra (check) cho host/service này đang bị tắt
- ![Imgur](https://i.imgur.com/OyXdH3H.png) host/service đang trong trạng thái stale
- ![Imgur](https://i.imgur.com/amou0PV.png) host/service đang trong trạng thái flapping
- ![Imgur](https://i.imgur.com/I4Sa0ZE.png) host/service đang có vấn đề (problem)
- ![Imgur](https://i.imgur.com/eaJSkcy.png) host/service có comment
- ![Imgur](https://i.imgur.com/a50cxMb.png) host/service này là 1 phần của thương mại thông minh (BI)
- ![Imgur](https://i.imgur.com/XW1bZkV.png) Click vào đây để vào chỉnh sửa các thông số check
- ![Imgur](https://i.imgur.com/CKlwy9i.png) Chỉ ở trong các dịch vụ logwatch: Có thể truy cập các file log được lưu ở đây
- ![Imgur](https://i.imgur.com/23ThyKl.png) Xem biểu đồ theo thời gian của dữ liệu
- ![Imgur](https://i.imgur.com/4d78oi0.png) host/service này có dữ liệu inventory. Click vào để xem
- ![Imgur](https://i.imgur.com/Rcsypjb.png) Check đã crash. Click vào để xem và gửi báo cáo crash/bug 

Ví dụ về Metric của dịch vụ `Filesystem /`

![Imgur](https://i.imgur.com/E0KaJx0.png)

Con số cần chú ý là 22.05 phần trăm đã sử dụng. Đây là tông quan. Để biết thêm chi tiết thì click vào dịch vụ

![Imgur](https://i.imgur.com/5728MwG.png)

Các biểu đồ trong phiên bản RAW edition không thể tương tác được. 

## Host và service group

Các host và service có thể được nhóm thành một group. Việc chia nhóm giúp ta dễ dàng quản lý hơn

Nên nhóm các host giống nhau vào một group. Ví dụ: các host chạy HĐH Centos 7 vào một nhóm, bên trong nhóm đó có các host chạy dịch vụ web ở trong một nhóm con, các host chạy dịch vụ mail vào một nhóm con.

Tương tự, nên nhóm các dịch vụ liên quan đến nhau vào một nhóm. Ví dụ có thể nhóm các dịch vụ như httpd, mysql, php vào nhóm LAMP.

Việc nhóm như thế nào là tùy vào người quản trị

# Contact và contact group

User cmkadmin có toàn quyền xem tất cả host, service (vì là role admin).

Có thể tạo các user khác nhau và thêm các user này vào các nhóm khác nhau tùy theo nhiệm vụ của họ. 

Ví dụ: User Giamdoc có quyền xem tất cả các host và service, có quyền cấu hình tất cả các host và service, được nhận toàn bộ cảnh báo. User Nhanvien1 chỉ có quyền xem các host chạy HĐH Centos và Ubuntu thôi, và chỉ được cấu hình các dịch vụ httpd, mysql. Chỉ nhận được cảnh báo liên quan đến các host chạy Centos.

## User và role

![Imgur](https://i.imgur.com/fzVK9UZ.png)

3 loại user: 

- Admin: Có tất cả các quyền
- User: Xem những thứ trong phạm vi quyền. Quản lý các host trong thư mục đã được giao cho. Không được phép sửa global settings.
- Guest: Có thể xem được tất cả. Nhưng không được cấu hình và ảnh hưởng đến việc giám sát.

# Handled and unhandled problems

Checkmk định nghĩa tất cả các host không UP và tất cả các service không OK là một Problem. Một problem có 2 trạng thái là handled và unhandled. Mặc đinh ban đầu trạng thái sẽ luôn là unhandled, khi có người acknowledge sẽ trở thành trạng thái handled. Các problem unhandled tức là vấn đề này không có ai xử lý

![Imgur](https://i.imgur.com/nZCUqn4.png)

# Cảnh báo

Khi trạng thái một host thay đổi thì sẽ xuất hiện event. Các event này có thể có cảnh báo hoặc không tùy vào cấu hình. 

Phần này đọc thêm ở đây: https://checkmk.com/cms_notifications.html

Chú ý chọn đúng user hoặc user group cần nhận cảnh báo. Chọn đúng service, service group. Chọn host event và service event cần thiết để gửi cảnh báo. (Hoàn toàn tùy thuộc vào cấu hình của người quản trị)

Các bài về cảnh báo:

https://github.com/lukabobo/thuctapsinh/blob/master/DungDB/linux/monitor/checkmk/18_email_notify.md

https://github.com/lukabobo/thuctapsinh/blob/master/DungDB/linux/monitor/checkmk/06_telegram_noti.md

https://github.com/lukabobo/thuctapsinh/blob/master/DungDB/linux/monitor/checkmk/23_dat_nguong_canh_bao_va_kiem_tra.md

## Flapping hosts and services

Khi host hoặc service thay đổi trạng thái liên tục, nó sẽ bị đưa vào trạng thái Flapping. Sau một khoảng thời gian và trạng thái đã ổn định thì host hoặc service đó sẽ trở lại bình thường.

## Scheduled downtimes

Các những trường hợp ta có kế hoạch tắt host/service nhưng không muốn nhận cảnh báo. Ta có thể đưa host/service đó vào trạng thái Scheduled downtimes. Khi host/service down sẽ không có cảnh báo nào gửi.

![Imgur](https://i.imgur.com/Wq22c4u.png)

- Icon màu cam: host/service đang down theo kế hoạch có trước
- Icon màu xanh: host đang có kế hoạch down

## Timeperiods

Một số tình huống quan trọng sử dụng khoảng thời gian (Timeperiods) là:

- Giới hạn thời gian gửi thông báo (notification period)
- Giới hạn thời gian kiểm tra (check) host/service (check period)
- Thời gian đánh giá tính khả dụng (service period)
- Thời gian event console áp dụng rule

## Check interval, check attempts and check period

Việc thực hiện kiểm tra sẽ theo khoảng thời gian cố định. Mặc định là 1 phút. Giá trị thời gian có thể thay đổi được. Thời gian dài thì tiết kiệm được CPU, thời gian ngắn thì thu thập dữ liệu nhiều và rõ ràng hơn.

Khi quy định check period khác với 24X7, việc thực hiện các active check có thể bị gián đoạn. Trạng thái dịch vụ sẽ không được update nữa và dịch vụ sẽ bị đánh dấu trạng thái **stale**

## Active and passive Checks

Khi click vào menu của dịch vụ mà xuất hiện icon ![Imgur](https://i.imgur.com/3tYScom.png) thì có nghĩa là active check. Việc check service này là do checkmk chủ động thực hiện. 

Nếu thấy icon ![Imgur](https://i.imgur.com/pUmidxQ.png) thì có nghĩa đây là passive check. Dữ liệu do agent trả về.

# Tips and tricks

## CPU single-core utilization

Giám sát toàn bộ lượng sử dụng CPU là rất tốt nhưng không thể phát hiện ra toàn bộ vấn đề gặp phải. Ví dụ như 1 trong 16 CPU hoạt động liên tục trong thời gian dài.

Để giải quyết vấn đề này, checkmk cung cấp khả năng giám sát từng CPU. `Levels over extended periods on a single core CPU utilization`

![Imgur](https://i.imgur.com/gWvbtKF.png)

## Giám sát các dịch vụ trên Windows

Checkmk không tự động giám sát các dịch vụ trên Windows vì nó không biết dịch vụ nào cần thiết để giám sát. Nếu bạn không muốn tốn công đặt nhiều rule cho nhiều dịch vụ thì bạn chỉ cần check xem tất cả các dịch vụ có khởi động cùng hệ thống hay không. Để làm được bạn cần set rule giám sát trong phần Service states. 

![Imgur](https://i.imgur.com/VOzxYc1.png)

- Dịch vụ nào khởi động cùng hệ thống mà đang chạy thì OK
- Dịch vụ nào khởi động cùng hệ thống mà đang tắt thì CRIT
- Dịch vụ nào có yêu cầu khởi động cùng hệ thống mà đang chạy WARN

Nhưng rule này chỉ áp dụng với các dịch vụ đã được giám sát. Vì thế chúng ta cần tạo rule mới trong Windows Service Discovery. Chỗ này checkmk sẽ tự động đề nghị xem dịch vụ nào cần được giám sát.

Để đặt rule chỗ này đầu tiên ta đặt dấu `.*` tại phần Services (Regular Expressions). Tất cả các dịch vụ sẽ xuất hiện. Xem xét các dịch vụ cần được giám sát và quya trở lại phần rule và lọc theo ý muốn. Ví dụ như trong hình dưới:

![Imgur](https://i.imgur.com/m9u4mRP.png)

Sau đó ta click nút Automatic refresh để làm mới danh sách dịch vụ được giám sát.

## Giám sát host thường có trạng thái là DOWN

Khi máy cần giám sát là máy in, chúng thường có trạng thái down. Ta tạo một rule như sau:

![Imgur](https://i.imgur.com/3NxNWfr.png)

![Imgur](https://i.imgur.com/WpZCOSM.png)

Nếu host down checkmk vẫn xem đó là trạng thái bình thường.

Để tránh cảnh báo khi timeout, ta thêm rule vào `Status of the Check_MK services`

![Imgur](https://i.imgur.com/htPRZlu.png)

Chọn `State in case of connection problems` và `State in case of a timeout` là OK

## Tắt cảnh báo cho host flapping

Khi có một host rơi vào trạng thái flapping mà ta không muốn nhận cảnh báo. Có thể bật/tắt rule ở đây

![Imgur](https://i.imgur.com/YHZWLoL.png)

## Đặt ngưỡng cảnh báo sử dụng disk

Ngưỡng cảnh báo mặc định là 80% sẽ warning. Nhưng đối với các server có ổ cứng lớn, ví dụ như 2T, sử dụng hết 80% thì vẫn còn 400GB. Như thế vẫn là rất nhiều để cảnh báo.

Tại `Filesystems (used space and growth)` apply 1 rule. Ngưỡng mặc định. Ta bật `Magic factor (automatic level adaptation for large filesystem)`, và thêm vào số 0.8. Bật `Reference size for magic factor` và nhập 100GB

![Imgur](https://i.imgur.com/kDFukSt.png)

Bây giờ máy có ổ cứng bằng 100GB sẽ có ngưỡng mặc định

Máy có ổ lớn hơn 100GB sẽ có ngưỡng cao hơn

Máy có ổ nhỏ hơn 100GB sẽ có ngưỡng thấp hơn

![Imgur](https://i.imgur.com/pio5Fd3.png)

## Đọc thêm

https://checkmk.com/cms_monitoring_basics.html

https://checkmk.com/cms_wato_services.html#checkplugins