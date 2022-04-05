<h1 align="center">Ghi chép tìm hiều về Content Delivery Network (CDN)</h1>

# Phần I. CDN là gì?

- Content Delivery Network (CDN) là một nhóm máy chủ được đặt ở nhiều vị trí địa lý khác nhau nhắm mục địch hỗ trợ nhau về mặt nội dung và tăng tốc độ phản hồi dữ liệu đến người dùng khi truy cập dữ liệu và hệ thống CDN

- CDN cũng được gọi là `distribution networks`.  Ý tưởng là tạo được nhiều điểm truy cập (Point of Presence – PoPs) ngoài server gốc. Việc này giúp website quản lý tốt traffic hơn bằng cách xử lý nhanh hơn yêu cầu của khách, tăng trải nghiệm người dùng.

- Đối với các website có lượng dữ liệu và traffic truy cập lớn như Amazone và facebook. Những nhà quản lý thường đặt datacenter trên khắp thế giới và kết nối với nhau. Tạo ra các điểm truy cập có vị trí địa lý gần với người dùng nhất mà không chịu ảnh hưởng bơi website gốc được đặt ở đâu

> Content Delivery Network hỗ trợ hệ thống giảm tải băng thông tiêu thụ và giảm thời gian load trang ngoài ra đồng thời tăng khả năng xử lý nhiều request tại 1 thời điểm 

# Phần II. Nội dung
- Nội dung là những yếu tố về chữ, văn bản, hình ảnh của 1 website: 

- Có 2 loại nội dung chính:
  - Nội dung tĩnh
  - Nội dung động

- **`Nội dung tĩnh`** là nội dung ban đầu (input) cũng chính là nội dung cuối cùng người khác nhìn thấy (output). Nó không thay đổi theo thời gian bởi tác động của người dùng. Server sẽ truyền cùng 1 dữ liệu đó cho mọi người. Quy trình là người dùng yêu cầu 1 file A từ web server, server sẽ trả lại file A đó.

- **`Nội dung động`** (Dynamic content) là nội dung sẽ thay đổi dựa vào dữ liệu đầu vào. Nó được cá nhân hóa trên từng trang, tùy thuộc vào dữ liệu nhập vào của người dùng. Ví dụ của nội dung động là trang sản phẩm chứa tên sản phẩm, mô tả sản phẩm, và giá, bao gồm hình ảnh. Ví dụ khác là trang web hiển thị mà tương tác trực tiếp với người dùng để gửi tới người dùng những thông tin liên quan.

# Phần III. Cách thưc hoạt động

- CDN là một mạng lưới máy chủ được liên kết với nhau nhằm mục đích truyền tải nội dung đến khách hàng 1 cách nhanh nhất, không tốn nhiều chi phí, đáng tin cậy và có độ bảo mật cao
- Để cài thiện tốc độ và kết nối CDN đặt máy chủ tại các điểm trao đổi giữa các mạng khác nhau
- Các IXP (Internet exchange point) này là những địa điểm chính mà các nhà cung cấp Internet khác nhau kết nối để cung cấp quyền truy cập vào lưu lượng truy cập bắt nguồn từ nhiều mạng khác nhau. Bằng việc có kết nối đến những địa điểm có tốc độ và tính kết nối cao này, nhà cung cấp CDN có thể giảm chi phí và thời gian trong việc phân phối dữ liệu tốc độ cao.

<h3 align="center"><img src="https://www.hostinger.vn/huong-dan/wp-content/uploads/sites/10/2019/06/cdn-la-gi.png"></h3>
<h3 align="center"><img src="https://www.hostinger.vn/huong-dan/wp-content/uploads/sites/10/2019/06/CDN-hoat-dong-nhu-the-nao.png"></h3>

- Ngoài việc đặt máy chủ trong IXP, CDN còn thực hiện một số biện pháp tối ưu hóa việc truyền dữ liệu client/server tiêu chuẩn. CDN đặt trung tâm dữ liệu (data center) tại các vị trí chiến lược trên toàn cầu, tăng cường bảo mật và được thiết kế để có thể tiếp tục duy trì khi gặp các loại lỗi và hiện tượng tắc nghẽn Internet khác nhau.

# Phần IV. Ưu điểm

- Ưu điểm của nó sẽ phát huy tùy vào độ lớn của website, vị trí tương đối với dữ liệu gốc, và lượng traffic được tạo ra. Một công ty kinh doanh bán hàng tại chỗ, phục vụ cho những người mua gần đó sẽ không hưởng lợi gì nhiều từ CDN.
- Tuy nhiên, nếu bạn là doanh nghiệp thương mại điện tử eCommerce, đang cần tiếp cận được nhiều người hơn ở nhiều vị trí hơn. Hoặc website của bạn có rất nhiều traffic từ nhiều địa điểm khác nhau. Vậy, một CDN hiệu quả sẽ giúp bạn không phải đánh đổi lợi thế của giao diện mà trình tìm kiếm và người dùng ưa thích.

## 1. Giảm băng thông
- Vấn đề lớn nhất mà dịch vụ hosting thường đối mặt là băng thông. CDN xử lý lượng lớn băng thông bằng cách chia nhỏ các điểm truy cập ra, vì vậy chi phí chính cho băng thông đến điểm truy cập chính giảm xuống, và vì vậy giá thành sẽ giảm đi.
- Điều này làm được nhờ vào các công cụ tối ưu hệ thống như caching, đặt data vàot rong khu vực lưu trữ tạm ở các máy tính khác nhau hoặc trên các thiết bị khác nhau.

## 2. Tăng tốc độ
- Một trong các yếu tố quan trong làm tăng tốc độ load trang la `độ trễ`. Độ trẽ là khoảng thời gian giao tiếp và truyền tải dữ liệu giữa người dùng và server được tác động bởi các yếu tố:
  - Độ trễ đọc file vì blocked storage
  - Độ trễ xử l1y file từ server
  - Giao thức chuyển file, ví dụ như mạng cáo quang sẽ nhanh hơn cáp coaxial
  - Tốc độ quảng bá và tốc độ truyền dữ liệu từ một máy tới máy khác

## 3. Cải thiện bảo mật

- Khi tất cả các dữ liệu truyền được xử lý tại một máy chủ duy nhất, nó dễ bị tổn thương hơn khi gặp các kiểu tấn công như DDoS
- Chúng là kiểu tấn công truyền nhiều thông tin từ nhiều địa điểm và người dùng khác nhau vào cùng 1 thời điểm được chỉ định; hoạt động này cũng có thể được triển khai bởi bots. Mục đích là khiến server bị quá tải dẫn đến sập do có quá nhiều traffic.

## 4. Cải thiện việc phân phối nội dung

- Traffic lớn, phần cứng không ổn định có thể gây ra downtime và hầu hết các website không thể chấp nhận được việc này. Bằng cách phân tán nội dung trong hệ thống content delivery network, bạn sẽ ít phải gánh traffic hơn.

<h3 align="center"><img src="https://www.hostinger.vn/huong-dan/wp-content/uploads/sites/10/2019/06/mo-ta-cloudflare_ddos.png"></h3>

- Các loại website cần sử dụng CDN:
  - E-Commerce – Thương mại điện tử
  - Quảng cáo
  - Game online
  - Giải trí
