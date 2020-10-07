# Tổng quan về kiến trúc posfix
# Mục Lục

`Postfix` là chương trình mã nguồn mở và miễn phí (free and open-source) dùng để gửi thư điện tử (Mail Transfer Agent – MTA) được tạo ra ban đầu tại IBM với mục tiêu là thay thế chương trình gửi mail phổ biến là Sendmail Postfix được phát triển dựa trên mục tiêu là nhanh, dễ quản lý và bảo mật.

## 1. Cách Postfix nhận thư


- Khi một thư vào hệ thống thư Postfix, điểm dừng đầu tiên ở bên trong là hàng đợi đến . Hình bên dưới cho thấy các quy trình chính liên quan đến thư mới. Các tên được theo sau bởi một số là lệnh Postfix hoặc chương trình máy chủ, trong khi các tên không được đánh số bên trong vùng bóng mờ đại diện cho hàng đợi Postfix.

<img src="https://image.prntscr.com/image/U1GPyW7KRqWezypsbeI9dg.png">


- Thư được đăng tại địa phương. Các Postfix sendmail tiền gửi chương trình được thông báo vào thế giới-ghi maildrop thư mục, nơi mà các thông điệp được chọn của các xe bán tải daemon. Daemon này thực hiện một số kiểm tra sự tỉnh táo, để bảo vệ phần còn lại của hệ thống Postfix. Để tránh tai nạn, quyền của thư mục trên thư mục maildrop phải sao cho người dùng không thể xóa thư của ai đó.
- Thư đến qua mạng. Máy chủ Postfix SMTP nhận thông báo và thực hiện một số kiểm tra tỉnh táo, để bảo vệ phần còn lại của hệ thống Postfix. Máy chủ SMTP có thể được định cấu hình để triển khai các điều khiển UCE trên cơ sở danh sách đen cục bộ hoặc dựa trên mạng, tra cứu DNS và thông tin yêu cầu máy khách khác.
Thư được tạo nội bộ bởi chính hệ thống Postfix, để trả lại thư không gửi được cho người gửi. Các thư bị trả lại hoặc hoãn lại daemon mang lại những tin tức xấu.
Thư được chuyển tiếp bởi đại lý phân phối cục bộ , thông qua một mục nhập trong cơ sở dữ liệu bí danh trên toàn hệ thống hoặc thông qua một mục nhập trong một tệp. Forward cho mỗi người dùng . Điều này được chỉ ra bằng mũi tên không gắn nhãn.
- Thư được tạo nội bộ bởi chính hệ thống Postfix, để thông báo cho người quản lý bưu điện về sự cố (đường dẫn này cũng được chỉ ra bằng mũi tên không được gắn nhãn). Hệ thống Postfix có thể được định cấu hình để thông báo cho người quản lý bưu điện về các sự cố giao thức SMTP, vi phạm chính sách UCE, v.v.
Các dọn dẹp daemon cụ giai đoạn xử lý cuối cùng cho thư mới. Nó bổ sung các tiêu đề thư bị thiếu : và các tiêu đề thư khác, sắp xếp cho việc ghi lại địa chỉ vào biểu mẫu user@ly.qu đủ tiêu chuẩn.domain và tùy chọn trích xuất địa chỉ người nhận từ tiêu đề thư. Các dọn dẹp daemon chèn kết quả như một tập tin đơn hàng đợi vào đến hàng đợi, và thông báo cho người quản lý hàng đợi sự xuất hiện của thư mới. Các dọn dẹp daemon có thể được cấu hình để chuyển đổi địa chỉ trên cơ sở kinh điển và ảo tra cứu bảng.
- Theo yêu cầu của daemon dọn dẹp , trình nền viết lại tầm thường sẽ ghi lại các địa chỉ thành dạng user@ly.qu đủ tiêu chuẩn.domain tiêu chuẩn . Phiên bản Postfix ban đầu không triển khai ngôn ngữ viết lại. Việc thực hiện một cái sẽ tốn rất nhiều công sức và hầu hết các trang web không cần nó. Thay vào đó, Postfix sử dụng rộng rãi tính năng tra cứu bảng .

