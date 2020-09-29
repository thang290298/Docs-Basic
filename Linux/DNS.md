# Tìm hiểu DNS Server
# Mục Lục
[I. DNS và các khái niệm](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#i-dns-v%C3%A0-c%C3%A1c-kh%C3%A1i-ni%E1%BB%87m)

  - [1. Khái niệm](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#1-kh%C3%A1i-ni%E1%BB%87m)

  - [2. Chức năng của DNS](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#2-ch%E1%BB%A9c-n%C4%83ng-c%E1%BB%A7a-dns)

  - [3. File /etc/hosts](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#3-file-etchosts)

  - [4. Domain](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#4-domain)

  - [5. Các loại DNS Servers](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#5-c%C3%A1c-lo%E1%BA%A1i-dns-servers)

[II. Hoạt động của hệ thống DNS](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#ii-ho%E1%BA%A1t-%C4%91%E1%BB%99ng-c%E1%BB%A7a-h%E1%BB%87-th%E1%BB%91ng-dns)
  - [1. Hoạt động của hệ thống DNS](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#1-ho%E1%BA%A1t-%C4%91%E1%BB%99ng-c%E1%BB%A7a-h%E1%BB%87-th%E1%BB%91ng-dns)
  - [2. Các thành phần của DNS](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#2-c%C3%A1c-th%C3%A0nh-ph%E1%BA%A7n-c%E1%BB%A7a-dns)
    - [2.1 DNS Cache](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#21-dns-cache)
    - [2.2 Resolvers](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#22-resolvers)
    - [2.3 Name Servers](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#23-name-servers)
    - [2.4 Name Space.](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#24-name-space)

[III. Các loại bản ghi trên DNS](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#iii-c%C3%A1c-lo%E1%BA%A1i-b%E1%BA%A3n-ghi-tr%C3%AAn-dns)
  - [1 Resource Records](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#1-resource-records)
  - [2. Các loại Resource Record](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#2-c%C3%A1c-lo%E1%BA%A1i-resource-record)
    - [2.1. SOA (Start of Authority)](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#21-soa-start-of-authority)
    - [2.2. NS (Name Server)](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#22-ns-name-server)
    - [2.3. Record A](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#23-record-a)
    - [2.4. Record AAAA](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#24-record-aaaa)
    - [2.5. PTR(Pointer Records)](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#25-ptrpointer-records)
    - [2.6.SRV(Service)](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#26srvservice)
    - [2.7. CNAME (Canonical Name)](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#27-cname-canonical-name)
    - [2.8. MX(Mail Exchange)](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#28-mxmail-exchange)
    - [2.9. TXT(Text)](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#29-txttext)
    - [2.10. DKIM(DomainKeys Identified Email)](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#210-dkimdomainkeys-identified-email)
    - [2.11. SPF(Sender Policy Framework)](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#211-spfsender-policy-framework)

[IV. Triển khai DNS Server trên Centos 8](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#iv-tri%E1%BB%83n-khai-dns-server-tr%C3%AAn-centos-8)
  - [1. chuẩn bị](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#1-chu%E1%BA%A9n-b%E1%BB%8B)
  - [2. Các Bước triển khai](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#2-c%C3%A1c-b%C6%B0%E1%BB%9Bc-tri%E1%BB%83n-khai)
    - [Thực hiện trên DNS Server](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#th%E1%BB%B1c-hi%E1%BB%87n-tr%C3%AAn-dns-server)
    - [Kiểm tra kết nối DNS trên Client](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#ki%E1%BB%83m-tra-k%E1%BA%BFt-n%E1%BB%91i-dns-tr%C3%AAn-client)
[V. Bắt gói tin DNS](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#v-b%E1%BA%AFt-g%C3%B3i-tin-dns)
  - [1. Sử dụng TCPDUMP](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#1-s%E1%BB%AD-d%E1%BB%A5ng-tcpdump)
  - [2. Sử dụng Wireshark để bắt gói tin DNS](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#2-s%E1%BB%AD-d%E1%BB%A5ng-wireshark-%C4%91%E1%BB%83-b%E1%BA%AFt-g%C3%B3i-tin-dns)
  
[Nguồn tham khảo](https://github.com/thang290298/work-Document/blob/master/Linux/DNS.md#ngu%E1%BB%93n-tham-kh%E1%BA%A3o)



## I. DNS và các khái niệm
### 1. Khái niệm
- DNS là “Domain Name Server” nhưng thực chất nó là viết tắt của Domain Name System – hệ thống tên miền – là một hệ thống cho phép thiết lập tương ứng giữa địa chỉ IP và tên miền trên Internet
### 2. Chức năng của DNS
- Tất cả các thiết bị trên Internet có thể giao tiếp được với nhau là nhờ có địa chỉ IP(IPv4 và IPv6). Khi bạn muốn truy cập vào 1 trang web như facebook.com, github.com, dantri.com.vn,… thì bản chất thực sự của nó là truy cập vào địa chỉ IP của server chứa dữ liệu của các trang web này. Tuy nhiên không phải ai cũng có thể nhớ được đúng và nhớ được hết địa chỉ IP của các trang web, từ đó DNS đã xuất hiện.
- DNS đóng vai trò như 1 người phiên dịch, dịch giữa địa chỉ IP và tên miền chứ không có tác dụng thay thế hoàn toàn cho địa chỉ IP. Bạn cũng có thể tải 1 website bằng cách nhập trực tiếp địa chỉ IP thay vì dùng tên miền nếu bạn biết và nhớ địa chỉ IP của trang web đó
- Mỗi DNS còn có chức năng ghi nhớ những tên miền mà nó đã phân giải và ưu tiên sử dụng cho những lần truy cập sau.
- Nhờ DNS, bạn có thể sử dụng nhiều dịch vụ mạng như tìm kiếm thông tin, xem phim, chơi game, đăng nhập các website,…Có thể nói nếu không có DNS, con người không thể duyệt Internet nhanh chóng và dễ dàng như ngày nay.
### 3. File /etc/hosts
- Nếu không cần DNS Server, mọi hệ thống sẽ phải giữ file chứa bảng tên miền và địa chỉ IP, trên hệ thống Linux nó là file /etc/hosts
- Khi bạn bắt đầu truy cập vào 1 trang web, hệ thống sẽ tìm trong file này đầu tiên, nếu tìm thấy thông tin về địa chỉ IP và tên miền thì nó sẽ không đi tới DNS Server nữa.
- Cú pháp:
```
  IP_address domain
```
<img src="https://image.prntscr.com/image/8dPMu9ujRyyLl1YoKtiS9A.png">

### 4. Domain
- Khi bạn đi tới 1 website, bạn sẽ gõ FQDN (Fully Qualified Domain Name) – tên miền đủ điều kiện hoặc tên miền có dạng: news.cloud365.vn hoặc www.news.cloud365.vn.
- Cấu trúc của hệ thống tên miền:
   - Hiện nay hệ thống tên miền trên thế giới được phân bố theo cấu trúc hình cây. tên miền cấp cao nhất là tên miền gốc (ROOT) được thể hiện bằng dấu “.”.
   - Dưới tên miền gốc có hai loại tên miền là: tên miền cấp cao dùng chung- gTLDs (generic Top Level Domains) và tên miền cấp cao quốc gia – ccTLD (country code Top Level Domains) như .vn, .jp, .kr, .…

<img src="https://news.cloud365.vn/wp-content/uploads/2020/02/DomainName-updated.png">

- Top Level Domain Names (TLDs):
  - TLDs được chia dựa trên các khu vực địa lý hoặc các lĩnh vực liên quan.
  - Tại thời điểm của bài viết, trên thế giới hiện có khoảng 800 TLDs.
  - Danh mục TLDs hiện tại:
      - Generic top-level domain, ví dụ: .org, .com, .net, .gov, .edu,…

      - Country-code top-level domains(tên miền cấp cao quốc gia), ví dụ: .us, .ca, .vn,…

      - New branded top-level domains(tên miền cấp mới cho các thương hiệu), ví dụ: .linux, .microsoft, .companyname,…

      - Infrastructure top-level domains(tên miền cấp cao cho cơ sở hạ tầng), ví dụ: .arpa,…

- Subdomains:
  - Khi bạn đi tới một trang web, ví dụ như mail.google.com thì mail ở đây được gọi là subdomain của google.com

  - Chỉ các name server cho mail.google.com biết được tất cả các host tồn tại phía bên dưới nó, cho nên google sẽ trả lời có subdomain mail hay không, root name server sẽ không có dữ liệu cho việc này.
### 5. Các loại DNS Servers
- Primary DNS servers: chứa các file cấu hình tên miền và phản hồi các truy vấn DNS

- Secondary DNS server: làm việc như một backup và load balancer server. Các Primary DNS server biết sự tồn tại của Secondary DNS server và sẽ gửi các bản cập nhật cho chúng.

- Caching DNS server: làm nhiệm vụ lưu trữ các phản hồi DNS nhờ vậy bạn sẽ không cần hỏi lại Primary DNS server trong lần thứ 2 truy cập vào website.

## II. Hoạt động của hệ thống DNS
### 1. Hoạt động của hệ thống DNS
- Trước hết chương trình trên máy người sử dụng gửi yêu cầu tìm kiếm địa chỉ IP ứng với tên miền beta.example.com tới máy chủ quản lý tên miền cục bộ(Local DNS Server hay Local Name Server) thuộc mạng của nó.
- Máy chủ tên miền cục bộ này kiểm tra trong cơ sở dữ liệu của nó có chứa cơ sở dữ liệu chuyển đổi từ tên miền sang địa chỉ IP của tên miền mà người sử dụng yêu cầu không. Trong trường hợp máy chủ tên miền cục bộ có cơ sở dữ liệu này, nó sẽ gửi trả lại địa chỉ IP của máy có tên miền nói trên.

### 2. Các thành phần của DNS
#### 2.1 DNS Cache
Thuật ngữ này thường bị nhầm lẫn do nó có ít nhất 2 ý nghĩa. Đầu tiên DNS Cache có thể là danh sách tên và địa chỉ IP mà bạn đã truy vấn và đã được giải quyết và được lưu vào bộ nhớ cache để không có lưu lượng truy cập mạng được tạo ra và truy cập nhanh hơn. Ý nghĩa thứ hai liên quan đến một DNS Server chỉ đơn giản là thực hiện các truy vấn đệ quy và bộ đệm ẩn mà không thực sự là một máy chủ có thẩm quyền.
#### 2.2 Resolvers
Là bất kỳ host nào trên Internet cần dùng để tra cứu thông tin tên miền, giống như thiết bị bạn đang sử dụng để đọc trang web này.
#### 2.3 Name Servers
Những server này chứa cơ sở dữ liệu về tên và địa chỉ IP và phục vụ các yêu cầu DNS cho clien
#### 2.4 Name Space.
Là cơ sở dữ liệu về địa chỉ IP và các tên liên quan của chúng.
## III. Các loại bản ghi trên DNS
### 1 Resource Records
Resource Record là một bản ghi đơn mô tả chi tiết phần thông tin trong cơ sở dữ liệu DNS. Các bản ghi này có dạng văn bản đơn giản, giống như là:

```
 `Owner`    `TTL`    `Class`   `Type`    `RDATA`
```
Mỗi trường này phải được phân tách bằng ít nhất một khoảng trắng
### 2. Các loại Resource Record
#### 2.1. SOA (Start of Authority)
- Thông thường, mỗi tên miền sẽ sử dụng 1 cặp DNS nào đó để trỏ về 1 hoặc nhiều máy chủ DNS, và ở đây, các máy chủ DNS có trách nhiệm cung cấp thông tin bản ghi DNS của hệ thống cho tên miền này để nó hoạt động. SOA được coi như dấu hiệu nhận biết của hệ thống về tên miền này. Một cấu trúc của bản ghi SOA thông thường sẽ bao gồm:

```
[tên miền] IN SOA [tên-server-dns] [địa-chỉ-email] (serial number;refresh number;retry number;experi number;time-to-live number) 
```
*Ví dụ:*
```
$TTL 86400
@       IN SOA  masterdns.hiennt.com.     admin.hiennt.com. (
                                2014090401    ; serial
                                      3600    ; refresh
                                      1800    ; retry
                                    604800    ; expire
                                     86400 )  ; TTL
```
Trong đó:
  - masterdns.hiennt.com. – giá trị DNS chính của tên miền hoặc máy chủ.
  - admin.hiennt.com. chuyển đổi từ dạng admin@hiennt.com, thể hiện chủ thể sở hữu tên miền này.
  - Serial: áp dụng cho mọi dữ liệu trong zone và có định dạng YYYYMMDDNN với YYYY là năm, MM là tháng, DD là ngày, NN là số lần sửa đổi dữ liệu zone trong ngày. Luôn luôn phải tăng số này lên mỗi lần sửa đổi dữ liệu zone. Khi Slave DNS Server liên lạc với Master DNS Server, trước tiên nó sẽ hỏi số serial. Nếu số serial của Slave nhỏ hơn số serial của máy Master tức là dữ liệu zone trên Slave đã cũ và sau đó Slave sẽ sao chép dữ liệu mới từ Master thay cho dữ liệu đang có.
  - Refresh: chỉ ra khoảng thời gian Slave DNS Server kiểm tra dữ liệu zone trên Master để cập nhật nếu cần. Giá trị này thay đổi tùy theo tuần suất thay đổi dữ liệu trong zone.
  - Retry: nếu Slave DNS Server không kết nối được với Master DNS Server theo thời hạn mô tả trong refresh (ví dụ Master DNS Server bị shutdown vào lúc đó thì Slave DNS Server phải tìm cách kết nối lại với Master DNS Server theo một chu kỳ thời gian mô tả trong retry. Thông thường, giá trị này nhỏ hơn giá trị refresh).
  - Expire: nếu sau khoảng thời gian này mà Slave DNS Server không kết nối được với Master DNS Server thì dữ liệu zone trên Slave sẽ bị quá hạn. Khi dữ liệu trên Slave bị quá hạn thì máy chủ này sẽ không trả lời mỗi truy vấn về zone này nữa. Giá trị expire này phải lớn hơn giá trị refresh và giá trị retry.
  - Minimum TTL: chịu trách nhiệm thiết lập TTL tối thiểu cho 1 zone.
#### 2.2. NS (Name Server)
- Bản ghi NS dùng để khai báo máy chủ tên miền cho một tên miền. Nó cho biết các thông tin về tên miền này được khai báo trên máy chủ nào. Với mỗi một tên miền phải có tổi thiểu hai máy chủ tên miền quản lý, do đó yêu cầu có tối thiểu hai bản ghi NS cho mỗi tên miền.

- Cú pháp của bản ghi NS:
```
<tên miền> IN NS <tên của máy chủ tên miền>
```

*Ví dụ:*
```
  thuyhiend.space IN NS ns1.zonedns.vn
  thuyhiend.space IN NS ns2.zonedns.vn
```
Với khai báo trên, tên miền thuyhiend.space sẽ do máy chủ tên miền có tên ns1.zonedns.vn và ns2.zonedns.vn quản lý. Điều này có nghĩa, các bản ghi như A, CNAME, MX … của tên miền thuyhiend.space và các tên miền cấp dưới của nó sẽ được khai báo trên máy chủ ns1.zonedns.vn và ns2.zonedns.vn.
#### 2.3. Record A
- Là một record căn bản và quan trọng, dùng để ánh xạ từ một domain thành địa chỉ IP cho phép có thể truy cập website. Đây là chức năng cốt lõi của hệ thống DNS. Record A có dạng như sau:
```
  domain IN A <địa chỉ IPv4 của máy> 
```
- Ví dụ về 1 khai báo bản ghi A
```
  thuyhiend.space   A    103.101.161.201
```
Tên miền con (subdomain):

```
  sub.thuyhiend.space   A   103.101.161.201
```

#### 2.4. Record AAAA
Có nhiệm vụ tương tự như bản ghi A, nhưng thay vì địa chỉ IPv4 sẽ là địa chỉ IPv6.

#### 2.5. PTR(Pointer Records)
- Bản ghi PTR (pointer) trỏ một địa chỉ IP đến một bản ghi A trong chế độ ngược (reverse) và được sử dụng trong kiểu tên miền infrastructure TLD.
<img src="https://news.cloud365.vn/wp-content/uploads/2020/02/PTR-Record-700x315-1.jpg">

- Ví dụ về dạng thức một bản ghi PTR như sau:
```
 90.163.101.103.in-addr.arpa       IN PTR     masterdns.thuyhiend.space.  
 ```
 đối với IPv4, hoặc đối với IPv6:
 ```
 0.0.0.0.0.0.0.0.0.0.0.0.d.c.b.a.4.3.2.1.3.2.1.0.8.c.d.0.1.0.0.2.ip6.arpa  IN PTR masterdns.thuyhiend.space. 
 ```
 #### 2.6.SRV(Service)
 - Bản ghi SRV được sử dụng để xác định vị trí các dịch vụ đặc biệt trong 1 domain, ví dụ tên máy chủ và số cổng của các máy chủ cho các dịch vụ được chỉ định.
 *Ví dụ:*
 ```
   _ldap._tcp.thuyhiend.space. 3600  IN  SRV  10  0  389  ldap01.thuyhiend.space.
```
Một Client trong trường hợp này có thể nhờ DNS nhận ra rằng, trong tên miền thuyhiend.space có LDAP Server ldap01, mà có thể liên lạc qua cổng TCP Port 389 .
- Các trường trong record SRV :
  - Tên dịch vụ service.

  - Giao thức sử dụng.

  - Tên miền (domain name).

  - TTL: Thời gian RR được giữ trong cache

  - Class: standard DNS class, luôn là IN

  - Ưu tiên: ưu tiên của host, số càng nhỏ càng ưu tiên.

  - Trọng lượng: khi cùng bực ưu tiên, thì trọng lượng 3 so với trọng lượng 2 sẽ được lựa chọn 60% (hỗ trợ load balancing).

  - Port của dịch vụ (tcp hay udp).

  - Target chỉ định FQDN cho host hỗ trợ dịch vụ.
#### 2.7. CNAME (Canonical Name)

- Bản ghi CNAME cho phép một máy tính có thể có nhiều tên. Nói cách khác bản ghi CNAME cho phép nhiều tên miền cùng trỏ đến một địa chỉ IP cho trước.
- Để có thể khai báo bản ghi CNAME, bắt buộc phải có bản ghi kiểu A để khai báo tên của máy. Tên miền được khai báo trong bản ghi kiểu A trỏ đến địa chỉ IP của máy được gọi là tên miền chính (canonical domain). Các tên miền khác muốn trỏ đến máy tính này phải được khai báo là bí danh của tên máy (alias domain).
- Cú pháp của bản ghi CNAME:
```
   alias-domain IN CNAME canonical domain. 
```
*Ví dụ:*
```
  www.thuyhiend.space IN CNAME home.thuyhiend.space.
  ```
  #### 2.8. MX(Mail Exchange)
- Bản ghi MX có tác dụng xác định, chuyển thư đến domain hoặc subdomain đích. Bản ghi MX có dạng
```
  thuyhiend.space    MX    10    mail.thuyhiend.space.
  mail.thuyhiend.space    A    103.101.161.201
  ```
Độ ưu tiền càng cao thì số càng thấp. Ví dụ nếu khai báo
```
  thuyhiend.space MX 10 mail_1.thuyhiend.space
  thuyhiend.space MX 20 mail_2.thuyhiend.space
  thuyhiend.space MX 30 mail_3.thuyhiend.space
```
#### 2.9. TXT(Text)
- Bản ghi TXT(text) được sử dụng để cung cấp khả năng liên kết văn bản tùy ý với máy chủ. Chủ yếu dùng trong mục đích xác thực máy chủ với tên miền.
#### 2.10. DKIM(DomainKeys Identified Email)
- Là bản ghi dùng để xác thực người gửi bằng cách mã hóa một phần email gửi bằng một chuỗi ký tự, xem như là chữ ký.
- Khi email được gửi đi máy chủ mail sẽ kiểm so sánh với thông tin bản ghi đã được cấu hình trong DNS để xác nhận. Bản ghi DKIM có dạng:
```
 mail._domainkey.thuyhiend.space     TXT  k=rsa;p=MIIBIjANBgkqhkiG9w0BA
 ```
 #### 2.11. SPF(Sender Policy Framework)
 - Record SPF được tạo ra nhằm đảm bảo các máy chủ mail sẽ chấp nhận mail từ tên miền của khách hàng chỉ được gửi đi từ server của khách hàng. Sẽ giúp chống spam và giả mạo email. Bản ghi SPF thể hiện dưới dạng:
 ```
    thuyhiend.space   SPF     "v=spf1 ip4:103.101.162.0/24 -all" 3600 

```
Tùy vào hệ thống DNS mà có thể hiển thị bản ghi SPF hoặc TXT Với bản ghi SPF, máy chủ tiếp nhận mail sẽ kiểm tra IP của máy chủ gửi và IP của máy chủ đã đăng kí bản ghi SPF example.com. Nếu Khách hàng có nhiều máy chủ mail nên liệt kê tất cả trong bản ghi SPF giúp đảm bảo thư đến được chính xác và đầy đủ.
## IV. Triển khai DNS Server trên Centos 8
### 1. chuẩn bị
- Máy chủ DNS Server:
    - Hệ điều hành: CentOS 8
    - CPU: 1 core
    - Ram: 2 GB
    - Disk: 30 GB
    - IP: 192.168.18.188/24
- máy chủ Web:
    - Hệ điều hành : CentOS 7
    - CPU: 1 Core
    - Ram: 2GB
    - Disk: 60 GB
    - IP: 192.168.18.136/24
- Máy Client:
    - Hệ điều hành: Windows 7 32 bit
    - IP: 192.168.18.146/24
### 2. Các Bước triển khai
#### Thực hiện trên DNS Server
- Cài đặt bind và bind-utils:
  - Cài đặt gói phần mềm BIND và bind-utills(để sử dụng được 2 câu lệnh nslookup và dig). BIND là ứng dụng cung cấp DNS server phổ biến nhất hiện nay. Sử dụng câu lệnh:
```
  dnf -y install bind*
```

  - Start dịch vụ DNS
```
  systemctl start named
  systemctl enable named
  systemctl status namedv
```
<img src="https://image.prntscr.com/image/uRWanxC0TimebIBmyOH8EA.png">

- Cấu hình bind DNS server:
  - Cấu hình DNS Server, chỉnh sửa file /etc/named.conf
*Chú ý*: Thay địa chỉ IP trong file cấu hình thành địa chỉ IP của bạn.

```
  cp /etc/named.conf  /etc/named.bak
  vi /etc/named.conf
```

Trong phần options, chuyển 2 dòng sau thành bình luận như sau:

```
//listen-on port 53 { 127.0.0.1; };
//listen-on-v6 port 53 { ::1; }; 
```
  - Chỉnh sửa thông số `allow-query`, chú ý địa chỉ IP của bạn
```
allow-query     { localhost; 192.168.18.0/24; }; 

```
<img src="https://image.prntscr.com/image/xQFoXORTQzej5bSzj0D5Tg.png">

Cài đặt này chỉ cho phép các máy chủ trong mạng được xác định truy cập vào máy chủ DNS.
Để xác định reverse và forward lookup zones, thêm vào cuối file named.conf cấu hình dưới:
```
   //forward zone
   zone "jaeger.com" IN {
        type master;
       file "dns1.jaeger.com.db";
       allow-update { none; };
       allow-query { any; };   };
   //backward zone
   zone "18.168.192.in-addr.arpa" IN {
       type master;
       file "jaeger.com.rev";
       allow-update { none; };
       allow-query { any; };
   };
```
<img src="https://image.prntscr.com/image/Ig1TCBk8QiWfs7UeeOWMcg.png">

Trong đó:
  - `type`: Quy định vai trò của server cho một zone(khu vực) cụ thể. Thuộc tính master cho biết đây là 1 server có thẩm quyền.

  - `file`: chứa thông tin về file `forward / reverse` zone của domain.

  - `allow-update`: Thuộc tính này xác định các host system có được phép chuyển tiếp cập nhật DNS động. Trong trường hợp này không.

- Tạo forward DNS zone file cho tên miền:
Tạo một forward DNS zone file cho tên miền `jaeger.com` theo câu lệnh bên dưới:
```
 vi /var/named/dns1.jaeger.com.db
```
Thêm vào nội dung
```
$TTL 86400
@ IN SOA dns1.jaeger.com. admin.jaeger.com. (
                                           2020011800 ;Serial
                                           3600 ;Refresh
                                           1800 ;Retry
                                           604800 ;Expire
                                           86400 ;Minimum TTL

)
;Name Server Information
@ IN NS dns1.jaeger.com.

;IP Address for Name Server
dns1 IN A 192.168.18.188

;Mail Server MX (Mail exchanger) Record
jaeger.com IN MX 10 mail.jaeger.com.

;A Record for the following Host name
www  IN   A   192.168.18.136
jaeger.com A 192.168.18.136
mail IN   A   192.168.18.146
;CNAME Record
ftp  IN   CNAME www.jaeger.com.
```
<img src="https://image.prntscr.com/image/YyCBbQRgSBih-NE6avZ8Jg.png">

- Tạo reverse DNS zone file cho tên miền
  - Tạo một reverse DNS zone file cho tên miền jaeger.com theo câu lệnh bên dưới:
```
vi /var/named/jaeger.com.rev
```
Thêm vào nội dung
```
$TTL 86400
@ IN SOA dns1.jaeger.com. admin.jaeger.com. (
                                           2020011800 ;Serial
                                           3600 ;Refresh
                                           1800 ;Retry
                                           604800 ;Expire
                                           86400 ;Minimum TTL
   )
;Name Server Information
@ IN NS dns1.jaeger.com.
dns1     IN      A       192.168.18.188
;Reverse lookup for Name Server
188 IN PTR dns1.jaeger.com.
;PTR Record IP address to Hostname
136      IN      PTR     www.jaeger.com.
136      IN      PTR     mail.jaeger.com.
~
```
<img src="https://image.prntscr.com/image/pqziEW2aRgOHwdfYnzbzcg.png">
  
  - Gán các quyền cần thiết cho 2 file cấu hình trên
```
chmod +x /var/named/dns1.jaeger.com.db
chmod +x /var/named/jaeger.com
```
  - Kiểm tra các file DNS zone lookup có gặp lỗi không, sử dụng các câu lệnh:
```
  named-checkconf
  named-checkzone jaeger.com /var/named/dns1.jaeger.com.db
  named-checkzone 192.168.18.136 /var/named/jaeger.com.rev
```

<img src="https://image.prntscr.com/image/JpiH6QwrS3KyxINGVwpj-w.png">

  - Khởi động lại Bind DNS server để hệ thống nhận cấu hình mới:
```
systemctl restart named
```
  - Cấu hình firewall để cho phép client truy cập vào hệ thống
```
firewall-cmd --permanent --add-port=53/udp
firewall-cmd --reload
```
#### Thực hiện trên máy chủ Web
- trên máy chủ web tiến hành cài đặt Wordpress với tên miền jaeger.com
- hướng dẫn cài Wordpress tại [đây](https://github.com/thang290298/work-Document/blob/master/WordPress/install-LAMP-WordPess-CentOS7.md)
- Chỉnh sửa file /etc/resolv.conf và thêm vào cấu hình
```
nameserver 192.168.18.188
```
- Chỉnh sửa file `/etc/sysconfig/network-scripts/ifcfg-ens33`, khai báo DNS mới là địa chỉ IP của BIND DNS Server

```
DNS="192.168.18.188"
```
- Restart NetworkManager để nhận cấu hình mới
```
  systemctl restart NetworkManager
```
#### Kiểm tra kết nối DNS trên Client
- thay đổi, cấu hình Card mạng trỏ DNS về `192.168.18.188`

<img src="https://image.prntscr.com/image/a3Rhp6lKT7Cqrm5wgcPg2A.png">

- Truy cập website trên may chủ web bằng tên miền ` jaeger.com`

<img src="https://image.prntscr.com/image/ax-m1OIVTUOxO2C9wZN_Ig.png">

- Sử dụng câu lệnh nslookup để kiểm tra hoạt động của Bind DNS server, như sau:
```
  nslookup dns1.jaeger.com
  nslookup mail.jaeger.com
  nslookup www.jaeger.com
  nslookup ftp.jaeger.com
```
<img src="https://image.prntscr.com/image/dYY8GIODT3OgkAk5SQWNqA.png">

```
nslookup 192.168.18.188

```
<img src="https://image.prntscr.com/image/D3MIJyeDQBi61jMQNb-DHQ.png">

## V. Bắt gói tin DNS
### 1. Sử dụng TCPDUMP
- Cài đặt TCPDump trên `CentOS 7`
```
yum install tcpdump -y
```
- trên máy chủ Web sử dụng TCPDump để phân tích gói tin DNS từ `client` lên `DNS Server` 
```
tcpdump -n -s 1500 -i ens33 udp port 53
```

<img src="https://image.prntscr.com/image/cjwdcrC8SwGn-c-toXqdyA.png">

Sau khi máy `Client ` gửi 1 bản tin request đến `DNS server`, server sẽ kiểm tra và phản hồi request bằng địa chỉ IPv4 có trên bản ghi A .
- đối với tên miền không có bản ghi DNS hệ thống sẽ  phản hồi bằng 1 thông báo không tìm thấy bản khi ghi với  tên miền `client ` yêu cầu:

<img src="https://image.prntscr.com/image/LhFAZkOqR9SzD23gN8143Q.png">

### 2. Sử dụng Wireshark để bắt gói tin DNS

- Khi `Client` gửi querry tìm kiếm bản ghi A cho tên miền `www.jaeger.com`, máy chủ phản hồi thông tin ip và nameserver của tên miền truy vấn.
<img src="https://image.prntscr.com/image/3HggkSUQR8qVm4zOtpcz2g.png">

- Đối với những tên  miền không tồn tại trên máy chủ DNS hệ thống sẽ thông báo không tìm thấy bản ghi trên nameserver

<img src="https://image.prntscr.com/image/cKMZhBDiRXe_hgt5XdLB1w.png">

# Nguồn tham khảo

https://news.cloud365.vn/dns-cau-hinh-dns-server-tren-centos-8/



