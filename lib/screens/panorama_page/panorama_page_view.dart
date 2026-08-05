import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vector_math/vector_math.dart' as vector;
import 'package:flutter_scene/scene.dart' hide SceneModel;
import 'package:panorama_360_test_app/models/hotspot_model.dart';
import 'package:panorama_360_test_app/models/scene_model.dart';

class PanoramaPageView extends ConsumerStatefulWidget {
  final SceneModel scene;

  const PanoramaPageView({super.key, required this.scene});

  @override
  ConsumerState<PanoramaPageView> createState() => _PanoramaScreenState();
}

class _PanoramaScreenState extends ConsumerState<PanoramaPageView> {
  late Scene _scene;
  late PerspectiveCamera _camera;
  Node? _sphereNode;

  // Góc quay và Zoom của Camera
  double _yaw = 0.0; // Quay ngang (Yaw)
  double _pitch = 0.0; // Quay dọc (Pitch)
  double _fov = 75.0; // Field of view (Zoom)

  // Vị trí vuốt cũ
  Offset? _lastFocalPoint;

  @override
  void initState() {
    super.initState();
    _init3DScene();
  }

  /// Khởi tạo không gian 3D Scene và tạo Quả cầu Panorama (Inverted Sphere)
  void _init3DScene() {
    _scene = Scene();
    _camera = PerspectiveCamera();

    // Khởi tạo quả cầu 3D đảo ngược mặt (Sphere) từ Model GLTF
    Node.fromGlbAsset('assets/models/inverted_sphere.glb').then((node) {
      _sphereNode = node;
      _scene.add(_sphereNode!);
      if (mounted) setState(() {});
    });

    _updateCamera();
  }

  /// Cập nhật hướng xoay và góc Zoom của Camera
  void _updateCamera() {
    _pitch = _pitch.clamp(-85.0, 85.0);

    final yawRad = vector.radians(_yaw);
    final pitchRad = vector.radians(_pitch);

    // 1. Tính Vector hướng nhìn từ góc Yaw và Pitch
    final lookTarget = vector.Vector3(
      math.cos(pitchRad) * math.sin(yawRad),
      math.sin(pitchRad),
      math.cos(pitchRad) * math.cos(yawRad),
    );

    // 2. Cập nhật vị trí và hướng nhìn cho PerspectiveCamera
    _camera.position = vector.Vector3(0, 0, 0); // Đặt camera ở tâm
    _camera.target = lookTarget; // Nhìn về phía target
    _camera.up = vector.Vector3(0, 1, 0); // Vector hướng lên

    // 3. Cập nhật FOV Y (tính bằng Radian)
    _camera.fovRadiansY = vector.radians(_fov);
  }

