# Cảnh báo đăng nhập SSh tới telegram
## 1. Tạo 1 bot Telegram
### Tạo 1 bot telegram
- Trên thanh tìm kiếm của Telegram, tìm đến người dùng BotFather
<img src="https://image.prntscr.com/image/Gf5V8hGQTcm4Aavt7G_R4A.png">
- Chat /newbot với BotFather.
  - Đặt tên cho bot của bạn. Ở đây ví dụ đặt là nvt_ssh_bot.


<img src="https://image.prntscr.com/image/Gf5V8hGQTcm4Aavt7G_R4A.png">

- Sau khi tạo bot thành công sẽ có thông báo về một token cho bot. Ở đây là: 1379195062:AAHGPUQIwyTUJuJWISxLpbV6vRAcs-Kk2EY.

### Thêm bot vào Group
- Ta có thể thêm bot vào bất kỳ group nào ta muốn, ở đây ta sẽ thêm vào một group riêng chuyên gửi cảnh báo SSH Report.
- Chọn Add member -> @nvt_ssh_bot
- Khởi động bot bằng cách chat với bot trong nhóm: Ví dụ /my_id @Nvt273

### Lấy Chat_id
- Để lấy được chat_id, ta sử dụng đường link sau:
  - `https://api.telegram.org/bot[TOKEN]/getUpdates`

Tại ô [TOKEN] chính là Token nhận được khi tạo bot. Ví dụ là: https://api.telegram.org/bot1379195062:AAHGPUQIwyTUJuJWISxLpbV6vRAcs-Kk2EY/getUpdates

Lúc này kết quả sẽ hiện ra, ta tìm đến đoạn "chat":{"id":xxxxxxxxx,"is_bot":false. Chat_id của bạn chính là chuỗi kí tự xxxxxxxxx.

```
{"ok":true,"result":[{"update_id":272456292,
"message":{"message_id":3,"from":{"id":1107771830,"is_bot":false,"first_name":"viet","last_name":"thang","language_code":"vi"},"chat":{"id":-348651357,"title":"ssh-report","type":"group","all_members_are_administrators":true},"date":1599715225,"group_chat_created":true}},{"update_id":272456293,
"message":{"message_id":4,"from":{"id":1107771830,"is_bot":false,"first_name":"viet","last_name":"thang","language_code":"vi"},"chat":{"id":-348651357,"title":"ssh-report","type":"group","all_members_are_administrators":true},"date":1599715284,"text":"/my_id @nvt_ssh_bot","entities":[{"offset":0,"length":6,"type":"bot_command"},{"offset":7,"length":12,"type":"mention"}]}},{"update_id":272456294,

```