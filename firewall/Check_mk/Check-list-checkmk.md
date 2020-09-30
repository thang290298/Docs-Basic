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

# Nguồn tham khảo
https://github.com/domanhduy/ghichep/blob/master/DuyDM/Check-MK/ly-thuyet/Ly-thuyet-Check-MK.md
https://github.com/domanhduy/ghichep/blob/master/DuyDM/Check-MK/thuc-hanh/docs/1.cai-dat-check-mk-server-centos7.md
https://news.cloud365.vn/huong-dan-add-host-de-check_mk-giam-sat/
https://github.com/domanhduy/ghichep/blob/master/DuyDM/Check-MK/thuc-hanh/docs/3.setup-canh-bao-telegram.md
https://github.com/domanhduy/ghichep/blob/master/DuyDM/Check-MK/thuc-hanh/docs/4.monitor-service-http.md
https://github.com/domanhduy/ghichep/blob/master/DuyDM/Check-MK/thuc-hanh/docs/7.linux-process-monitoring.md
https://github.com/domanhduy/ghichep/blob/master/DuyDM/Check-MK/thuc-hanh/docs/6.add-monitor-inventory-hardware-checkmk.md
https://github.com/datkk06/meditech-ghichep-omd/blob/master/docs/2.Install-agent.md#3