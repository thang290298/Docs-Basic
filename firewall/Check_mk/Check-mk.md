# Tổng quan và sử dụng Check MK
## I. OMD (Open Monitoring Distribution)
### 1. Tổng quát

- Phân phối giám sát mở (OMD) là một gói đóng kín bao gồm Nagios cùng với các tiện ích bổ sung cho việc thu thập, giám sát và vẽ dữ liệu đồ thị. Nó đi kèm với Check_MK multisite , một công cụ toàn diện giải quyết nhiều thiếu sót của Nagios . Nó cung cấp một giao diện web để dễ dàng quản trị và cấu hình, một bảng điều khiển thân thiện với người dùng, một hệ thống thông báo mạnh mẽ và các agent giám sát dễ cài đặt cho nhiều bản phân phối Linux. Nếu không có Check_MK multisite, chúng ta sẽ phải sử dụng các view khác nhau cho các nhiệm vụ khác nhau và sẽ không thể cấu hình tất cả các thiết lập mà không cần phải làm việc với các tệp cấu hình.
- Phân phối giám sát mở (OMD) là một gói đóng kín bao gồm Nagios cùng với các tiện ích bổ sung cho việc thu thập, giám sát và vẽ dữ liệu đồ thị. Nó đi kèm với Check_MK multisite , một công cụ toàn diện giải quyết nhiều thiếu sót của Nagios . Nó cung cấp một giao diện web để dễ dàng quản trị và cấu hình, một bảng điều khiển thân thiện với người dùng, một hệ thống thông báo mạnh mẽ và các agent giám sát dễ cài đặt cho nhiều bản phân phối Linux. Nếu không có Check_MK multisite, chúng ta sẽ phải sử dụng các view khác nhau cho các nhiệm vụ khác nhau và sẽ không thể cấu hình tất cả các thiết lập mà không cần phải làm việc với các tệp cấu hình.
- OMD là sự kết hợp của các phương pháp hay nhất về cách Nagios được thiết lập và tích hợp. Nó đã kết hợp tất cả các plug-in Nagios thế hệ 3 phổ biến nhất vào trong một gói đơn giản dễ duy trì, dễ cài đặt và dễ nâng cấp. Một khi bạn đã chạy máy chủ Linux, cài đặt và chạy bộ giám sát OMD chỉ mất khoảng 10 phút với một lệnh. Quản trị viên thực sự có thể tiết kiệm thời gian, không cần phải biên dịch như cài đặt Nagios. Hoặc mất thời gian tích hợp các plug-in vào cấu hình như Nagios

<img src="https://image.prntscr.com/image/bNzTIQSMSuKuSW19ahh1sw.png">

- OMD - Open Monitoring Distribution là một project được phát triển từ năm 2010 bới Mathias Kettner. OMD sử dụng nhân là Nagios Core, kết hợp với các phần mềm mã nguồn mở khác để đóng gói thành một sản phẩm phục vụ cho nhu cầu giám sát, cảnh báo và hiển thị
### 2. Các bản phân phối
- Năm 2015 phiên bản đơn giản của OMD đã được ra mắt gọi là `CHECK_MK` vào lúc đó có 2 phiên bản của là: `CHECK_MK RAW EDITION(CRE)` và `CHECK_MK ENTERPRISE EDITION(CEE)`. Hiện nay có thêm một phiên bản mới phiên bản này dựa trên phiên bản CEE được gọi là `Checkmk Managed Services Edition`

<img src="https://image.prntscr.com/image/bNzTIQSMSuKuSW19ahh1sw.png">

