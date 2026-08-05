enum HotspotType { info, navigation }

class HotspotModel {
  final String id;
  final HotspotType type;
  final double latitude;
  final double longitude;
  final String title;
  final String description;
  final String? imageUrl;
  final String? targetSceneId;

  HotspotModel({
    required this.id,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.title,
    this.description = '',
    this.imageUrl,
    this.targetSceneId,
  });

  factory HotspotModel.fromJson(Map<String, dynamic> json) {
    return HotspotModel(
      id: json['id'] as String,
      type: (json['type'] as String).toUpperCase() == 'NAVIGATION'
          ? HotspotType.navigation
          : HotspotType.info,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      targetSceneId: json['targetSceneId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type == HotspotType.navigation ? 'NAVIGATION' : 'INFO',
      'latitude': latitude,
      'longitude': longitude,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'targetSceneId': targetSceneId,
    };
  }
}
