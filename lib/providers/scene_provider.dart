import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panorama_360_test_app/models/scene_model.dart';

// FutureProvider tự động load file JSON bất đồng bộ và quản lý trạng thái Loading/Data/Error
final scenesProvider = FutureProvider<List<SceneModel>>((ref) async {
  final String response = await rootBundle.loadString('assets/data/scenes.json');
  final List<dynamic> data = json.decode(response);

  return data.map((jsonItem) => SceneModel.fromJson(jsonItem)).toList();
});

final featuredSceneProvider = Provider<AsyncValue<SceneModel?>>((ref) {
  final scenesAsync = ref.watch(scenesProvider);
  return scenesAsync.whenData((scenes) {
    if (scenes.isEmpty) return null;
    return scenes.firstWhere(
      (s) => s.isFeatured,
    );
  });
});