### 2. Phân biệt OMD-LABS và OMD(check_mk)
#### OMD-LABS
- OMD Labs-Edition là một nền tảng giám sát và một khái niệm mới về cài đặt, duy trì và cập nhật một hệ thống giám sát được xây dựng trên Nagios. Không được tích hợp sẵn trong các bản phân phối Linux mà tích hợp vào hệ thống dưới dạng các Package rpm và deb.
- Phiên bản stable là 2.40, thường thì 6 tháng sẽ có một phiên bản stable được phát hành. Tính từ thời điểm hiện tại thì đến tháng 11 năm 2017, một phiên bản stable mới sẽ được phát hành.
- OMD-Labs chứa nhiều thành phần phần mềm mới so với gói OMD thường (Check_MK). Một số cài đặt mặc định đã thay đổi
-  Một số điểm khác của OMD-LABS với OMD thường (Check_MK)
  - Các thành phần phần mềm bổ sung: OMD-Labs chỉ bổ sung các thành phần phần mềm mới và không loại bỏ bất kì phần mềm nào, làm cho OMD-Labs trở nên hoàn hảo hơn, và có thể chuyển sang các phiên bản khác bằng omd update
  - Lõi giám sát mới: Bên cạnh Nagios 3, OMD-Labs còn chứa hai Cores mới là Naemon và Icinga2. Trong khi Naemon hoàn toàn tương thích với định dạng Nagios 3 config thì Icinga2 sử dụng định dạng cấu hình mới.
  - Biểu đồ Grafana/Influxdb: Bên cạnh PNP4Nagios OMD có đồ thị Grafana dựa trên Influxdb. Để tạo mẫu đồ thị dựa trên mẫu, đã có histou (Histou được thiết kế để thêm các mẫu vào Grafana từ dữ liệu của Nagios). Giao diện giữa core giám sát và Influxdb được thực hiện trong thành phần Nagflux.
  - Hệ thống con Prometheus: Bên cạnh việc giám sát truyền thống, OMD-Labs đi kèm với prometheus bao gồm quản lý cảnh báo, pushgateway và blackbox exporter.
  - Livestatus Multitool Daemon
#### Check_MK
- Check_MK là một phần của OMD, hiện tại đang có 2 phiên bản Check_MK là Check_MK Raw Edition (CRE) và Check_MK Enterprise Edition (CEE)

#### So sánh OMD-LABS và OMD(check_mk)

<img src="https://image.prntscr.com/image/bNzTIQSMSuKuSW19ahh1sw.png">

