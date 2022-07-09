import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:map_draw/sections/map/map_screen.dart';
import 'package:map_draw/sections/map/wm/map_screen_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreenWM extends WidgetModel<MapScreen, MapScreenModel> {
  YandexMapController? controller;

  MapScreenWM(super.model);
}

MapScreenWM createMapScreenWM(BuildContext _) => MapScreenWM(MapScreenModel());
