1. Quá trình nghiên cứu

* Vấn đề đã nghiên cứu:
  - Tìm hiểu khái niệm Hotspot và cơ chế gắn tọa độ latitude / longitude trong môi trường ảnh 360°
  - Khảo sát các thư viện hỗ trợ hiển thị Panorama 360° (flutter_scene, panorama_viewer)
  - Khảo sát thư viện tối ưu và hiển thị hình ảnh (extended_image)
  - Khảo sát giải pháp quản lý trạng thái (flutter_riverpod).

* Tài liệu đã tham khảo:
  - Hotspot: AI Tools (Gemini, Chat GPT)
  - Các thư viện: flutter_scene (https://pub.dev/packages/flutter_scene, ), panorama_viewer (https://pub.dev/packages/panorama_viewer), extended_image (https://pub.dev/packages/extended_image), flutter_riverpod (https://pub.dev/packages/flutter_riverpod)

2. Giải pháp lựa chọn

- Thư viện core (panorama_viewer): Nhẹ, tương thích tốt với Flutter, hỗ trợ render ảnh Equirectangular và gắn các Hotspots theo tọa độ latitude/longitude.
- Thư viện hiển thị ảnh (extended_image): Tối ưu việc tải, nén và lưu cache hình ảnh Panorama/Thumbnail, giúp tránh tràn bộ nhớ RAM và tăng hiệu năng hiển thị.
- Kiến trúc UI (Cupertino Style): Thiết kế giao diện kiểu iOS (CupertinoTheme) vì tôi thường hay code theo kiểu đó và chạy trên máy thật

3. Ưu nhược điểm

* Ưu điểm:
  - Giao diện đồng bộ & Hiện đại: Sử dụng chuẩn thiết kế Cupertino chỉn chu, thân thiện trên thiết bị di động.
  - Kiến trúc mô-đun hóa sạch sẽ & Dễ bảo trì: Phân tách giao diện và các thành phần rõ ràng (ControlToolbar, HotspotItem, TopBar), kết hợp với Riverpod quản lý state giúp luồng dữ liệu minh bạch, dễ mở rộng.
  - Tối ưu hiệu năng & Quản lý bộ nhớ: Tích hợp extended_image để quản lý cache và tối ưu nén hình ảnh Panorama độ phân giải cao, hạn chế tình trạng giật lag hoặc tràn bộ nhớ.
  - Tương tác linh hoạt: Hỗ trợ đầy đủ các thao tác điều khiển góc nhìn (Zoom in/out, Reset camera view, Toggle hiển thị Hotspot) và tương tác mượt mà tại các điểm Hotspot.

* Nhược điểm:
  - Phụ thuộc vào thư viện panorama_viewer: Giới hạn khả năng tùy biến sâu các hiệu ứng 3D nâng cao (như Mesh 3D, Shader, hiệu ứng ánh sáng) so với việc dựng Engine 3D riêng.

4. Hướng phát triển

Nếu có thêm thời gian, dự án sẽ phát triển mở rộng thêm các tính năng sau:
- Tích hợp Cảm biến Chuyển động: Cho phép người dùng điều khiển góc nhìn 360° tự nhiên bằng thao tác xoay nghiêng thiết bị.
- Hệ thống Quản lý Dữ liệu Động (Backend & CMS Integration): Xây dựng API và giao diện quản trị để thêm/sửa/xóa cảnh Panorama, vị trí Hotspot và nội dung liên quan trực tiếp từ Server.
- Đa dạng hóa Nội dung Hotspot: Hỗ trợ hiển thị Popup chứa Video thuyết minh, Audio Guide, Gallery ảnh chi tiết hoặc thông tin tương tác đa phương tiện tại từng vị trí Hotspot.
- Hỗ trợ Chế độ Thực tế Ảo (VR Mode): Tích hợp chế độ chia đôi màn hình (Stereoscopic Mode) cho phép trải nghiệm qua kính VR.