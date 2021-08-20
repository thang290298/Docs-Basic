# Hướng dẫn sử dụng webvirtcloud
## I. Tạo Account và change pass
### 1. Tạo mới account 

- Click vào dấu `+`:
<img src="../Images/webvirt/5.png">

- Điền thông tịn `account` và `password` sau đó click `Create` để tạo mới tài khoản 
<img src="../Images/webvirt/6.png">

- Kết quả: 
<img src="../Images/webvirt/7.png">

### 2. Thay đổi mật khẩu và Quota cho user

- Đối với tài khoản admin sau khi cài đặt sẽ có mật khẩu defaul là `admin` nên cần phải thay đổi để nâng cao tính bảo mật, ngoài ra có thể thay đổi `quota` đối với mỗi `user` để cấp phát tài nguyên được phép sử dụng. Để `edit user chọn vào biểu tượng bánh răng cưa:
<img src="../Images/webvirt/8.png">


  <img src="../Images/webvirt/9.png">
Trong đó: 

```
 - Name: Tên tài khoản user
 - Password: Nhập mật khẩu mới nếu cần thay đổi
 - Is staff: quyền user thường
 - Is superuser : quyền user admin
 - Can clone instances: cho phép coppy các phiên bản VM
 - Max instances: số VM tạo tối đa
 - Max cpus: Số CPU cấp tối đa
 - Max memory (MB): Số ram có thể sử dụng
 - Max disk size (GB): Tổng dung lượng disk có thể sử dụng
```

### 2. Tạo Storage Pool
Tiến hành tạo Pool đẻ lưu các `Volume` và `ISO` cho các VM
- Vào `Computers` và chọn `Note Computes` muốn tạo `Pool`
<img src="../Images/webvirt/10.png">

- Chọn `Storage` sau đó Click dấu `+`:
<img src="../Images/webvirt/11.png">

- Điền thông tin và tạo `Pool`:
<img src="../Images/webvirt/12.png">

- Tạo đường dẫn lưu `ISO`
<img src="../Images/webvirt/13.png">

- Sau khi tạo xong `Pool`
<img src="../Images/webvirt/14.png">

### 3. Tạo Network

- Chọn `Networks` click `+` và điền thông tin dải mạng :
<img src="../Images/webvirt/15.png">

### 4. Add VM cho user thường

Đối với tài khoản `admin` và các tài khoản `superuser` có quyền gán VM thuộc tất cả các node Computer vào user người dùng bất kỳ. User đó sẽ có quyền quản lý và sử dụng.

- Để gán `VM` cho `User` ta chọn : User rồi vào user cần add VM
<img src="../Images/webvirt/16.png">

- Chọn `+` và tiến hành add `VM`:
<img src="../Images/webvirt/17.png">

- Phân quyền user đối với VM:
<img src="../Images/webvirt/18.png">

### 3. Tạo VM
Bước 1: Tạo 1 storage để chạy VM. 
- Chúng ta chọn `Computer` 

![](../Images/create-image-ubuntu1604/Computer.png)

- Tại giao diện `kvm124` ta chọn phần `storages` sau đó chọn phân vùng tạo VM.

![](../Images/create-image-ubuntu1604/storages.png)

- Click chọn biểu tượng `+ `để thêm Volume: 

![](../Images/create-image-ubuntu1604/add-storage.png)

- Tiến hành đặt tên, chọn định dạng và chọn dung lượng cho VM. Sau khi hoàn thành bấm chọn `Create` để tạo Storage cho VM.

![](../Images/create-image-ubuntu1604/create-storage.png)

- Thông báo sau khi hoàn thành: 

![](../Images/create-image-ubuntu1604/create-ok.png)

Bước 2: Tạo VM

- Vào ` Instances` tích vào dấu `+` để tạo mới VM

![](../Images/create-image-ubuntu1604/new-instances.png)

- Chọn ` Custom ` hoặc những mấu có sắm

![](../Images/create-image-ubuntu1604/customer.png)

- Tiến hành đặt ` teen`, chọn cấu hình `CPU` và `Ram`.

![](../Images/create-image-ubuntu1604/info-instance.png)

- Tại phần HDD, ta chọn volume đã tạo ở trên để tạo VM. Ở đây chọn vào `Storage` đã tạo trước đó ở bước 1:

![](../Images/create-image-ubuntu1604/add-hdd.png)

- Chọn Network. Rồi click `Create`

![](../Images/create-image-ubuntu1604/add-network-and-create.png)

Bước 3: Sau khi thành công sẽ hiển thị giao diện bên dưới. Chọn `Setting`

![](../Images/create-image-ubuntu1604/setting.png)

- Tiếp theo tiến hành chọn `Disk` và file `ISO` để tiến hành `Mount` và cài đặt `OS`

![](../Images/create-image-ubuntu1604/mount-iso.png)

- Sang mục `Boot`. Tại mục `Boot Order`, ta sẽ chọn 2 phần `vda`, `hda`rồi click `Apply`

![](../Images/create-image-ubuntu1604/boot.png)

