import 'hotspot_model.dart';

class SceneModel {
  final String id;
  final String title;
  final String location;
  final String category;
  final bool isFeatured;
  final String thumbnailUrl;
  final String panoramaImagePath;
  final List<String> connectedSpaces;
  final List<HotspotModel> hotspots;

  SceneModel({
    required this.id,
    required this.title,
    required this.location,
    required this.category,
    this.isFeatured = false,
    required this.thumbnailUrl,
    required this.panoramaImagePath,
    this.connectedSpaces = const [],
    required this.hotspots,
  });

  factory SceneModel.fromJson(Map<String, dynamic> json) {
    return SceneModel(
      id: json['id'] as String,
      title: json['title'] as String,
      location: json['location'] as String? ?? '',
      category: json['category'] as String? ?? 'General',
      isFeatured: json['isFeatured'] as bool? ?? false,
      thumbnailUrl: json['thumbnailUrl'] as String,
      panoramaImagePath: json['panoramaImagePath'] as String,
      connectedSpaces: (json['connected_spaces'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      hotspots: (json['hotspots'] as List<dynamic>?)
              ?.map((item) => HotspotModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'category': category,
      'isFeatured': isFeatured,
      'thumbnailUrl': thumbnailUrl,
      'panoramaImagePath': panoramaImagePath,
      'connected_spaces': connectedSpaces,
      'hotspots': hotspots.map((h) => h.toJson()).toList(),
    };
  }
}