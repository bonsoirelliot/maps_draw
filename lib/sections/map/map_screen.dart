import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:map_draw/sections/map/widgets/map_buttons.dart';
import 'package:map_draw/sections/map/wm/map_screen_wm.dart';
import 'package:map_draw/static/static_data.dart';
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
        children: const [
          YandexMap(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: StaticData.defaultPadding,
            ),
            child: MapButtons(),
          ),
        ],
      ),
    );
  }
}