## 2. Cách Postfix gửi thư

<img src=".../Images\mail\postfix\uotbound.gif">


Trình quản lý hàng đợi là trái tim của hệ thống thư Postfix. Nó liên hệ với các đại lý phân phối cục bộ , smtp hoặc đường ống và gửi một yêu cầu gửi với thông tin tên đường dẫn tệp hàng đợi, địa chỉ người gửi tin nhắn, máy chủ lưu trữ nếu đích ở xa và một hoặc nhiều địa chỉ người nhận tin nhắn.
Trình quản lý hàng đợi duy trì một hàng đợi hoãn riêng biệt cho thư không thể gửi được, do đó, việc tồn đọng thư lớn sẽ không làm chậm các truy cập hàng đợi bình thường.

Trình quản lý hàng đợi duy trì một hàng đợi hoạt động nhỏ chỉ với một vài thông báo mà nó đã mở để gửi. Các hoạt động hàng đợi đóng vai trò như một cửa sổ giới hạn về khả năng lớn hơn nhiều đến hoặc hoãn lại hàng đợi. Hàng đợi hoạt động nhỏ ngăn trình quản lý hàng đợi hết bộ nhớ khi tải nặng.

Theo tùy chọn, trình quản lý hàng đợi trả lại thư cho những người nhận được liệt kê trong bảng đã di dời . Bảng này chứa thông tin liên hệ của người dùng hoặc thậm chí toàn bộ miền không còn tồn tại.

Theo yêu cầu của trình quản lý hàng đợi, trình nền viết lại tầm thường giải quyết các điểm đến. Theo mặc định, nó chỉ phân biệt giữa các điểm đến cục bộ và từ xa . Thông tin định tuyến bổ sung có thể được chỉ định bằng bảng truyền tải tùy chọn .
Theo yêu cầu của người quản lý hàng đợi, daemon bị trả lại hoặc trì hoãn tạo báo cáo không gửi được khi không thể gửi thư, do lỗi không thể khôi phục hoặc do không thể truy cập được đích trong một khoảng thời gian dài.
Các địa phương đại lý phân phối hộp thư hiểu UNIX-phong cách, sendmail kiểu system-wide bí danh cơ sở dữ liệu, và sendmail kiểu cho mỗi người dùng .forward tập tin. Nhiều đại lý phân phối địa phương có thể được chạy song song, nhưng việc phân phối song song cho cùng một người dùng thường bị hạn chế.
Cùng với đại lý đăng thư sendmail , đại lý chuyển phát địa phương triển khai giao diện người dùng Sendmail quen thuộc.

Các địa phương đại lý phân phối có móc cho các hình thức khác để giao hàng địa phương: bạn có thể cấu hình nó để cung cấp cho các tập tin hộp thư trong thư mục nhà của người dùng, và thậm chí bạn có thể cấu hình nó để ủy thác giao hộp thư đến một lệnh bên ngoài như phổ biến procmail chương trình.

Máy khách SMTP tra cứu danh sách các bộ trao đổi thư cho máy chủ đích, sắp xếp danh sách theo tùy chọn và thử lần lượt từng địa chỉ cho đến khi tìm thấy máy chủ phản hồi. Trên một hệ thống Postfix bận rộn, bạn sẽ thấy một số tiến trình khách SMTP chạy song song.
Hộp thư đường ống là giao diện gửi đi cho các phương tiện vận chuyển thư khác ( chương trình sendmail là giao diện gửi đến). Hệ thống thư Postfix đi kèm với các ví dụ để gửi qua giao thức UUCP . Tại thời điểm viết bài, giao thức đáng kính này vẫn được sử dụng rộng rãi. Theo mặc định, Postfix hiểu các địa chỉ kiểu đường dẫn bang .