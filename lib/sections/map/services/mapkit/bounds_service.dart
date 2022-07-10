import 'dart:math';

import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Сервис для вычисления границ области, в котрой находятся все заданные точки
class BoundsService {
  static BoundingBox getBounds(List<Point> points) {
    final lngs = points.map<double>((m) => m.longitude).toList();
    final lats = points.map<double>((m) => m.latitude).toList();

    final highestLat = lats.reduce(max);
    final highestLng = lngs.reduce(max);
    final lowestLat = lats.reduce(min);
    final lowestLng = lngs.reduce(min);

    final offset = _calcBoundsOffset(
      highestLat,
      highestLng,
      lowestLat,
      lowestLng,
    );

    return BoundingBox(
      northEast:
          Point(latitude: highestLat + offset, longitude: highestLng + offset),
      southWest:
          Point(latitude: lowestLat - offset, longitude: lowestLng - offset),
    );
  }

  static double _calcBoundsOffset(
    double highestLat,
    double highestLng,
    double lowestLat,
    double lowestLng,
  ) {
    final distance = sqrt(
      pow(lowestLat - highestLat, 2) + pow(lowestLng - highestLng, 2),
    );

    // От 0.001 до 1
    return max(
      min(distance / 10, 1),
      0.001,
    );
  }
}