## II. Check_mk
### 1. Tổng quan
- Check_MK được phát triển bởi Mathias Kettner, phát hành lần đầu năm 2008. Check_MK là sự kết hợp của Nagios, Check_MK, NagVis, PNP4Nagios, DocuWiki, ...tạo nên sự linh hoạt trong giám sát
- Check_MK là một hệ thống Giám sát CNTT. Nó bắt đầu ban đầu như là một phần mở rộng cho hệ thống giám sát Nagios cho phép tạo cấu hình dựa trên quy tắc bằng cách sử dụng Python và giảm tải công việc từ lõi Nagios để làm cho nó mở rộng hơn, cho phép nhiều hệ thống được giám sát từ một máy chủ Nagios.
Nó đi kèm với một bộ kiểm tra hệ thống, một mod_python và JavaScript dựa trên giao diện người dùng web , và một mô-đun cho phép truy cập nhanh vào lõi Nagios.
- Check_MK là một mã nguồn mở, đa nền và ứng dụng web dựa trên phân phối miễn phí được thiết kế từ những bù đắp để cung cấp cho người dùng với một cách mới để thu thập dữ liệu từ các hệ điều hành hoặc các thành phần mạng. Phần mềm obsoletes các NRPE, check_by_ssh, NSClient và ứng dụng check_snmp. Nó cung cấp giảm đáng kể việc sử dụng CPU trên Nagios chủ nhà, cũng như hàng tồn kho tự động các mặt hàng được kiểm tra trên máy chủ.
- Ứng dụng bao gồm ba công cụ tuyệt vời, nhiều trang, một trạng thái tính năng giao diện đầy đủ (Graphical User Interface) cho Nagios, dựa trên Livestatus; MK Livestatus, một mô-đun Nagios môi giới sự kiện; và WATO, một giao diện cấu hình (Graphical User Interface) .Features tại một tính năng glanceKey bao gồm một phương pháp tuyệt đẹp và hấp dẫn cho cấu hình hệ thống giám sát Nagios bằng cách kích hoạt cấu hình máy phát điện và công nhận dịch vụ tự động thay vì sử dụng Nagios & rsquo; dữ liệu cấu hình, hỗ trợ cho các hợp đồng mỗi máy chủ một lần mỗi khoảng thời gian kiểm tra, cũng như hỗ trợ cho việc gửi kết quả kiểm tra để kiểm tra Nagios là thụ động, tiết kiệm rất nhiều tài nguyên trên cả máy khách và máy chủ hệ thống.
- Ngoài ra, Check_MK cung cấp một hệ thống thông báo linh hoạt và đơn giản mà có thể dễ dàng cấu hình. Hệ thống thông báo hỗ trợ xác định và cấu hình của nhiều kênh cho người dùng khác nhau, nhưng người dùng cũng có thể cấu hình các hệ thống thông báo themselves.Supports devicesAnother di động tính năng thú vị là khả năng sử dụng các ứng dụng trực tiếp từ một thiết bị di động, chẳng hạn như điện thoại thông minh hoặc máy tính bảng. Nó cho phép người dùng thiết bị di động để dễ dàng truy cập dữ liệu trạng thái, cũng như để thực hiện & ldquo; Set cho ngưng hoạt động & rdquo; và & ldquo; Ghi nhận & rdquo; lệnh. Tất cả các thiết bị di động sẽ được tự động nhận
### 2. Thành phần
Check_MK bao gồm kết hợp nhiều thành phần:
  - Sử dụng multiple "passive" checks thông qua single "active" check (kiểm tra thụ động chỉ được xử lý, nhưng không được thực hiện bởi Nagios, nhanh hơn đáng kể).
  - Mô-đun để thống nhất việc xử lý cấu hình và kết nối với các hệ thống được giám sát. Điều này làm cho việc truy cập TCP hoặc SNMP trở nên trong suốt đối với người dùng và tác giả của các plugin kiểm tra.
  - Xử lý cấu hình cho PNP4Nagios, một công cụ vẽ đồ thị cho Nagios và các hệ thống tương thích.
  - Một agent cho hệ điều hành máy chủ . Agent tương đối nhỏ chỉ chạy các lệnh để thu thập dữ liệu cần thiết để chạy kiểm tra nhưng tránh xử lý cục bộ. Theo thiết kế, nó cũng không được phép chấp nhận bất kỳ đầu vào bên ngoài nào. Có các agent cho các hệ điều hành khác nhau như Linux, Unix, Windows và OpenVMS. Các agent được thực hiện để người dùng có thể sửa đổi và / hoặc mở rộng.
  - Kiểm tra bao gồm các phần phía máy chủ và phía máy chủ. Check_MK cung cấp cho họ một khuôn khổ để xử lý các kết nối, nói chuyện với Nagios và xử lý các lỗi nội bộ. Có những tiêu chuẩn thiết kế khá nghiêm ngặt để viết kiểm tra được cho là mang lại sự phù hợp hơn cho các plugin so với các plugin Nagios tiêu chuẩn. Các kiểm tra xử lý việc phát hiện các thiết bị được hỗ trợ và sau đó được tự động gọi để kiểm tra trạng thái chờ của một thành phần đã được tìm thấy trước đó. Hiện tại có khoảng 640 plugin trong bản phân phối chính thức, cộng với 100 phần bổ sung về trao đổi cộng đồng. Bạn có thể tìm thấy số lượng séc lớn hơn tại Github.
  - Livestatus là một mô-đun xử lý truy cập trực tiếp vào lõi của Nagios để cho phép. Nó có thể được truy vấn bằng cách sử dụng một ngôn ngữ truy vấn và được sử dụng như một phụ trợ. Nagios addons sử dụng livestatus để truy cập dữ liệu Nagios bao gồm JasperReports , NagiosBP, Thruk, NagstaMon, NagVis và Multisite.
  - Multisite là một thành phần GUI có thể chạy song song hoặc thay vì GUI Nagios chuẩn. Nó sử dụng Livestatus để truy cập trực tiếp một hoặc nhiều máy chủ Nagios và có thể xây dựng các báo cáo từ các dữ liệu có sẵn. Ngoài ra còn có các plugin cho Multisite:
  ```
    +Check_MK BI - công cụ phân tích tác vụ / quy trình nghiệp vụ (dựa trên quy tắc, nếu bạn xác định quy tắc cho "tất cả máy chủ" và bạn thêm máy chủ mới, quy tắc cũng áp dụng ngay cho máy chủ đó).
  
  +WATO - giao diện quản trị web cho cấu hình check_mk (và nagios) (dựa trên quy tắc)
  
  +Event Console - giao diện xử lý sự kiện dựa trên quy tắc để xử lý dữ liệu tức là đến từ SNMP Traps hoặc Syslog. 
  ```
  - Check_MK là phần mở rộng của hệ thống giám sát Nagios cho phép tạo cấu hình dựa trên quy tắc bằng Python và giảm tải công việc từ Nagios Core để làm cho nó được mở rộng hơn, cho phép nhiều hệ thống được giám sát từ một máy chủ Nagios.
  - Có 2 mô đun mà Check_MK sử dụng để cải thiện đáng kể hiệu suất Nagios là Livestatus và Livecheck
  ### 3. Phiên bản
