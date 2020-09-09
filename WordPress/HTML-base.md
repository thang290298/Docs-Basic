# Các http code cơ bản

- Dòng trạng thái HTTP là thuật ngữ được cấp cho mã trạng thái HTTP (mã số thực) khi đi kèm với “HTTP reason phrase” - cụm từ chỉ lý do (mô tả ngắn).

- Lưu ý: Mặc dù không chính xác về mặt kỹ thuật nhưng các dòng trạng thái HTTP thường được gọi là các mã trạng thái HTTP (HTTP Status Code ).

## Danh mục mã trạng thái HTTP

    Như bạn có thể thấy bên dưới, mã trạng thái HTTP là các số nguyên có ba chữ số. Chữ số đầu tiên được sử dụng để xác định mã trong một danh mục cụ thể nằm trong năm danh mục sau:

    - 1XX - Thông tin: Yêu cầu được chấp nhận hoặc quá trình tiếp tục.

    - 2XX - Thành công: Xác nhận rằng hành động đã hoàn tất thành công hoặc đã được hiểu.

    - 3XX - Chuyển hướng: Client phải thực hiện hành động bổ sung để hoàn thành yêu cầu.

    - 4XX - Lỗi từ client chỉ ra rằng yêu cầu không thể hoàn thành hoặc chứa cú pháp sai. Mã lỗi 4xx sẽ hiện ra khi có lỗi từ phía người dùng, chủ yếu là do không đưa ra một yêu cầu hợp lệ.

    - 5XX - Lỗi từ phía máy chủ: Cho biết máy chủ không thể hoàn tất yêu cầu được cho là hợp lệ. Khi duyệt web và bắt gặp các lỗi 5xx, bạn chỉ có thể chờ đợi, vì lúc này lỗi xuất phát từ phía máy chủ của dịch vụ web, không có cách nào can thiệp để sửa lỗi ngoài việc ngồi chờ bên máy chủ xử lý xong.

- Các ứng dụng hiểu mã trạng thái HTTP không cần phải biết tất cả các mã, nghĩa là mã không xác định cũng có cụm từ chỉ lý do không xác định. Cụm từ này không cho người dùng nhiều thông tin. Tuy nhiên, các ứng dụng HTTP này phải được hiểu là thuộc một trong các danh mục được nêu ở trên.

- Nếu phần mềm không biết mã cụ thể là gì thì ít nhất nó cũng biết mã đó thuộc nhóm nào. Ví dụ: nếu ứng dụng không nhận diện được mã trạng thái 490, nó có thể coi mã đó là 400 vì mã này nằm trong cùng một danh mục và sau đó có thể giả định rằng có điều gì đó sai với yêu cầu của khách hàng.

## Dòng trạng thái HTTP (Mã trạng thái HTTP + Cụm từ chỉ lý do)

| Mã trạng thái    | Cụm từ chỉ lý do     | Giải thích lỗi        |
|------------------|----------------------|-----------------------|
|   100 | Continue | Yêu cầu đã được hoàn thành và phần còn lại của tiến trình có thể tiếp tục |
| 101|Switching Protocols|Khi yêu cầu một trang, trình duyệt có thể nhận được mã trạng thái 101, theo sau là header "Upgrade", cho thấy máy chủ đang thay đổi sang phiên bản HTTP khác.|
|102|Processing||
| 200|OK|Phản hồi tiêu chuẩn cho các yêu cầu HTTP thành công.|
|201|Created|Khi các trang mới được tạo bởi dữ liệu biểu mẫu đã đăng hoặc bởi tiến trình CGI, đây là dấu hiệu xác nhận rằng trang đó đã hoạt động|
|202|Accepted|Yêu cầu của client đã được chấp nhận, nhưng chưa được xử lý.|
|203|Non-Authoritative Information|Thông tin chứa trong tiêu đề thực thể không phải từ trang web gốc, mà là từ máy chủ của bên thứ ba.|
|204|No Content|Nếu nhấp vào một liên kết không có URL mục tiêu, phản hồi này được máy chủ suy ra và không cảnh báo người dùng về bất cứ điều gì.|
|205|Partial Content|Các file được yêu cầu không được tải xuống hoàn toàn. Ví dụ, mã trạng thái này xuất hiện khi người dùng nhấn nút dừng trước khi trang được load.|
|300|Multiple Choices|Nếu máy chủ được thiết lập đúng cách, nó sẽ tự động chuyển hướng người đọc đến vị trí mới của file.|
|302|Found|Trang đã được di chuyển tạm thời và URL mới có sẵn. Bạn sẽ được máy chủ điều hướng đến đó.|
|303|See Other|Nếu header yêu cầu bao gồm tham số 'if modified since', mã trạng thái này sẽ được trả về, trong trường hợp file không thay đổi kể từ ngày đó.|
|305|Use Proxy|Người nhận dự kiến sẽ lặp lại yêu cầu thông qua proxy.|
|400|Bad Request|Có một lỗi cú pháp trong yêu cầu và yêu cầu bị từ chối.|
|403|Forbidden|Client không được phép xem một file nhất định. Mã trạng thái này cũng được trả lại vào những thời điểm mà máy chủ không muốn có thêm khách truy cập.|
|404|Not Found|Các file được yêu cầu không có trên máy chủ. Có thể bởi vì những file này đã bị xóa, hoặc chưa từng tồn tại trước đây. Nguyên nhân thường là do lỗi chính tả trong URL.|
|408|Request Time-out|Máy chủ mất quá nhiều thời gian để xử lý yêu cầu. Lỗi này thường gây ra bởi lưu lượng truy cập mạng cao.|
|501|Not Implemented|Yêu cầu không thể được máy chủ thực hiện.|
|502|Bad Gateway|Máy chủ cố truy cập đang gửi lại lỗi.|
|503|Service Unavailable|Service hoặc file đang được yêu cầu hiện không có sẵn.|
|505|HTTP Version Not Supported|Giao thức HTTP yêu cầu không được hỗ trợ.|