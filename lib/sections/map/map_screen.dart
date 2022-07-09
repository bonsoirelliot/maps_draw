import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:map_draw/sections/map/widgets/map_buttons.dart';
import 'package:map_draw/sections/map/wm/map_screen_wm.dart';
import 'package:map_draw/static/static_data.dart';
import 'package:map_draw/widgets/notifications/notification_methods.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends ElementaryWidget<MapScreenWM> {
  const MapScreen({Key? key})
      : super(
          createMapScreenWM,
          key: key,
        );

  @override
  Widget build(MapScreenWM wm) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.centerRight,
        children: [
          StateNotifierBuilder<List<MapObject>>(
              listenableState: wm.streamedMapObjects,
              builder: (context, mapObjects) {
                return YandexMap(
                  mapObjects: mapObjects ?? [],
                  onMapCreated: (yandexMapController) {
                    // onMapCreated?.call(yandexMapController);
                    wm
                      ..controller = yandexMapController
                      ..onGetUserPositionError = (ex) {
                        showError(
                          context,
                          ex.toString(),
                        );
                      }
                      ..updateUserPosition();
                    // ..onPlacemarkPressed = onPlacemarkPressed
                    // ..init();
                  },
                );
              }),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: StaticData.defaultPadding,
            ),
            child: MapButtons(
              onUserPositionPressed: wm.updateUserPosition,
              onDeletePressed: wm.onDeletePressed,
            ),
          ),
        ],
      ),
    );
  }
}
