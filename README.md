# Panorama 360 Test App

Ứng dụng xem và tương tác với hình ảnh toàn cảnh 360° (Panorama 360° Viewer) được phát triển bằng Flutter.


1. Giới thiệu ngắn về ứng dụng

Ứng dụng di động cho phép người dùng xem và tương tác trực quan với các hình ảnh Panorama 360° dạng Equirectangular. Ứng dụng hỗ trợ xoay camera, thu phóng (zoom), tương tác với các điểm thông tin (Hotspots) trên ảnh để xem thông tin chi tiết hoặc di chuyển linh hoạt giữa các cảnh (scenes) khác nhau. Giao diện được thiết kế theo phong cách iOS Cupertino hiện đại.

2. Quá trình nghiên cứu

- Vấn đề đã nghiên cứu:
  - Tìm hiểu khái niệm Hotspot và cơ chế gắn tọa độ latitude / longitude trong môi trường ảnh 360°
  - Khảo sát các thư viện hỗ trợ hiển thị Panorama 360° (flutter_scene, panorama_viewer): so sánh giữa flutter_scene (hỗ trợ 3D engine/mesh phức tạp) và panorama_viewer (chuyên biệt cho ảnh 360° Equirectangular)
  - Khảo sát thư viện tối ưu và hiển thị hình ảnh (extended_image): so sánh extended_image với Image.asset mặc định để tối ưu hóa bộ nhớ khi xử lý các bức ảnh 360° độ phân giải cao.
  - Khảo sát giải pháp quản lý trạng thái (flutter_riverpod).

- Tài liệu đã tham khảo:
  - Hotspot: AI Tools (Gemini, Chat GPT)
  - Các thư viện: flutter_scene (https://pub.dev/packages/flutter_scene, ), panorama_viewer (https://pub.dev/packages/panorama_viewer), extended_image (https://pub.dev/packages/extended_image), flutter_riverpod (https://pub.dev/packages/flutter_riverpod)

3. Giải pháp lựa chọn

- Thư viện core (panorama_viewer): Nhẹ, hỗ trợ render ảnh Equirectangular và gắn các Hotspots theo tọa độ latitude/longitude.
- Thư viện hiển thị ảnh (extended_image): Tối ưu việc tải, nén và lưu cache hình ảnh Panorama/Thumbnail, giúp tránh tràn bộ nhớ RAM và tăng hiệu năng hiển thị.
- Kiến trúc UI (Cupertino Style): Thiết kế giao diện kiểu iOS (CupertinoTheme) vì tôi thường hay code theo kiểu đó và chạy trên máy thật

4. Các tính năng đã hoàn thành

- Trình xem Panorama 360°:
  - Không sử dụng WebView
  - Có thể xoay ảnh bằng thao tác vuốt
  - Hỗ trợ phóng to/thu nhỏ (Zoom)
  
- Điểm tương tác (Hotspots):
  - Gắn điểm mốc chính xác trên không gian 360° theo tọa độ latitude và longitude
  - Chuyển tiếp mượt mà sang cảnh Panorama khác khi nhấn vào Hotspot liên kết
  - Hiển thị cửa sổ pop-up/bottom sheet thông tin chi tiết của địa điểm khi chọn Hotspot thông tin

- Quản lý dữ liệu dưới dạng Json
- Tối ưu hóa hiệu năng


5. Ưu nhược điểm

- Ưu điểm:
  - Giao diện đồng bộ & Hiện đại: Sử dụng chuẩn thiết kế Cupertino chỉn chu, thân thiện trên thiết bị di động.
  - Kiến trúc mô-đun hóa sạch sẽ & Dễ bảo trì: Phân tách giao diện và các thành phần rõ ràng (ControlToolbar, HotspotItem, TopBar), kết hợp với Riverpod quản lý state giúp luồng dữ liệu minh bạch, dễ mở rộng.
  - Tối ưu hiệu năng & Quản lý bộ nhớ: Tích hợp extended_image để quản lý cache và tối ưu nén hình ảnh Panorama độ phân giải cao, hạn chế tình trạng giật lag hoặc tràn bộ nhớ.
  - Tương tác linh hoạt: Hỗ trợ đầy đủ các thao tác điều khiển góc nhìn (Zoom in/out, Reset camera view, Toggle hiển thị Hotspot) và tương tác mượt mà tại các điểm Hotspot.

- Nhược điểm:
  - Phụ thuộc vào thư viện panorama_viewer: Giới hạn khả năng tùy biến sâu các hiệu ứng 3D nâng cao (như Mesh 3D, Shader, hiệu ứng ánh sáng) so với việc dựng Engine 3D riêng.

6. Hướng phát triển

Nếu có thêm thời gian, dự án sẽ phát triển mở rộng thêm các tính năng sau:
- Tích hợp Cảm biến Chuyển động: Cho phép người dùng điều khiển góc nhìn 360° tự nhiên bằng thao tác xoay nghiêng thiết bị.
- Hệ thống Quản lý Dữ liệu Động (Backend & CMS Integration): Xây dựng API và giao diện quản trị để thêm/sửa/xóa cảnh Panorama, vị trí Hotspot và nội dung liên quan trực tiếp từ Server.
- Đa dạng hóa Nội dung Hotspot: Hỗ trợ hiển thị Popup chứa Video thuyết minh, Audio Guide, Gallery ảnh chi tiết hoặc thông tin tương tác đa phương tiện tại từng vị trí Hotspot.
- Hỗ trợ Chế độ Thực tế Ảo (VR Mode): Tích hợp chế độ chia đôi màn hình (Stereoscopic Mode) cho phép trải nghiệm qua kính VR.