import 'package:map_draw/sections/map/services/mapkit/bounds_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Сервис для работы с камерой
class CameraController {
  static Future<void> setCenterOn<V>(
    List<V> list, [
    YandexMapController? controller,
  ]) async {
    if (list.isEmpty) return;

    await Future<void>.delayed(
      const Duration(
        milliseconds: 200,
      ),
    );

    BoundingBox? bounds;

    if (list is List<Point>) {
      bounds = BoundsService.getBounds(list as List<Point>);
    } else if (list is List<PlacemarkMapObject>) {
      bounds = BoundsService.getBounds(
        (list as List<PlacemarkMapObject>).map((e) => e.point).toList(),
      );
    } else {
      return;
    }

    await Future<void>.delayed(
      const Duration(
        milliseconds: 200,
      ),
      () async => controller?.moveCamera(
        CameraUpdate.newBounds(bounds!),
      ),
    );
  }

  static Future<void> moveTo(
    Point point, [
    YandexMapController? controller,
  ]) async {
    await controller?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 16,
          target: Point(
            latitude: point.latitude - 0.001,
            longitude: point.longitude,
          ),
        ),
      ),
      animation: const MapAnimation(
        duration: 1.0,
      ),
    );
  }
}
