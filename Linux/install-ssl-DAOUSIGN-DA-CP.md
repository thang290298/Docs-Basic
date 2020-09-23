# hướng dẫn cài đặt SSL DAOUSIGN trên DirectAdmin và CPanel
# Mục Lục
## I. Cài đặt
### 1. Cài Đặt trên DA
- Sau khi đăng kí dịch vụ SSL miễn phí tiến hành Download file cài đặt chứng chỉ

<img src="https://image.prntscr.com/image/wFuNzPBaSS_oVXN0Rk_WgA.png">
  
  - tiến hành giải nén thư mục:

  <img src="https://image.prntscr.com/image/YeKX9eBjRUu7SdWHxdoUIQ.png">    

  sau khi giải nén thư mục nhận được 3 file có chứa key SSL:

- `Login ` DA với tài khoản có chứa tên miền đã đăng ký dịch vụ:
   - Vào phần ` SSL Certificates  ` tiến hành tích chọn ` Paste a pre-generated certificate and key`
   - coppy nội dung chứa trong 2 file chứng chỉ  : `Privatekey` và `jaeger292_xyz_cert.pem`


  <img src="https://image.prntscr.com/image/zyF105RQTC6CV8Fjq6GEtQ.png"> 

  - Sau khi hiển thị chứng chỉ chọn `Save `
  - tiếp tục ` Click here` 

  <img src="https://image.prntscr.com/image/wi2myecQQuWVoVOiDk1DNQ.png"> 

  - ở đây coppy nội dung file `jaeger292_xyz_cert.pem` tích chọn ` Use a CA Cert` để kích hoat sử dụng chứng chỉ.


  <img src="https://image.prntscr.com/image/6-J4VNcVRjyZuobFQ_FkeA.png"> 

  - tích chọn `Force SSL with https redirect` rồi lưu lại để điều hướng `http` sang `https`

<img src="https://image.prntscr.com/image/Og_k1tZfRDi1GfDLt2H9-Q.png"> 

  kiểm tra kết  quả: 

<img src="https://image.prntscr.com/image/zw7iPKpTTLCBlxq6z7v3Nw.png"> 



### 2. Cài Đặt trên Cpanel
- Sau khi đăng ký thành công chứng chỉ tiến hành download file  và  `login` Cpanel vào domain đăng ký chứng chỉ

- ở trang chủ truy cập ` SSL/TLS` chọn `Install and Manage SSL for your site (HTTPS)`

<img src="https://image.prntscr.com/image/1VkxHSVAQKmO6MYqsjrlOw.png"> 


- lựa chọn domain cài đặt chứng chỉ tương ứng



<img src="https://image.prntscr.com/image/RGNSRxA2T2GI2JtUsstQiQ.png">

- tiến hành coppy nội dung từng phần tương ứng trong File download sau khi giải nén vào Cpanel
  - privatekey -> Private Key (KEY)
  - learning365_online_cert.pem -> Certificate: (CRT)
  - Chain_RootCA_Bundle -> Certificate Authority Bundle: (CABUNDLE)

- Tích chọn ` Install Certificate` để cài đặt chứng chỉ
kiểm tra chứng chỉ:


<img src="https://image.prntscr.com/image/LjJQfafEQk2O1jm3OPoK_w.png">