  /// Chuyển đổi tọa độ (Latitude, Longitude) của Hotspot sang tọa độ màn hình 2D (Overlay)
  Offset? _calculateHotspotScreenOffset(
    double lat,
    double lng,
    Size screenSize,
  ) {
    final latRad = vector.radians(lat);
    final lngRad = vector.radians(lng);

    // Tọa độ 3D của Hotspot trên bề mặt quả cầu
    final hotspotPos = vector.Vector3(
      math.cos(latRad) * math.sin(lngRad),
      math.sin(latRad),
      math.cos(latRad) * math.cos(lngRad),
    );

    // Tính góc lệch giữa hướng nhìn Camera và Hotspot
    final yawRad = vector.radians(_yaw);
    final pitchRad = vector.radians(_pitch);
    final cameraDir = vector.Vector3(
      math.cos(pitchRad) * math.sin(yawRad),
      math.sin(pitchRad),
      math.cos(pitchRad) * math.cos(yawRad),
    );

    // Nếu Hotspot nằm phía sau lưng Camera -> Ẩn
    if (cameraDir.dot(hotspotPos) <= 0) return null;

    // Chuyển đổi góc lệch tương đối thành điểm 2D Screen Coordinate
    final deltaYaw = vector.degrees(lngRad - yawRad);
    final deltaPitch = vector.degrees(latRad - pitchRad);

    final x = (screenSize.width / 2) + (deltaYaw / _fov) * screenSize.width;
    final y = (screenSize.height / 2) - (deltaPitch / _fov) * screenSize.height;

    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Khung Canvas Render 360 3D & Xử lý Thao tác Cảm ứng (Pan & Zoom)
          GestureDetector(
            onScaleStart: (details) {
              _lastFocalPoint = details.focalPoint;
            },
            onScaleUpdate: (details) {
              setState(() {
                // Xử lý Xoay (Pan)
                if (_lastFocalPoint != null) {
                  final delta = details.focalPoint - _lastFocalPoint!;
                  _yaw -= delta.dx * 0.25;
                  _pitch += delta.dy * 0.25;
                  _lastFocalPoint = details.focalPoint;
                }

                // Xử lý Zoom (Pinch)
                if (details.scale != 1.0) {
                  _fov = (_fov / details.scale).clamp(30.0, 100.0);
                }

                _updateCamera();
              });
            },
            child: SceneView(_scene, camera: _camera),
          ),

          ...widget.scene.hotspots.map((hotspot) {
            final screenPos = _calculateHotspotScreenOffset(
              hotspot.latitude,
              hotspot.longitude,
              screenSize,
            );

            if (screenPos == null) return const SizedBox.shrink();

            return Positioned(
              left: screenPos.dx - 24,
              top: screenPos.dy - 24,
              child: _buildHotspotItem(hotspot),
            );
          }),

          // 3. App Bar Nút Back & Tiêu đề Scene
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            right: 16,
            child: Row(
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Icon(CupertinoIcons.back, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.scene.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 4. Thanh Công cụ Điều khiển Zoom & Reset View
          Positioned(
            right: 16,
            bottom: 40,
            child: Column(
              children: [
                _buildControlButton(
                  icon: CupertinoIcons.add,
                  onTap: () {
                    setState(() {
                      _fov = (_fov - 10).clamp(30.0, 100.0);
                      _updateCamera();
                    });
                  },
                ),
                const SizedBox(height: 10),
                _buildControlButton(
                  icon: CupertinoIcons.minus,
                  onTap: () {
                    setState(() {
                      _fov = (_fov + 10).clamp(30.0, 100.0);
                      _updateCamera();
                    });
                  },
                ),
                const SizedBox(height: 10),
                _buildControlButton(
                  icon: CupertinoIcons.refresh,
                  onTap: () {
                    setState(() {
                      _yaw = 0;
                      _pitch = 0;
                      _fov = 75;
                      _updateCamera();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Item Hotspot hiển thị dạng Pulse Button
  Widget _buildHotspotItem(HotspotModel hotspot) {
    final isNav = hotspot.type == HotspotType.navigation;

    return GestureDetector(
      onTap: () => _onHotspotTap(hotspot),
      child: Tooltip(
        message: hotspot.title,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isNav
                ? const Color(0xFF0088CC).withValues(alpha: 0.85)
                : const Color(0xFF38BDF8).withValues(alpha: 0.85),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color:
                    (isNav ? const Color(0xFF0088CC) : const Color(0xFF38BDF8))
                        .withValues(alpha: 0.6),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            isNav
                ? CupertinoIcons.arrow_right_arrow_left
                : CupertinoIcons.info_circle_fill,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }

  /// Nút tròn điều khiển UI
  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      color: Colors.black54,
      borderRadius: BorderRadius.circular(25),
      onPressed: onTap,
      child: SizedBox(
        width: 44,
        height: 44,
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  /// Xử lý sự kiện khi nhấp vào Hotspot
  void _onHotspotTap(HotspotModel hotspot) {
    if (hotspot.type == HotspotType.info) {
      // Hiển thị Pop-up thông tin dạng Modal BottomSheet
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: Text(
            hotspot.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          message: Text(hotspot.description),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            ),
          ],
        ),
      );
    } else if (hotspot.type == HotspotType.navigation) {
      // Chuyển sang Scene khác nếu là Navigation Hotspot
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Chuyển hướng không gian sang: ${hotspot.targetSceneId}',
          ),
        ),
      );
    }
  }
}
