# Template và Snapshot trong KVM

## 1. Template

- Template là một dạng file image pre-configured của hệ điều hành được dùng để tạo nhanh các máy ảo. Sử dụng template sẽ khiến bạn tránh khỏi những bước cài đặt lặp đi lặp lại và tiết kiệm thời gian rất nhiều so với việc cài bằng tay từng bước một.
- Giả sử bạn có 4 máy Apache web server. Thông thường, bạn sẽ phải cài 4 máy ảo rồi lần lượt cài hệ điều hành cho từng máy, sau đó lại tiếp tục tiến hành cài đặt dịch vụ hoặc phần mềm. Điều này tốn rất nhiều thời gian và template sẽ giúp bạn giải quyến vấn đề này.
- Hình dưới đây mô tả các bước mà bạn phải thực hiện theo ví dụ trên nếu bạn cài bằng tay. Rõ ràng từ bước 2-5 chỉ là những tasks lặp đi lặp lại và nó sẽ tiêu tốn rất nhiều thời gian không cần thiết.

![]( ../../images/tmp1.png)

- Với việc sử dụng template, số bước mà người dùng phải thực hiện sẽ được rút ngắn đi rất nhiều, chỉ cần thực hiện 1 lần các bước từ 1-5 rồi tạo template là bạn đã có thể triển khai 4 web servers còn lại một cách rất dễ dàng. Điều này sẽ giúp người dùng tiết kiệm rất nhiều thời gian:

![]( ../../images/tmp2.png)


## 2. Snapshot


- Snapshot là trạng thái của hệ thống ở một thời điểm nhất định, nó sẽ lưu lại cả những cài đặt và dữ liệu. Với snapshot, bạn có thể quay trở lại trạng thái của máy ảo ở một thời điểm nào đó rất dễ dàng.


- libvirt hỗ trợ việc tạo snapshot khi máy ảo đang chạy. Mặc dù vậy, nếu máy ảo của bạn đang chạy ứng dụng thì tốt hơn hết hãy tắt hoặc suspend trước khi tiến hành tạo snapshot.

Có 2 loại snapshot chính được hỗ trợ bởi libvirt:

  - Internal: Trước và sau khi tạo snapshot, dữ liệu chỉ được lưu trên một ổ đĩa duy nhất. Người dùng có thể tạo internal snapshot bằng công cụ virt-manager. Mặc dù vậy, nó vẫn có 1 vài hạn chế:

    - Chỉ hỗ trợ duy nhất định dạng qcow2

    - VM sẽ bị ngưng lại khi tiến hành snapshot

    - Không hoạt động với LVM storage pools

  - External: Dựa theo cơ chế copy-on-write. Khi snapshot được tạo, ổ đĩa ban đầu sẽ có trạng thái “read-only” và có một ổ đĩa khác chồng lên để lưu dữ liệu mới:

- Ổ đĩa được chồng lên được tạo ra có định dạng qcow2, hoàn toàn trống và nó có thể chứa lượng dữ diệu giống như ổ đĩa ban đầu. External snapshot có thể được tạo với bất kì định dạng ổ đĩa nào mà libvirt hỗ trợ. Tuy nhiên không có công cụ đồ họa nào hỗ trợ cho việc này.


![]( ../../images/snapshot1.png)
