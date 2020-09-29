# Tổng quan về DIG
## I. Khái niệm
- Dig(Domain Information Groper) là , bạn có thể truy vấn máy chủ DNS để biết thông tin về các bản ghi DNS khác nhau, bao gồm địa chỉ máy chủ, trao đổi thư, máy chủ tên và thông tin liên quan. Ngoài ra, nó được dự định là một công cụ để chẩn đoán các vấn đề DNS. Không dừng ở đó, dig còn có thể dùng để “chọc ngoáy” tìm hiểu về thêm về cách hoạt động của DNS.

## II. Cài đặt và sử dụng DIG
### 1. Cài đặt
- thường được cài đặt sẵn trên Ubuntu hoặc Fedora. Trên Centos bạn có thể cài dig nếu chưa có bằng lệnh yum:
```
sudo yum install bind-utils -y
```
- Sau khi cài đặt xong kiểm tra phiên bản với cú pháp
```
dig -v
```
kết quả trả về:
```
[root@demo ~]# dig -v
DiG 9.11.4-P2-RedHat-9.11.4-16.P2.el7_8.6
```
### 2. cú pháp của `Dig`
```
dig [server] [name] [type]
```
Trong đó:
  - `[server]` – địa chỉ IP hoặc hostname của name server sẽ dùng để thực hiện truy vấn.
    - Nếu bạn cung cấp cho đối số server thông tin về hostname thì nó sẽ giải quyết hostname trước khi tiếp tục truy vấn name server.
    - Đây là tùy chọn nên bạn cũng có thể không khai báo ở đây, trong trường hợp không khai báo thì dig sẽ lấy thông tin này trong file /etc/resolv.conf.
  - `[name]` – tên của bản ghi resource sẽ được truy vấn.
  - `[type]` – loại truy vấn được yêu cầu bởi dig. Nó có thể là 1 trong số các bản ghi: A, MX, SOA,…Nếu không có bản ghi nào được chỉ định thì dig sẽ mặc định đó là bản ghi A.
### 3. Cách sử dụng lệnh dig
- Thực hiện tra cứu DNS cho một tên miền, thực hiện câu lệnh:
```
dig www.jaeger.com
```
   - OUTPUT
```
; <<>> DiG 9.11.4-P2-RedHat-9.11.4-16.P2.el7_8.6 <<>> www.jaeger.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 400
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 2

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.jaeger.com.                        IN      A

;; ANSWER SECTION:
www.jaeger.com.         86400   IN      A       192.168.18.136

;; AUTHORITY SECTION:
jaeger.com.             86400   IN      NS      dns1.jaeger.com.

;; ADDITIONAL SECTION:
dns1.jaeger.com.        86400   IN      A       192.168.18.188

;; Query time: 0 msec
;; SERVER: 192.168.18.188#53(192.168.18.188)
;; WHEN: Tue Sep 29 10:50:11 +07 2020
;; MSG SIZE  rcvd: 94
```
- Giải thích output của câu lệnh `dig`:
  - Dòng đầu tiên của đầu ra hiển thị version đã cài đặt và truy vấn được gọi. Dòng thứ hai hiển thị các tùy chọn(theo mặc định chỉ cmd).
```
; <<>> DiG 9.11.4-P2-RedHat-9.11.4-16.P2.el7_8.6 <<>> www.jaeger.com
;; global options: +cmd
;; Got answer:
```
  Nếu bạn không muốn những dòng này xuất hiện ở output, có thể sử dụng tùy chọn +nocmd ở ngay sau câu lệnh dig
  - Phần tiếp theo, dòng đầu tiên của phần này là tiêu đề, bao gồm opcode và trạng thái của hành động. Trong trường hợp này, trạng thái `NOERROR` có nghĩa là yêu cầu truy vấn truy vấn DNS không gặp lỗi.
```
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 400
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 2
```
   Bạn cũng có thể cho phép không hiển thị phần này ở output bằng cách sử dụng tùy chọn `+nocomments`, đồng thời nó cũng sẽ `disable output` của 1 vài phần header khác
   - Phần "OPT" được hiển thị theo mặc định chỉ trên các phiên bản mới hơn.
```
;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
```
   - Phần "QUESTION" là phần mà lệnh dig hiển thị truy vấn của chúng ta. Theo mặc định, dig sẽ yêu cầu bản ghi A.
```
;; QUESTION SECTION:
;www.jaeger.com.                        IN      A
```
   Bạn có thể disable output của phần này bằng cách sử dụng tùy chọn `+noquestion`
   - Phần ANSWER cung cấp cho chúng ta tên miền jaeger.com. trỏ đến địa chỉ IP 192.168.18.136
```
;; ANSWER SECTION:
www.jaeger.com.         86400   IN      A       192.168.18.136
```
   Disable phần output này với tùy chọn +noanswer nếu bạn cần.
   - Phần `AUTHORITY` nói cho chúng ta biết những server nào là authority để trả lời truy vấn `DNS` về truy vấn tên miền.
```
;; AUTHORITY SECTION:
jaeger.com.             86400   IN      NS      dns1.jaeger.com.
```
   Disable nó bằng tùy chọn `+noauthority`
   - Phần `ADDITIONAL` cho chúng ta thông tin về địa chỉ IP của các authoritative DNS server