Check_MK có sẵn để tải về trong các phiên bản khác nhau :

  - Phiên bản Check_MK Raw Edition (CRE) miễn phí - một hệ thống giám sát CNTT hoàn toàn có thể sử dụng được, ngay lập tức có thể tải xuống và nguồn mở 100%
  - Phiên bản mở rộng Check_MK Enterprise Edition (CEE) - để sử dụng trong môi trường chuyên nghiệp với nhiều chức năng bổ sung và hiệu suất cao hơn
  - Check_mk Managed Services Edition (CME) - cho các nhà cung cấp dịch vụ quản lý

Đối với CEE và CME phải đăng ký để tải.
#### Check_MK Raw Edition (CRE)
Check_MK Raw Edition là một giải pháp giám sát toàn diện. Có thể sử dụng CRE miễn phí, chỉ cần tuân thủ theo một số giấy phép của GNU GPL và giấy phép của nguồn mở. Phiên bản stable đang là 1.2.8p22, phiên bản beta là 1.4.0b8

Phiên bản | Bản mới nhất

1.6.0 (stable) | 1.6.0p17 (CRE)

## III, Sự hoạt động trong kiến trúc của OMD

- OMD được xây dựng từ những đóng góp của cộng đồng về những khó khăn hay khuyết điểm mà Nagios gặp phải, từ đó đưa ra quyết định cần tích hợp thêm những sản phẩm gì để cải thiện. Việc cài đặt trở nên vô cùng đơng giản. OMD được đóng gói hoàn chỉnh trong một package, việc cài đặt và cấu hình chỉ mất khoảng 10 phút với chỉ một vài câu lệnh
<img src="https://image.prntscr.com/image/bNzTIQSMSuKuSW19ahh1sw.png">

- Check_MK ra đời để giải quyết bài toán về hiệu năng mà Nagios gặp phải trong quá khứ.Cơ chế mới của Check_MK cho phép việc mở rộng hệ thống trở nên dễ dàng hơn, có thể giám sát nhiều hệ thống chỉ từ một máy chủ Nagios server.
- Multisite là một phần của dự án Check_MK như là một giao diện web cho người dùng tốt hơn để thay thế cho Nagios. Một GUI mới và sáng tạo để xem thông tin trạng thái Nagios và kiểm soát hệ thống giám sát. Nó dựa trên MK Livestatus và nhằm mục đích thay thế cho GUI web Nagios. Multisite hỗ trợ giám sát phân tán bằng một cách hiệu quả nhất.
- Với Nagios, mỗi khi cấu hình một host mới, hay cấu hình một cảnh báo…bạn phải mất ít nhất 15p cho việc tạo, sửa đổi file cấu hình, dùng câu lệnh để restart service…chưa kể thời gian tìm lỗi nếu cấu hình sai. Với WATO, tất cả các thao tác đó có thể thực hiện trong vòng 3p trên giao diện WEB.

