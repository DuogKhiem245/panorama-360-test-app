import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:panorama_360_test_app/models/scene_model.dart';
import 'package:panorama_360_test_app/providers/scene_provider.dart';
import 'package:panorama_360_test_app/screens/panorama_page/widgets/control_toolbar.dart';
import 'package:panorama_360_test_app/screens/panorama_page/widgets/hotspot_item.dart';
import 'package:panorama_360_test_app/screens/panorama_page/widgets/topbar.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class PanoramaPageView extends ConsumerStatefulWidget {
  final SceneModel scene;

  const PanoramaPageView({super.key, required this.scene});

  @override
  ConsumerState<PanoramaPageView> createState() => _PanoramaPageViewState();
}

class _PanoramaPageViewState extends ConsumerState<PanoramaPageView>
    with SingleTickerProviderStateMixin {
  double _zoom = 1.0;
  final PanoramaController _controller = PanoramaController();

  late SceneModel _currentScene;
  late AnimationController _transitionController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  bool _isTransitioning = false;
  String _targetSceneTitle = '';

  @override
  void initState() {
    super.initState();
    _currentScene = widget.scene;

    _transitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _transitionController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _transitionController, curve: Curves.easeOut),
    );
  }

  @override
  void didUpdateWidget(covariant PanoramaPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scene.id != widget.scene.id) {
      setState(() {
        _currentScene = widget.scene;
      });
    }
  }

  @override
  void dispose() {
    _transitionController.dispose();
    super.dispose();
  }

  Future<void> _switchToScene(SceneModel nextScene) async {
    if (_isTransitioning || _currentScene.id == nextScene.id) return;

    setState(() {
      _isTransitioning = true;
      _targetSceneTitle = nextScene.title;
    });

    await _transitionController.forward();

    setState(() {
      _currentScene = nextScene;
      _zoom = 1.0;
    });

    await Future.delayed(const Duration(milliseconds: 100));

    await _transitionController.reverse();

    if (mounted) {
      setState(() {
        _isTransitioning = false;
      });
    }
  }

  void _onNavigateToSceneId(String targetSceneId, List<SceneModel> scenes) {
    try {
      final targetScene = scenes.firstWhere((s) => s.id == targetSceneId);
      _switchToScene(targetScene);
    } catch (_) {
      if (!mounted) return;
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Thông báo'),
          content: Text('Không tìm thấy không gian đích (ID: $targetSceneId)'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scenesAsync = ref.watch(scenesProvider);
    final allScenes = scenesAsync.value ?? [_currentScene];
    final connectedScenes = _currentScene.connectedSpaces.isEmpty
        ? allScenes
        : allScenes
              .where((s) => _currentScene.connectedSpaces.contains(s.id))
              .toList();

    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _transitionController,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value.clamp(0.0, 1.0),
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                ),
              );
            },
            child: PanoramaViewer(
              panoramaController: _controller,
              zoom: _zoom,
              minZoom: 0.5,
              maxZoom: 5.0,
              animSpeed: 0,
              sensorControl: SensorControl.none,
              hotspots: _currentScene.hotspots.map((hotspot) {
                return Hotspot(
                  latitude: hotspot.latitude,
                  longitude: hotspot.longitude,
                  width: 60.0.w,
                  height: 60.0.h,
                  widget: HotspotItem(
                    hotspot: hotspot,
                    onNavigate: (targetSceneId) =>
                        _onNavigateToSceneId(targetSceneId, allScenes),
                  ),
                );
              }).toList(),
              child: Image.asset(
                _currentScene.panoramaImagePath,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Text(
                    'Không thể tải ảnh Panorama',
                    style: TextStyle(
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color,
                    ),
                  ),
                ),
              ),
            ),
          ),

          TopBar(scene: _currentScene),

          Positioned(
            bottom: 30.h,
            left: 0,
            right: 0,
            child: Center(
              child: ControlToolbar(
                // currentZoom: _zoom,
                // onZoomIn: () {
                //   setState(() {
                //     _zoom = (_zoom + 0.5).clamp(1.0, 5.0);
                //     _controller.setZoom(_zoom);
                //   });
                // },
                // onZoomOut: () {
                //   setState(() {
                //     _zoom = (_zoom - 0.5).clamp(1.0, 5.0);
                //     _controller.setZoom(_zoom);
                //   });
                // },
                onResetView: () {
                  _controller.setZoom(1.0);
                  setState(() {
                    _zoom = 1.0;
                  });
                },
                currentSceneId: _currentScene.id,
                availableScenes: connectedScenes,
                onSelectScene: (nextScene) {
                  _switchToScene(nextScene);
                },
              ),
            ),
          ),

          if (_isTransitioning)
            IgnorePointer(
              child: Container(
                color: CupertinoColors.black.withValues(alpha: 0.3),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.black.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: CupertinoColors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CupertinoActivityIndicator(
                          radius: 14.r,
                          color: CupertinoColors.white,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Đang di chuyển tới...',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 13.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          _targetSceneTitle,
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
