# Check list cài dặt và thực hiện giám sát trên Check MK
# Mục lục
[I. Cài đặt check Mk trên Centos 7](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#i-c%C3%A0i-%C4%91%E1%BA%B7t-check-mk-tr%C3%AAn-centos-7)
- [1. Mô hình triển khai](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#1-m%C3%B4-h%C3%ACnh-tri%E1%BB%83n-khai)
- [2. Thiết lập ban đầu](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#2-thi%E1%BA%BFt-l%E1%BA%ADp-ban-%C4%91%E1%BA%A7u)
- [3. Cài đặt Check_mk Server](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#3-c%C3%A0i-%C4%91%E1%BA%B7t-check_mk-server)
- [4. Cài đặt Agen check_mk](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#4-c%C3%A0i-%C4%91%E1%BA%B7t-agen-check_mk)
  - [4.1 Cài đặt Agen check_mk trên Centos 8](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#41-c%C3%A0i-%C4%91%E1%BA%B7t-agen-check_mk-tr%C3%AAn-centos-8)
  - [4.2 Cài đặt Agent check_mk trên Ubuntu](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#42-c%C3%A0i-%C4%91%E1%BA%B7t-agent-check_mk-tr%C3%AAn-ubuntu)
- [5. ADD host](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#5-add-host)
- [6. Setup cảnh báo qua telegram, setup notify.](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#6-setup-c%E1%BA%A3nh-b%C3%A1o-qua-telegram-setup-notify)
  - [6.1 Tạo bot telegram và tìm ID user](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#61-t%E1%BA%A1o-bot-telegram-v%C3%A0-t%C3%ACm-id-user)
  - [6.2 Cấu hình trên check_mk server](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#62-c%E1%BA%A5u-h%C3%ACnh-tr%C3%AAn-check_mk-server)
- [7. Active checks - monitor service Http](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#7-active-checks---monitor-service-http)
- [8. Giám sát server process linux](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#8-gi%C3%A1m-s%C3%A1t-server-process-linux)
- [9. Inventory hardware cho server](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#9-inventory-hardware-cho-server)
  - [9.1 Thao tác trên web check_mk](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#91-thao-t%C3%A1c-tr%C3%AAn-web-check_mk)
  - [9.2 Thao tác trên client](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#92-thao-t%C3%A1c-tr%C3%AAn-client)

## I. Cài đặt check Mk trên Centos 7
### 1. Mô hình triển khai

Mô hình triển khai gồm 1 node Check_MK Server và các node client

<img src="https://image.prntscr.com/image/VIxjhYTiThe6LBRSDzGNxA.png">

### 2. Thiết lập ban đầu
Update
```
yum install epel-release wget -y
yum update -y
```

Cấu hình IP: 
- thực hiện trên các node với IP đã được quy hoạch trong mô hình triển khai

```
      nmcli con modify ens33 ipv4.addresses 192.168.18.138/24
      nmcli con modify ens33 ipv4.gateway 192.168.18.2
      nmcli con modify ens33 ipv4.dns 8.8.8.8
      nmcli con modify ens33 ipv4.method manual
      nmcli con modify ens33 connection.autoconnect yes

      sudo systemctl disable firewalld
      sudo systemctl stop firewalld
      sudo systemctl disable NetworkManager
      sudo systemctl stop NetworkManager
      sudo systemctl enable network
      sudo systemctl start network
      sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
      sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
```

Cài đặt NTPD:

```
 yum install chronyd -y
 systemctl start chronyd 
 systemctl enable chronyd
 systemctl restart chronyd 
```
- Kiểm tra đồng bộ thời gian
```
chronyc sources -v
```
<img src="https://image.prntscr.com/image/54-h2IvnSNGSj1iOhKbaGw.png">

### 3. Cài đặt Check_mk Server

tải xuống phiên bản check_mk mới nhất từ trang web chính thức :
```
wget https://checkmk.de/support/1.6.0p17/check-mk-enterprise-1.6.0p17.demo-el7-38.x86_64.rpm

```
Cài đặt Check_MK và tất cả các phụ thuộc cần thiết cho check_mk.
```
yum install -y check-mk-enterprise-1.6.0p17.demo-el7-38.x86_64.rpm
```
Sau khi cài đặt kiểm tra phiên bản Check_mk

```
omd version
```
<img src="https://image.prntscr.com/image/VpiNFM0EQe_qo9xAlzD_ug.png">

- Tạo site và tên site tùy ý
```
omd create cloud365
```
khi tạo file sẽ tạo pass ngẫu nhiên cho site, tiến hành đổi pass site

```
htpasswd -m /omd/sites/cloud365/etc/htpasswd cmkadmin
```
<img src="https://image.prntscr.com/image/JUpt7TQJTwKbiBFINivl8A.png">

- khởi động site
```
omd start admin
```
- Truy cập
```
http://192.168.18.138/cloud365
```

<img src="https://image.prntscr.com/image/u7Z467DwTFW49bKieiVQeA.png">

### 4. Cài đặt Agen check_mk 
#### 4.1 Cài đặt Agen check_mk trên Centos 8 
Đầu tiên, chúng ta vào `Web UI` để tải Agent cho client. Ở giao diện Web, chúng ta kéo xuống phần `WATO - Configuration`, chọn tiếp `Monitoring Agent`:

<img src="https://image.prntscr.com/image/KOkSLC_dRXeNfu8UI0556Q.png">


Ở đây chúng ta có 3 loại file cài đặt đó là :

- *.deb: Dành cho các host sử dụng DEBIAN.

- *.rpm: Dành cho các host sử dụng RHEL.

- *.msi: Dành cho các host sử dụng MS Windows.
Ở đây, agent là CentOS 7 thì chúng ta sẽ chọn *.rpm: Dành cho các host sử dụng RHEL.

Coppy địa chỉ đường dẫn và dùng wget để tải file cài đặt về :
```
wget http://192.168.18.138/cloud365/check_mk/agents/check-mk-agent-1.6.0p17-1.noarch.rpm
```
Cài đặt xinetd:
```
  yum install xinetd -y
  systemctl start xinetd
  systemctl enable xinetd
```
Cài đặt Agent bằng câu lệnh :
```
rpm -ivh check-mk-agent-1.6.0p17-1.noarch.rpm
```
Sửa file cấu hình xinetd của checkmk tại `/etc/xinetd.d/check_mk `:
- Cấu hình gán IP Check_MK ở `only_from`:
<img src="https://image.prntscr.com/image/PKWRdaxpTkCnw-D8222otQ.png">

Khởi động lại xinetd:
```
systemctl restart xinetd
```
#### 4.2 Cài đặt Agent check_mk trên Ubuntu

Đối với Ubuntu chúng ta sẽ sử dụng `file *.deb` để cài đặt agent.

Đầu tiên, chúng ta vào Web UI để tải `Agent cho client`. Ở giao diện Web, chúng ta kéo xuống phần `WATO - Configuration`, chọn tiếp `Monitoring Agent`:


<img src="https://image.prntscr.com/image/Se3Lt5dvR_m0s_vlMTTNIQ.png">

thực hiện tải về:
```
wget
http://192.168.18.138/cloud365/check_mk/agents/check-mk-agent_1.6.0p17-1_all.deb
```
Cài đặt Agent bàng lệnh sau;
```
dpkg -i check-mk-agent_1.6.0p17-1_all.deb
```
Sửa file cấu hình xinetd của checkmk tại `/etc/xinetd.d/check_mk ` và `restart`:
<img src="https://image.prntscr.com/image/3K7LKvQlSa_xNBORUpXdjA.png">


### 5. ADD host
- Bước 1: Bấm vào host ở mục `WATO` và chọn `newhost`

<img src="https://image.prntscr.com/image/whPcHD-KTY2HBS4r1s09ig.png">

- Bước 2: Tiếp theo hãy điền thông tin của host mà bạn muốn giám sát bao gồm tên và địa chỉ IP của chúng. Sau đó lưu và đi đến service

<img src="https://image.prntscr.com/image/MAUfwkyWS7WYQELxhlgCDQ.png">

sau khi điền thông tin tiến hành `save & test`:

<img src="https://image.prntscr.com/image/0n0AgyJvTMywFa8PYznmmQ.png">

Sau đó chọn Save & go to Services để kiểm tra những dịch vụ và những thông số vật lý được giám sát thông qua agent, tại đây chọn Fix all missing để khi lưu lại thì các dịch vụ sẽ lên luôn các thông số :

<img src="https://image.prntscr.com/image/umjsKvhyRFWsDcCJaGoVnQ.png">

### 6. Setup cảnh báo qua telegram, setup notify.

#### 6.1 Tạo bot telegram và tìm ID user
- Tạo bot telegram để hiển thị cảnh bảo gửi từ check_mk server về.
- Sử dụng ứng dụng telegtam để mở `botfather`

<img src="https://image.prntscr.com/image/6dWyDwcVSJuHtIrEm8rd6Q.png">

-  thực hiện các bước sau:

```
 /newbot     : tạo bot
 /nvt_checkmk_bot        : đặt tê cho bot
 /nvt_checkmk_bot        : xác nhận bot
```

sau khi khởi tạo bot thành công bạn sẽ nhận được thông tin con bot telegram của mình, lưu giữ lại chuỗi token.

<img src="https://image.prntscr.com/image/axnlojzFTpeYzkng8ROZqg.png">

- Xác định ID user
Để người dùng bất kỳ nào có thể nhận được cảnh báo thì user phải chat vào con bot đó và từ đó ta sẽ lấy được ID của người dùng đó để thiết lập cảnh báo trên check_mk.
*lưu ý*: Sau chỗ .org/ phải có chữ bot xong mới tới tokencuaban.
```
https://api.telegram.org/bottokencuaban/getUpdates
```
<img src="https://image.prntscr.com/image/FgI3WxUHQqes72h3jobsRg.png">

#### 6.2 Cấu hình trên check_mk server

- Tạo ra file telegram.py
```
    vi /omd/sites/cloud365/share/check_mk/notifications/telegram.py
```
Lưu ý: Trên đường dẫn tạo file ở trên `cloud365` chính là site của bạn.

Thay thế token_cua_ban bằng token con bot hiên thị cảnh báo. Bạn truy cập vào đường link ở dưới để lấy đoạn script cảnh báo qua telegram.
```
https://paste.cloud365.vn/?d81c54e86a5a20c1#yJw1TCDmVPZMtdu2DvG00BO15tGHiJjR4EO8QpGuAO4=
```
nội dung Scripts:
```
#!/usr/bin/env python
# Telegram V2

# Copyright Mathias Kettner  2013  mk@mathias-kettner.de
#           Stefan Gehn      2016  stefan+cmk@srcxbox.net

# check_mk is free software;  you can redistribute it and/or modify it
# under the  terms of the  GNU General Public License  as published by
# the Free Software Foundation in version 2.  check_mk is  distributed
# in the hope that it will be useful, but WITHOUT ANY WARRANTY;  with-
# out even the implied warranty of  MERCHANTABILITY  or  FITNESS FOR A
# PARTICULAR PURPOSE. See the  GNU General Public License for more de-
# ails.  You should have  received  a copy of the  GNU  General Public
# License along with GNU Make; see the file  COPYING.  If  not,  write
# to the Free Software Foundation, Inc., 51 Franklin St,  Fifth Floor,
# Boston, MA 02110-1301 USA.

# Telegram notification based on asciimail notification from
# check_mk 1.2.6p16.

import os
import re
import sys
reload(sys)
sys.setdefaultencoding('utf8')
import urllib
import urllib2
### CHANGE THESE ###
telegram_bot_token = 'token_cua_ban'
####################

tmpl_host_text = """*Check_MK: $HOSTNAME$ - $EVENT_TXT$*
```
Host:     $HOSTNAME$
Alias:    $HOSTALIAS$
Address:  $HOSTADDRESS$
Event:    $EVENT_TXT$
Output:   $HOSTOUTPUT$

$LONGHOSTOUTPUT$```"""

tmpl_service_text = """*Check_MK: $HOSTNAME$/$SERVICEDESC$ $EVENT_TXT$*
```
Host:     $HOSTNAME$
Alias:    $HOSTALIAS$
Address:  $HOSTADDRESS$
Service:  $SERVICEDESC$
Event:    $EVENT_TXT$
Output:   $SERVICEOUTPUT$

$LONGSERVICEOUTPUT$```"""

def substitute_context(template, context):
    # First replace all known variables
    for varname, value in context.items():
        template = template.replace('$'+varname+'$', value)

    # Remove the rest of the variables and make them empty
    template = re.sub("\$[A-Z_][A-Z_0-9]*\$", "", template)
    return template

def construct_message_text(context):
    notification_type = context["NOTIFICATIONTYPE"]
    if notification_type in [ "PROBLEM", "RECOVERY" ]:
        txt_info = "$PREVIOUS@HARDSHORTSTATE$ -> $@SHORTSTATE$"
    elif notification_type.startswith("FLAP"):
        if "START" in notification_type:
            txt_info = "Started Flapping"
        else:
            txt_info = "Stopped Flapping ($@SHORTSTATE$)"
    elif notification_type.startswith("DOWNTIME"):
        what = notification_type[8:].title()
        txt_info = "Downtime " + what + " ($@SHORTSTATE$)"
    elif notification_type == "ACKNOWLEDGEMENT":
        txt_info = "Acknowledged ($@SHORTSTATE$)"
    elif notification_type == "CUSTOM":
        txt_info = "Custom Notification ($@SHORTSTATE$)"
    else:
        txt_info = notification_type # Should neven happen

    txt_info = substitute_context(txt_info.replace("@", context["WHAT"]), context)

    context["EVENT_TXT"] = txt_info

    if context['WHAT'] == 'HOST':
        tmpl_text = tmpl_host_text
    else:
        tmpl_text = tmpl_service_text

    return substitute_context(tmpl_text, context)

def fetch_notification_context():
    context = {}
    for (var, value) in os.environ.items():
        if var.startswith("NOTIFY_"):
            context[var[7:]] = value.decode("utf-8")
    return context

def send_telegram_message(token, chat_id, text):
    url = 'https://api.telegram.org/bot%s/sendMessage' % (token)
    data = urllib.urlencode({'chat_id':chat_id, 'text':text, 'parse_mode':'Markdown'})
    #print("sending telegram message, url '%s', chat id '%s', text '%s'" % (url, chat_id, text))
    try:
        urllib2.urlopen(url, data).read()
    except urllib2.URLError, e:
        sys.stdout.write('Cannot send Telegram message: HTTP-Error %s %s\n' % (e.code, e))

def main():
    context = fetch_notification_context()
    telegram_chatid = context.get('CONTACT_TELEGRAM_CHAT_ID')
    if not telegram_chatid: # e.g. empty field in user database
        sys.stdout.write("Cannot send Telegram message: Empty destination chat id")
        sys.exit(2)
    text = construct_message_text(context)
    send_telegram_message(telegram_bot_token, telegram_chatid, text)

main()
```
   - Change quyền
```
chmod +x /omd/sites/cloud365/share/check_mk/notifications/telegram.py
```
   - Restart lại omd server
```
omd restart
```
- Cấu hình trên WATO giao diện web check_mk server
  - Tạo `Attributes User`

Click `Users` -> `Custom attributes`

<img src="https://image.prntscr.com/image/-WoFbYH1QEeOia8bLqfSFw.png">

 Click chọn `New Attributes`
 Nhập các thông tin chính xác sau:
 ```
 Name: TELEGRAM_CHAT_ID
Title: Telegram ID
Topic: Lựa chọn Identity
Tích chọn: Users can change this attribute in their personal settings, Show the setting of the attribute in the list table, Make this variable available in notifications
```

Tạo `user` muốn nhận cảnh báo:
Click `User -> New user`:

Nhập thông tin user mới lưu ý nhập chính xác ID telegram của user.

<img src="https://image.prntscr.com/image/JJM2T5h7RyKJR6IUGPdc3g.png">

- Tạo rule cảnh báo

Click  `Notification -> New Rule`

Ta có thể tùy chỉnh rất mạnh ở đây ví dụ như gửi cảnh báo tới ai, tới nhóm nào, xảy ra bởi sự kiện nào...

*Lưu ý*: Notification Method lựa chọn  Telegram V2

<img src="https://image.prntscr.com/image/7x7KoahISdq5JcqnHRM-8w.png">

Chỉ định user nhận cảnh báo

<img src="https://image.prntscr.com/image/XUvuR7CcS4SqvsWQyFDGEA.png">

Điều kiện cảnh báo khi host được mật hoặc tắt

<img src="https://image.prntscr.com/image/cPFiOvgWTiKkksnridKJmw.png">

Lưu lại và cập nhật thay đổi:

<img src="https://image.prntscr.com/image/TyWU2UhaTBK_RVuFMxSjfQ.png">

Khi một host được bật hoặc tắt thì bạn sẽ nhận được cảnh báo như sau:

<img src="https://image.prntscr.com/image/ZRJ53dU5SfqgzpdhYXYOcw.png">

### 7. Active checks - monitor service Http
Sử dụng kiểu Active check check_mk đã hỗ trợ sẵn.
Click `Host & Service Parameters -> Active checks (HTTP, TCP, etc.)`


<img src="https://image.prntscr.com/image/AWEtqRqNT2SB-6YSfCtviQ.png">

Click Check HTTP service

<img src="https://image.prntscr.com/image/g5-Dob6ESm_m4QoEwicilg.png">

- Tạo vào tùy biến rule cho việc check service http

<img src="https://image.prntscr.com/image/KRsap4mvSGqswhW_tHtzPQ.png">

điền các thông tin cơ bản:

<img src="https://image.prntscr.com/image/CYzwOxheS0Sn8Yu_jZAC3A.png">

*Lưu ý*: Active những thay đổi vừa cấu hình.

<img src="https://image.prntscr.com/image/cDNVF1Y4QEyTio2mUTWXmQ.png">  

Như vậy đã monitor được service http.


<img src="https://image.prntscr.com/image/FvpvwBOdTWWCmAFg4X8Ttw.png">  

### 8. Giám sát server process linux
- Click Manual Checks -> Application Processes & Services -> State and count of processes
<img src="https://image.prntscr.com/image/JDz1M_brQuOJctsWBzRq5g.png"> 

- Tìm kiếm nhanh `State and count of processes`

<img src="https://image.prntscr.com/image/Bxl1ehjkRXuCVIUzn1lb4g.png"> 

- Tạo rule cho việc check service:

<img src="https://image.prntscr.com/image/q3MfBQuTRkCXRPzYKgx35g.png"> 

RULE PROPERTIES: Mô tả chung cho rule
thiết lạp các thông số sao cho phù hợp

<img src="https://image.prntscr.com/image/3ec3VriVSquqofZKns7ASw.png"> 

tiến hành Apply change
- Kết quả đã giám sát được về process httpd.

<img src="https://image.prntscr.com/image/BJKphvvWSc_MPIeXt__XSA.png"> 

### 9. Inventory hardware cho server
#### 9.1 Thao tác trên web check_mk
- Tạo rule Check_MK Hardware/Software-Inventory
Click Check plugins -> Tìm kiếm inventory

<img src="https://image.prntscr.com/image/toGixifOQuW86l9DgnM-dA.png"> 


- Click `Check_MK Hardware/Software-Inventory`

- Click `Do hardware/software inventory`
Bạn có thể tùy chỉnh rule cho folder nào đó hoặc tất cả các host.

Tùy chỉnh các thông tin

<img src="https://image.prntscr.com/image/hVtchuszSVyz7lMtUdx5HA.png"> 

Apply change
<img src="https://image.prntscr.com/image/ViLO0LbkRISb1uFl_zUtmw.png"> 

#### 9.2 Thao tác trên client

Sử dụng local check phía client:
```
wget -O /usr/lib/check_mk_agent/local/mk_inventory  https://mon.cloud365.vn/mon/check_mk/agents/plugins/mk_inventory.linux
chmod +x /usr/lib/check_mk_agent/local/mk_inventory
cd /usr/lib/check_mk_agent/local/
./mk_inventory
```

Lúc này trên giao diện web check_mk sẽ hiển thị nhưng thông số về hardware inventory thu thập được.
<img src="https://image.prntscr.com/image/qK0VhNnPSCS56c5puT6osA.png"> 


<img src="https://image.prntscr.com/image/DaAQmIFoRHa7s8V2JLvd8Q.png">  




### 10. Giám sát dịch vụ MySQL bằng plugin
MySQL là một hệ quản trị cơ sở dữ liệu mã nguồn mở được rất nhiều đơn vị sử dụng. Nó vô cùng quan trọng phục vụ việc đọc ghi dữ liệu cho các ứng dụng khác. Chính vì vậy giám sát MySQL là một việc làm vô cùng cần thiết

#### Cài đặt

##### Bước 1: Cài đặt Checkmk Agent

 Trước tiên bạn cần cài đặt checkmk agent trên máy chủ đang chạy dịch vụ MySQL. Nếu chưa biết cách cài đặt bạn có thể tham khảo [tại đây](https://github.com/thang290298/work-Document/blob/master/firewall/Check_mk/Check-list-checkmk.md#4-c%C3%A0i-%C4%91%E1%BA%B7t-agen-check_mk)

 ##### Bước 2: Cấu hình MySQL

 Bạn cần tạo một user mysql dùng cho việc giám sát

 ```
 MariaDB [(none)]> GRANT ALL PRIVILEGES ON Wordpress.* TO thang@localhost IDENTIFIED BY 'Thangnguyen2020';

 ```

 Khai báo thông tin của user dùng để giám sát vào file mysql.cfg
```
cat <<EOF > /etc/check_mk/mysql.cfg
[client]
user=thang
password=hangnguyen2020
EOF
```
 Thay đổi quyền cho file vừa tạo để chắc chắn rằng nếu không phải user root thì sẽ không được phép sửa file này

 ```
 chmod 400 /etc/check_mk/mysql.cfg
 ```

##### Bước 3: Copy file plugin từ checkmk server sang máy chủ mysql

Truy cập vào checkmk server để copy file plugin giám sát mysql sang bên máy đang chạy mysql

```
scp /opt/omd/versions/1.6.0p18.cee.demo/share/check_mk/agents/plugins/mk_mysql root@103.124.94.180:/usr/lib/check_mk_agent/plugins

```
Trong đó 103.124.94.180 là địa chỉ của máy chạy mysql

##### Bước 4: Thực hiện thêm service trên WATO

Bây giờ truy cập vào Web UI để thực hiện discovery các dịch vụ


<img src="https://image.prntscr.com/image/6vJ7Yt-kR_e8D1KlUN5dMQ.png"> 

Thực hiện discovery để thêm các dịch vụ mới được thêm vào giám sát

<img src="https://image.prntscr.com/image/8LhvnZm_SVOTqQXql58VHg.png"> 

Cập nhật thay đổi

<img src="https://image.prntscr.com/image/BZ5fvaxkS7OZc1tmCVHlUg.png"> 


Ta đã có thể giám sát MySQL trên checkmk

<img src="https://image.prntscr.com/image/YH7CVSUOSGyMgZkScrdlVQ.png"> 



### 11. Monitor TCP port với active checks

“Port” là một thuật ngữ chuyên ngành được sử dụng phổ thông trong network, system nói riêng và hệ thống nói chung. Đối với một dịch vụ được thiết kế chạy trên một port có số hiệu khác nhau. Phân loại port thành 2 loại phổ dựa trên giao thức mà port đó sử dụng là TCP port hay UDP port.

Mỗi dịch vụ sẽ chạy trên một port khác nhau. Chính vì vậy muốn biết dịch vụ có chạy ổn định hay không, có đang hoạt động chính xác cho phép mở kết nối tới client hay không đơn giản là giám sát trạng thái của các port. Bài viết này sẽ hướng dẫn bạn các bước để thiết lập giám sát TCP port sử dụng checkmk.

#### Cài đặt

Trước tiên bạn cần cài agent trên máy muốn giám sát port. Bạn có thể tham khảo các cài đặt agent .

Truy cập vào Web UI để thực hiện các bước tiếp theo trên WATO
   - Chọn 1 để vào mục `Host & Service Parameters`
   - Chọn 2 để vào cấu hình `Active checks`

<img src="https://image.prntscr.com/image/uMU8c6D1SxWTc_mYtACTpA.png"> 


<img src="https://image.prntscr.com/image/rxv1RKvpQxa_AAKLrQskbA.png"> 

- Tạo rule cho thư mục có chứa host và bạn muốn giám sát port.

<img src="https://image.prntscr.com/image/rxv1RKvpQxa_AAKLrQskbA.png"> 


  - Mục 1: Mô tả rule
  - Mục 2: Comment
  - Mục 3: Port muốn check (ở đây tôi check port của mysql 3306)
  - Mục 4: Một số tham số tùy chọn bổ sung
  - Mục 5: Điều kiện áp dụng rule. Bạn có thể xác định rule này được áp dùng cho thư mục nào, những host có tag xác định, những host xác định hoặc áp dụng cho thư mục nhưng bỏ qua một số host xác định. Ở đây tôi để rule này chỉ áp dụng cho Host_01
  - Sau đó chọn 6 để lưu
Một số tham số tùy chọn bổ sung ở mục 4 như sau:

  - Service description: mô tả dịch vụ của port này
  - DNS hostname: sử dụng domain thay vì IP theo mặc định
  - Expected response time: xác đinh thời gian response để xác ddingj trạng thái OK hay Warning hoặc Critical
  - Seconds before connection times out: Xác định thời gian trước khi kết nối times out.
  - State for connection refusal: Trạng thái nếu kết nối bị từ chối
  - Strings to expect in response: Chuỗi mong muốn trong kết quả trả về
  - Maximum number of bytes to receive: Số byte lớn nhất có thể nhận
  - Use SSL for the connection: Sử dụng SSL cho kết nối

<img src="https://image.prntscr.com/image/lCZYs0sRR8qEfheRSAFagg.png"> 


Cập nhật thay đổi

<img src="https://image.prntscr.com/image/BZ5fvaxkS7OZc1tmCVHlUg.png"> 

 Quay trở lại `Host_94.180` ta thấy port `3306` đã được thêm vào giám sát


 <img src="https://image.prntscr.com/image/vg4wxYSgRxqPB189s-KP7g.png"> 

 ### 12. Giám sát Volume group và Logical Volume
 Như agent mặc định của checkmk bạn chỉ có thể giám sát một số thông số như **Disk IO SUMMARY**, **Filesystem /**, **Filesystem /boot** mà bạn ko thể giám sát IO trên từng disk vật lý hay IO trên từng Logical Volume (với LVM).

#### Thêm giám sát IO trên từng disk vật lý và Logical Volume

 * Chọn 1 để vào `Host & Service Parameters`
 * Chọn 2 để vào `Parameters for discovered services`

<img src="https://image.prntscr.com/image/cddY37MmRsmPIpNSFhpqyw.png"> 

Tìm kiếm `Disk` trên thanh tìm kiếm sau đó chọn `Discovary mode for Disk IO check`

<img src="https://image.prntscr.com/image/MhQN52GDSIG8WA7hfP9Kdg.png"> 

 * Chọn 1 để tạo rule

<img src="https://image.prntscr.com/image/wa5RZ9NJQEuMWLBR6V_F9w.png"> 

Khai báo các thông tin cho rule
 
 * Mục 1: Mô tả cho rule
 * Mục 2: Các thông số muốn giám sát
 * Sau đó chọn 3 để lưu

<img src="https://image.prntscr.com/image/6vJ7Yt-kR_e8D1KlUN5dMQ.png"> 

Thực hiện discovery để tìm kiếm những service mới
 * Chọn 1 để vào mục quản lý host
 * Chọn 2 để thực hiện discovery


<img src="https://image.prntscr.com/image/8LhvnZm_SVOTqQXql58VHg.png"> 

Cập nhật thay đổi

<img src="https://image.prntscr.com/image/BZ5fvaxkS7OZc1tmCVHlUg.png"> 


Ta thấy có service mới được tìm thấy

<img src="https://image.prntscr.com/image/ldiVJDgzSd63lxJx8jcDfg.png"> 

Áp dụng những thay đổi

<img src="https://image.prntscr.com/image/BZ5fvaxkS7OZc1tmCVHlUg.png"> 

Bây giờ ta có thể giám sát được I/O của các disk vật lý và Logical Volume

<img src="https://image.prntscr.com/image/AJ-3pNT7RleYBkdTYOjvdg.png"> 

#### Kiểm tra dung lượng của Volume Group

Trên checkmk server copy plugin `lvm` trong đường dẫn `/opt/omd/versions/1.6.0p10.cre/share/check_mk/agents/plugins/lvm` sang thư mục `/usr/lib/check_mk_agent/plugins` bên phía agent

Trên agent ta có thể thực hiện lệnh sau để kiểm tra

```
check_mk_agent
```

Nếu trong kết quả trả về ta thấy có dòng như sau thì plugin đã chạy

```
<<<lvm_vgs>>>
  centos        1       3       0       wz--n-  63346573312     4194304
<<<lvm_lvs:sep(124)>>>
  home|centos|-wi-ao----|20073938944||||||||
  root|centos|-wi-ao----|41120956416||||||||
  swap|centos|-wi-ao----|2147483648||||||||

```

Truy cập vào Web UI để add service

Thực hiện discovery service

<img src="https://image.prntscr.com/image/7lhoKDgyS6KXbq-L9KEMlg.png"> 

<img src="https://image.prntscr.com/image/BZ5fvaxkS7OZc1tmCVHlUg.png"> 

Ta thấy có service đã được add

<img src="https://image.prntscr.com/image/CcDWKqGoSZ_Dds0HVnC9fQ.png"> 

Áp dụng những thay đổi

<img src="https://image.prntscr.com/image/BZ5fvaxkS7OZc1tmCVHlUg.png"> 

Ở đây trên host chỉ có 1 Volume Group và đã được cấp hết dung lượng cho các Logical Volume

<img src="https://image.prntscr.com/image/Fl-sws5vSv6OxHg6OLRpbA.png"> 

### 13. Giám sát apache

#### Thực hiện giám sát trên Centos 7

Bài viết này sẽ hướng dẫn bạn cách dịch vụ httpd trên checkmk. Trước tiên bạn cần cài agent lên máy cần giám sát và add host vào checkmk server.

## Thực hiện tại agent

Trên file cấu hình của apache `/etc/httpd/conf/httpd.conf` thêm vào nội dung sau:

```
<IfModule mod_status.c>
<Location /server-status>
SetHandler server-status
Order deny,allow
Deny from all
Allow from 127.0.0.1 ::1
</Location>
# Keep track of extended status information for each request
ExtendedStatus On
</IfModule>
```

Thực hiện restart lại httpd

```
systemctl restart httpd
```

Kiểm tra 

```
curl http://127.0.0.1/server-status
```

Kết qủa trả về như sau:

```
[root@localhost plugins]# curl http://127.0.0.1/server-status
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html><head>
<title>Apache Status</title>
</head><body>
<h1>Apache Server Status for 127.0.0.1 (via 127.0.0.1)</h1>

<dl><dt>Server Version: Apache/2.4.6 (CentOS)</dt>
<dt>Server MPM: prefork</dt>
<dt>Server Built: Aug  8 2019 11:41:18
</dt></dl><hr /><dl>
<dt>Current Time: Monday, 13-Apr-2020 03:10:36 +07</dt>
<dt>Restart Time: Sunday, 12-Apr-2020 15:56:15 +07</dt>
<dt>Parent Server Config. Generation: 1</dt>
<dt>Parent Server MPM Generation: 0</dt>
<dt>Server uptime:  11 hours 14 minutes 21 seconds</dt>
<dt>Server load: 0.00 0.01 0.05</dt>
<dt>Total accesses: 686 - Total Traffic: 236 kB</dt>
<dt>CPU Usage: u.56 s.21 cu0 cs0 - .0019% CPU load</dt>
<dt>.017 requests/sec - 5 B/second - 352 B/request</dt>
...
```

Cài một số gói cần thiết

```
yum install net-tools
```


Copy file plugin từ checkmk server (/omd/versions/1.6.0p10.cre/share/check_mk/agents/plugins/apache_status) sang thư mục (/usr/lib/check_mk_agent/plugins) trên agent.

Cấp quyền thực thi cho file

```
chmod +x /usr/lib/check_mk_agent/plugins/apache_status
```

Kiểm tra

```
check_mk_agent | grep -A apache_status
```

Nếu thấy kết quả trả về như sau thì agent đã check thành công

```
<<<apache_status:sep(124)>>>
[::1]|80||Total Accesses: 13
[::1]|80||Total kBytes: 161
[::1]|80||CPULoad: .154891
[::1]|80||Uptime: 368
[::1]|80||ReqPerSec: .0353261
[::1]|80||BytesPerSec: 448
[::1]|80||BytesPerReq: 12681.8
[::1]|80||BusyWorkers: 1
[::1]|80||IdleWorkers: 5
[::1]|80||Scoreboard: W_____
```

## Cấu hình trên WATO

Thao tác trên web

<img src="https://image.prntscr.com/image/7lhoKDgyS6KXbq-L9KEMlg.png"> 



Chọn 1 để vào danh sách các host
Chọn 2 để thực hiện tìm kiếm các host và service mới

Start discovery

<img src="https://image.prntscr.com/image/BZ5fvaxkS7OZc1tmCVHlUg.png"> 

Ta thấy có 9 service đã được add

<img src="https://image.prntscr.com/image/8bxZ_trXT16p5nVPUil0Ng.png"> 

Áp dụng thay đổi

<img src="https://image.prntscr.com/image/BZ5fvaxkS7OZc1tmCVHlUg.png"> 

Ta thấy service mới được add

<img src="https://image.prntscr.com/image/vROt03fSRdOA4JvsPOiWRw.png"> 

Đợi để agent gửi thông tin về. Ta thấy dịc vụ vừa add đã có dữ liệu


## Thực hiện trên Ubuntu 18

Thực hiện trên Ubuntu tương tự. Chỉ khác ở chỗ sửa file `/etc/apache2/apache2.conf` thay vì `/etc/httpd/conf/httpd.conf` như trên Centos.

Nội dung

```
<IfModule mod_status.c>
<Location /server-status>
SetHandler server-status
Order deny,allow
Deny from all
Allow from 127.0.0.1 ::1
</Location>
# Keep track of extended status information for each request
ExtendedStatus On
</IfModule>
```

Sửa file `/etc/apache2/mods-enabled/status.conf`

Sửa dòng `#Require ip 127.0.0.1/8` thành `Require ip 127.0.0.1/8`

![Imgur](https://i.imgur.com/ABhcr0h.png)

Thực hiện restart lại apache2 

    systemctl restart apache2

Kiểm tra:

    curl http://127.0.0.1/server-status

Kết quả đúng như sau:

```
root@hostu18test:~# curl http://127.0.0.1/server-status
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html><head>
<title>Apache Status</title>
</head><body>
<h1>Apache Server Status for 127.0.0.1 (via 127.0.0.1)</h1>

<dl><dt>Server Version: Apache/2.4.29 (Ubuntu)</dt>
<dt>Server MPM: prefork</dt>
<dt>Server Built: 2020-03-13T12:26:16
</dt></dl><hr /><dl>
<dt>Current Time: Monday, 27-Jul-2020 02:42:22 UTC</dt>
<dt>Restart Time: Monday, 27-Jul-2020 02:30:22 UTC</dt>
<dt>Parent Server Config. Generation: 1</dt>
<dt>Parent Server MPM Generation: 0</dt>
<dt>Server uptime:  12 minutes</dt>
<dt>Server load: 0.00 0.02 0.00</dt>
<dt>Total accesses: 20 - Total Traffic: 32 kB</dt>
<dt>CPU Usage: u.02 s.01 cu0 cs0 - .00417% CPU load</dt>
<dt>.0278 requests/sec - 45 B/second - 1638 B/request</dt>
<dt>1 requests currently being processed, 5 idle workers</dt>
</dl><pre>W_____..........................................................
................................................................
......................</pre>
<p>Scoreboard Key:<br />
"<b><code>_</code></b>" Waiting for Connection,
"<b><code>S</code></b>" Starting up,
"<b><code>R</code></b>" Reading Request,<br />
"<b><code>W</code></b>" Sending Reply,
...
```

Cài một số gói cần thiết

    yum install net-tools

Copy file plugin từ checkmk server `/omd/versions/1.6.0p13.cre/share/check_mk/agents/plugins/apache_status` sang thư mục `/usr/lib/check_mk_agent/plugins` trên agent.

    scp /omd/versions/1.6.0p13.cre/share/check_mk/agents/plugins/apache_status root@10.10.10.115:/usr/lib/check_mk_agent/plugins

**Cài python** (Plugin được viết bằng python. Trên Centos đã có sẵn python nên không cần cài. Ubuntu không có sẵn python)

    apt -y install python

Cấp quyền thực thi cho file

chmod +x /usr/lib/check_mk_agent/plugins/apache_status

Lệnh kiểm tra:

    check_mk_agent | grep -A 3 apache_status

![Imgur](https://i.imgur.com/3x8xNnF.png)

Kết quả có cách dòng như ở dưới tức là đã thực hiện đúng

```
<<<apache_status:sep(124)>>>
[::1]|80||::1
[::1]|80||ServerVersion: Apache/2.4.29 (Ubuntu)
[::1]|80||ServerMPM: prefork
```

Sau đó trên WATO ta thực hiện Discovery đối với thư mục chứa host này (hoặc chỉ đối với host này)

Kết quả:


![Imgur](https://i.imgur.com/PibhQdU.png)

### 14. Cài đặt plugin uname



Hướng dẫn: https://github.com/niemdinhtrong/thuctapsinh/blob/master/NiemDT/Ghichep_checkmk/docs/11.Cai-plugin-mkp.md

Kết quả:

<img src="https://image.prntscr.com/image/5K-WGndaSd_Yla0v7q-BMg.png"> 


### 15. Sử dụng plugin kiểm tra sự thay đổi của file

Hướng dẫn:

https://github.com/niemdinhtrong/thuctapsinh/blob/master/NiemDT/Ghichep_checkmk/docs/13.Huong-dan-su-dung-plugin-check-file-thay-doi.md

Nội dung file `check_file_md5.py`

```
#!/usr/bin/python
import hashlib
import ast

# Khai bao cac file can kiem tra 
# Vi du nhu sau FILES = ['/root/file1.txt', '/etc/passwd']
FILES = []

try:
    r_file = open('/tmp/checkmk_md5')
    value = r_file.read()
    value_md5 = ast.literal_eval(value)
except:
    value_md5 = {}

def check_file(name_f):
    try:
        a_file = open(name_f)
        content = a_file.read()
        md5 = hashlib.md5(content.encode()).hexdigest()
        return md5
    except:
        return 0

for file_c in FILES:
    md5 = check_file(file_c)
    try:
        value_md5[file_c]
    except:
        # kiem tra lan dau tien
        md5_change = {file_c:md5}
        value_md5.update(md5_change)

    if md5 == 0:
        status = 2
        statustxt = "CRITICAL: File not found"
        md5_change = {file_c:md5}
        value_md5.update(md5_change)

    elif md5 == value_md5[file_c]:
        status = 0
        statustxt = "OK"
    else:
        status = 2
        statustxt = "CRITICAL: File changes"
        md5_change = {file_c:md5}
        value_md5.update(md5_change)
    print('{} File_md5:{} - {} status {}'.format(status, file_c, file_c, statustxt))

file_w = open('/tmp/checkmk_md5', 'w')
file_w.write(str(value_md5))
file_w.close()
```

Kết quả:

<img src="https://image.prntscr.com/image/qINZiY5yRq2Kf-efvGUVKQ.png"> 

### 16. Monitoring process linux bởi check_mk



Hướng dẫn: https://github.com/domanhduy/ghichep/blob/master/DuyDM/Check-MK/thuc-hanh/docs/7.linux-process-monitoring.md

Kết quả:

<img src="https://image.prntscr.com/image/lXZ1CM1JRC2-JB1J-E7QDw.png"> 


# Nguồn tham khảo
https://github.com/domanhduy/ghichep/blob/master/DuyDM/Check-MK/ly-thuyet/Ly-thuyet-Check-MK.md
https://github.com/domanhduy/ghichep/blob/master/DuyDM/Check-MK/thuc-hanh/docs/1.cai-dat-check-mk-server-centos7.md
https://news.cloud365.vn/huong-dan-add-host-de-check_mk-giam-sat/
https://github.com/domanhduy/ghichep/blob/master/DuyDM/Check-MK/thuc-hanh/docs/3.setup-canh-bao-telegram.md
https://github.com/domanhduy/ghichep/blob/master/DuyDM/Check-MK/thuc-hanh/docs/4.monitor-service-http.md
https://github.com/domanhduy/ghichep/blob/master/DuyDM/Check-MK/thuc-hanh/docs/7.linux-process-monitoring.md
https://github.com/domanhduy/ghichep/blob/master/DuyDM/Check-MK/thuc-hanh/docs/6.add-monitor-inventory-hardware-checkmk.md
https://github.com/datkk06/meditech-ghichep-omd/blob/master/docs/2.Install-agent.md#3