#### Hoạt động cơ bản
Nhìn vào hình ảnh trên ta có thể hình dùng cơ bản các thành phần hoạt động trong kiến trúc của OMD:
- Trung tâm của nó là Monitoring core (Nagios/Icinga) được kết nối với 2 module chính 1 để check thông tin, lấy thông tin về host giám sát (Live check), 1 để hiển thị thông tin lên một cái gì đó để hiển thị các metric lên.
  - Livecheck gồm thành phần check_mk thực hiện check quan giao thức TCP, SSH (đối với các device chạy OS Windows, Linux...), hoặc SNMP (đối với các thiết bị network như Switch, router...).
  - Livecheck có thể sử dụng kiểm tra host bằng cách sử dụng ICMP trực tiếp tới host, hay sử dụng Nagios_Plugin để check thông giao giao thức TCP/IP.
  - Phần hiển thị dashboard dựa trên module Livestatus.
  - Module Livestatus sử dụng Multisite hỗ trợ giám sát phân tán bằng một cách hiệu quả nhất hiển thị data lên GUI, mobile hay một app tùy chỉnh.
  - Các event_log cũng được Event Deamon để hiển thị một số loại log.
  
  Có 2 mô đun mà Check_MK sử dụng để cải thiện đáng kể hiệu năng là Livestatus và Livecheck
### 3.1 Live Status
Trước khi có Livestatus:
  - Kết quả giám sát được sẽ lưu trong file status.dat gây nên hiện tượng nút thắt cổ chai cho CPU và Disk I/O
  - Trạng thái của file status không phải là real-time mà update ít nhất là mỗi 10s
  - NDOUtils sử dụng database để theo dõi kết quả (MySQL hoặc PostgreSQL), nhưng vẫn còn một số thiếu sót quan trọng.
  - Việc cài đặt NDOUtils khá phức tạp
  - NDOUtils cần một database cho việc lưu trữ dữ liệu. Hơn nữa, việc dữ liệu lưu trong database này tăng lên một cách nhanh chóng khiến cho bạn phải tiêu tốn nhiều CPU chỉ để cập nhập database.
  - Một số dự án tương tự vẫn sử dụng NDOUtils: Centreon và Opsview
  - Việc dọn dẹp database có thể khiến Nagios bị treo trong một khoảng thời gian nhất định
Sau khi có Livestatus
  - Livestatus cũng sử dụng Nagios Event Broker API như NDO, nhưng nó sẽ không chủ động ghi dữ liệu ra. Thay vào đó, nó sẽ mở ra một socket để dữ liệu có thể được lấy ra theo yêu cầu
  - Livestatus tiêu tốn ít CPU
  - Livestatus không làm cho Disk I/O thay đổi khi truy vấn trạng thái dữ liệu
  - Không cần cấu hình. Không cần cơ sở dữ liệu. Không cần quản lý
  - Livestatus có quy mô lớn với hơn 50.000 dịch vụ.
### 3.2 Livecheck
- Trong Nagios 4.0 ngay cả một hệ thống hoàn hảo hiếm khi quản lý để thực hiện hơn một vài nghìn lần kiểm tra mỗi phút. Trong khi hệ thống càng lớn, tỷ lệ check tối đa sẽ trở nên rất tệ. Càng nhiều máy chủ và dịch vụ thì đồng nghĩa với việc khoảng thời gian check cần phải tăng lên.
- Mỗi lần check tạo ra một bản fork. Quá trình fork rất tốn kém ngay cả khi kernel được tối ưu hóa
- Quá trình fork trong Nagios Core (trước phiên bản Nagios 4.0) không phân tán ra nhiều CPU mà thực hiện trên chỉ một CPU đơn. Điều này dẫn tới việc giới hạn số lần check mỗi giây, trong khi phần lớn các CPU khác rảnh rỗi.
Livecheck khắc phực nhược điểm:
  - Livecheck sử dụng các helper process, các core giao tiếp với helper thông qua Unix socket (điều này không xảy ra trên file system)
  - Chỉ có một một helper program được fork thay vì toàn bộ Nagios Core.
  - Các tiến trình fork được phân tán trên tất cả các CPU thay vì chỉ một như trước
  - Process VM size tổng chỉ khoảng 100KB
  - Việc thực hiện check_icmp sẽ cho một con số cải tiến cụ thể. Giả sử nếu sử dụng CPU dual core 2800 MHz CPU: Trước đây sẽ là 300 ICMP check/second, sau khi cải tiến là 2600 ICMP check/second.