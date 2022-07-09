import 'dart:async';
import 'dart:math';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:map_draw/sections/map/map_screen.dart';
import 'package:map_draw/sections/map/services/camera_controller.dart';
import 'package:map_draw/sections/map/services/cluster_drawer.dart';
import 'package:map_draw/sections/map/services/point_drawer.dart';
import 'package:map_draw/sections/map/services/user_position_service.dart';
import 'package:map_draw/sections/map/wm/map_screen_model.dart';
import 'package:map_draw/theme/styles.dart';
import 'package:map_draw/widgets/notifications/notification_methods.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreenWM extends WidgetModel<MapScreen, MapScreenModel> {
  YandexMapController? controller;

  ListenableState<List<MapObject>> get streamedMapObjects =>
      model.streamedMapObjects;

  void Function(int object)? onPlacemarkPressed;
  void Function(Exception exception)? onGetUserPositionError;

  final MapObjectId userMapId = const MapObjectId(
    'user',
  );

  final MapObjectId clusterMapId = const MapObjectId(
    'cluster',
  );

  final clusterColor = Colors.blue;
  final clusterTextStyle = AppStyles.h6;

  Random rng = Random();

  Point? userPosition;

  MapScreenWM(super.model);

  void onDeletePressed() {
    showError(context, 'Бабабой');
  }

  //* Обновление списка точек
  Future<void> _updateClusterMapObject(
    List<Point> points, [
    int? indexOfPressedItem,
  ]) async {
    model.streamedMapObjects.accept(
      streamedMapObjects.value
        ?..removeWhere(
          (obj) => obj.mapId == clusterMapId,
        ),
    );

    final placemarkCollection = ClusterizedPlacemarkCollection(
      mapId: clusterMapId,
      radius: 15,
      minZoom: 15,
      onClusterAdded: (
        self,
        cluster,
      ) async {
        return cluster.copyWith(
          appearance: cluster.appearance.copyWith(
            opacity: 0.75,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromBytes(
                  await ClusterDrawer.buildClusterAppearance(
                    cluster,
                    clusterColor: clusterColor,
                    clusterTextStyle: clusterTextStyle,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      onClusterTap: (self, cluster) =>
          CameraController.setCenterOn(cluster.placemarks),
      placemarks: List<PlacemarkMapObject>.generate(
        points.length,
        (i) {
          final rnd = rng.nextInt(200);
          final placemarkId = 'p_${i}_${rnd}_${points[i]}';

          // final itemIsSelected =
          //     indexOfPressedItem != null && i == indexOfPressedItem;

          return PlacemarkMapObject(
            onTap: (placemark, point) {
              // indexOfPressedItem = i;
              debugPrint(indexOfPressedItem.toString());
              unawaited(_updateClusterMapObject(points, i));
              unawaited(CameraController.moveTo(placemark.point));
              onPlacemarkPressed?.call(i);
            },
            opacity: 1,
            mapId: MapObjectId(placemarkId),
            point: points[i],
          );
        },
      ),
    );

    model.streamedMapObjects.accept(
      [
        ...model.streamedMapObjects.value ?? <MapObject>[],
        placemarkCollection,
      ],
    );
  }

  Future<void> updateUserPosition() async {
    final mapObj = [...model.streamedMapObjects.value ?? <MapObject>[]];
    model.streamedMapObjects.accept(
      mapObj
        ..removeWhere(
          (element) => element.mapId == userMapId,
        ),
    );

    userPosition = await UserPositionGetter.getUserPosition(
      onGetUserPositionError: onGetUserPositionError,
    );

    if (userPosition != null) {
      model.streamedMapObjects.accept(
        [
          ...model.streamedMapObjects.value ?? <MapObject>[],
          PlacemarkMapObject(
            mapId: userMapId,
            point: userPosition!,
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromBytes(
                  await PointDrawer.buildPointAppearance(
                      radius: 20, pointColor: Colors.red),
                ),
              ),
            ),
          ),
        ],
      );

      unawaited(
        CameraController.moveTo(
          userPosition!,
          controller,
        ),
      );
    }
  }
}

MapScreenWM createMapScreenWM(BuildContext _) => MapScreenWM(MapScreenModel());
