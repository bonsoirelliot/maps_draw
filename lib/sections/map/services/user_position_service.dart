import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Сервис получения геопозиции пользователя
class UserPositionGetter {
  static Future<Point> getUserPosition(
      {Function(Exception)? onGetUserPositionError}) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // onError
      onGetUserPositionError?.call(
        Exception(
          'Невозможно определить местоположение',
        ),
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // onError
        onGetUserPositionError?.call(
          Exception(
            'Невозможно определить местоположение',
          ),
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // onError
      onGetUserPositionError?.call(
        Exception(
          'Невозможно определить местоположение',
        ),
      );
    }

    final position = await Geolocator.getCurrentPosition();

    return Point(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
