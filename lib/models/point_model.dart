class PointModel {
  final double latitude;

  final double longitude;

  PointModel({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory PointModel.fromJson(Map<dynamic, dynamic> json) {
    return PointModel(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }
}
