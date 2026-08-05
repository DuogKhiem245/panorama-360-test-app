import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:panorama_360_test_app/screens/panorama_page/widgets/control_toolbar.dart';
import 'package:panorama_360_test_app/screens/panorama_page/widgets/hotspot_item.dart';
import 'package:panorama_360_test_app/screens/panorama_page/widgets/topbar.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:panorama_360_test_app/models/scene_model.dart';

class PanoramaPageView extends ConsumerStatefulWidget {
  final SceneModel scene;

  const PanoramaPageView({super.key, required this.scene});

  @override
  ConsumerState<PanoramaPageView> createState() => _PanoramaPageViewState();
}

class _PanoramaPageViewState extends ConsumerState<PanoramaPageView> {
  double _zoom = 2.0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          PanoramaViewer(
            zoom: _zoom,
            minZoom: 1.0,
            maxZoom: 5.0,
            animSpeed: 0,
            sensorControl: SensorControl.none,
            onViewChanged: (longitude, latitude, zoom) {
              _zoom = zoom;
            },
            hotspots: widget.scene.hotspots.map((hotspot) {
              return Hotspot(
                latitude: hotspot.latitude,
                longitude: hotspot.longitude,
                width: 60.0.w,
                height: 60.0.h,
                widget: HotspotItem(hotspot: hotspot),
              );
            }).toList(),
            child: Image.asset(
              widget.scene.panoramaImagePath,
              errorBuilder: (context, error, stackTrace) => Center(
                child: Text(
                  'Không thể tải ảnh Panorama',
                  style: TextStyle(
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                ),
              ),
            ),
          ),

          TopBar(scene: widget.scene),

          Positioned(
            bottom: 30.h,
            left: 0,
            right: 0,
            child: Center(
              child: ControlToolbar(
                currentZoom: _zoom,
                onZoomIn: () {
                  setState(() {
                    _zoom = (_zoom + 0.5).clamp(1.0, 4.0);
                  });
                },
                onZoomOut: () {
                  setState(() {
                    _zoom = (_zoom - 0.5).clamp(1.0, 4.0);
                  });
                },
                onResetView: () {
                  setState(() {
                    _zoom = 2.0;
                  });
                },
                onToggleGyro: () {
                  // Chức năng Gyroscope chưa được triển khai
                },
                currentSceneId: widget.scene.id,
                availableScenes:
                    const [], // Hoặc dùng: ref.watch(allScenesProvider)
                onSelectScene: (nextScene) {
                  // Chuyển sang Scene được chọn
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