```
;; ADDITIONAL SECTION:
dns1.jaeger.com.        86400   IN      A       192.168.18.188
```
   Tùy chọn `+noadditional` sẽ giúp bạn `disable` phần này.
   - Phần cuối của OUTPUT bao gồm các số liệu đầu ra của truy vấn
```
;; Query time: 0 msec
;; SERVER: 192.168.18.188#53(192.168.18.188)
;; WHEN: Tue Sep 29 10:50:11 +07 2020
;; MSG SIZE  rcvd: 94
```
   Bạn có thể disable phần này với tùy chọn `+nostats`

### 4. Sử dụng lệnh dig với các truy vấn ngắn
#### Truy vấn lấy địa chỉ IP
- Sử dụng dig với tùy chọn `+short`:
```
dig jaeger.com +short
```
kết quả trả về chỉ bao gồm IP của bản ghi `A`:

<img src="https://image.prntscr.com/image/bNzTIQSMSuKuSW19ahh1sw.png">

- Để có kết quả chi tiết hơn, bạn có thể sử dụng thêm 2 tùy chọn `+noall` và `+answer`
```
dig www.jaeger.com +noall +answer
```
kết quả:

```[root@demo ~]# dig www.jaeger.com +noall +answer

; <<>> DiG 9.11.4-P2-RedHat-9.11.4-16.P2.el7_8.6 <<>> www.jaeger.com +noall +answer
;; global options: +cmd
www.jaeger.com.         86400   IN      A       192.168.18.136
```
- trong đó:
  - `+noall`: tắt tất cả các section
  - `+answer`: chỉ mở với secion ANSWER
#### Truy vấn với name server cụ thể
- Theo mặc định nếu khi sử dụng lệnh dig mà không chỉ rõ name server nào thì server sẽ sử dụng name server được khai báo trong file `/etc/resolv.conf`
- Để chỉ định name server mà truy vấn sẽ thực hiện, sử dụng biểu tượng `@ + địa chỉ IP/hostname`

*Ví dụ*: Truy vấn name server dns1.jaeger.com có địa chỉ là 192.168.18.188 để lấy thông tin về tên miền www.jaeger.com
  - OUTPUT
```
; <<>> DiG 9.11.4-P2-RedHat-9.11.4-16.P2.el7_8.6 <<>> dns1.jaeger.com @192.168.18.188
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 36655
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;dns1.jaeger.com.               IN      A

;; ANSWER SECTION:
dns1.jaeger.com.        86400   IN      A       192.168.18.188

;; AUTHORITY SECTION:
jaeger.com.             86400   IN      NS      dns1.jaeger.com.

;; Query time: 1 msec
;; SERVER: 192.168.18.188#53(192.168.18.188)
;; WHEN: Tue Sep 29 11:17:48 +07 2020
;; MSG SIZE  rcvd: 74

```
#### Truy vấn theo bản ghi

 - Truy vấn bản ghi A

 Để có danh sách địa chỉ cho 1 tên miền, sử dụng tùy chọn `a`
 ```
  dig +nocmd jaeger.com a +noall +answer
```
kết quả trả về chỉ chứa thông tin bản ghi `A`:
```
[root@demo ~]# dig +nocmd www.jaeger.com a +noall +answer
www.jaeger.com.         86400   IN      A       192.168.18.136

```
*Chú ý*: Để truy vấn với các loại bản ghi khác chúng ta làm tương tự

#### Tra cứu DNS Ngược 
- Để truy vấn tên máy chủ được liên kết với một địa chỉ IP cụ thể, hãy sử dụng tùy chọn -x.

*Ví dụ*: Tra cứu địa chỉ IP 192.168.18.146 thành tên miền
```
 dig -x 192.168.18.136 +noall +answer 
```
  - OUTPUT
```
; <<>> DiG 9.11.4-P2-RedHat-9.11.4-16.P2.el7_8.6 <<>> -x 192.168.18.136 +noall +answer
;; global options: +cmd
136.18.168.192.in-addr.arpa. 86400 IN   PTR     mail.jaeger.com.
136.18.168.192.in-addr.arpa. 86400 IN   PTR     www.jaeger.com.
```
#### Truy vấn số lượng lớn tên miền
- Nếu bạn muốn truy vấn một số lượng lớn tên miền, bạn có thể thêm chúng vào một tệp và sử dụng tùy chọn -f để truy vấn.


<img src="https://image.prntscr.com/image/v8vJh8rrQBWGilBizQ62GQ.png">


#### Truy vấn DNS bằng TCP
- Theo mặc định thì lệnh dig truy vấn DNS qua udp, để có thể dùng lệnh dig truy vấn DNS qua tcp chúng ta thực hiện như sau:
```
 dig +tcp [domain] 
 ```
*ví dụ*:

<img src="https://image.prntscr.com/image/hJ8BbluoQc6Gz8v2d5AlkQ.png">

# Nguồn tham khảo
https://news.cloud365.vn/tim-hieu-ve-lenh-dig/#C%C3%A0i-%C4%91%E1%BA%B7t-Dig-tr%C3%AAn-Linux

https://toiyeuit.com/lenh-dig-la-gi-cach-su-dung-dig-de-truy-van-ban-ghi-dns-tren-linux/#Tai_sao_lai_la_DNS
