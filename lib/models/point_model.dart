import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Модель точки; сделал кастомную, т.к. у стандартной нет метода toJson
class PointModel {
  /// Широта
  final double latitude;

  /// Долгота
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

  /// Возвращает Point
  Point toPoint() {
    return Point(
      latitude: latitude,
      longitude: longitude,
    );
  }

  factory PointModel.fromJson(Map<dynamic, dynamic> json) {
    return PointModel(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }
}
