// ignore_for_file: unused_element

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:map_draw/models/figure_model.dart';
import 'package:map_draw/models/point_model.dart';
import 'package:map_draw/sections/map/map_screen.dart';
import 'package:map_draw/sections/map/services/mapkit/camera_controller.dart';
import 'package:map_draw/sections/map/services/mapkit/cluster_drawer.dart';
import 'package:map_draw/sections/map/services/mapkit/point_drawer.dart';
import 'package:map_draw/sections/map/services/mapkit/user_position_service.dart';
import 'package:map_draw/sections/map/services/storage/json_reader.dart';

import 'package:map_draw/sections/map/widgets/bottom_sheets/settings_bottom_sheet.dart';
import 'package:map_draw/sections/map/wm/map_screen_model.dart';
import 'package:map_draw/static/static_data.dart';
import 'package:map_draw/theme/styles.dart';
import 'package:map_draw/widgets/notifications/notification_methods.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreenWM extends WidgetModel<MapScreen, MapScreenModel> {
  YandexMapController? controller;

  ListenableState<int> get selectedFigure => model.selectedFigure;

  ListenableState<List<FigureModel>> get streamedFigures =>
      model.streamedFigures;

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

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    loadData();
  }

  void showSettingsBottomSheet() {
    showModalBottomSheet<void>(
      context: Keys.scaffoldKey.currentContext!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      builder: (context) {
        return SettingsBottomSheet(wm: this);
      },
    );
  }

  Future<void> onDeletePressed() async {
    // showError(context, 'Бабабой');
    final models = [
      FigureModel(
        name: 'name',
        lineColor: Colors.white,
        points: [
          PointModel(
            latitude: 58.23332,
            longitude: 58.23332,
          ),
        ],
      ),
    ];
    await JsonReader.writeCounter(models);
  }

  Future<void> onPlusPressed() async {
    try {
      final a = await JsonReader.readFile();

      if (a.isNotEmpty) {
        // ignore: use_build_context_synchronously
        showNotification(context, a.first.points.first.latitude.toString());
      }
    } on FileSystemException catch (e) {
      await JsonReader.writeEmptyFile();
    } on Exception catch (e) {
      showError(context, '$e');
    }
  }

  Future<void> loadData() async {
    try {
      final models = await JsonReader.readFile();
      model.streamedFigures.accept(models);
      selectFigure(0);
    } on FileSystemException catch (e) {
      showError(context, 'Не найден json файл. Будет создан новый json файл');
    } on Exception catch (e) {
      showError(context, '$e');
    }
  }

  void selectFigure(int figure) {
    debugPrint(figure.toString());
    if (model.streamedFigures.value != null &&
        model.streamedFigures.value!.isNotEmpty) {
      _updateClusterMapObject(model.streamedFigures.value![figure].points
          .map((e) => e.toPoint())
          .toList());

      model.selectedFigure.accept(figure);
    }
  }

  void createNewFigure() {
    final figures = [...model.streamedFigures.value ?? <FigureModel>[]];

    final number = figures.length;

    final newFigure = FigureModel(
      name: 'Figure $number',
      lineColor: Colors.white,
      points: [],
    );

    model.streamedFigures.accept(figures..add(newFigure));

    selectFigure(number - 1 > -1 ? number - 1 : number);

    Navigator.of(Keys.scaffoldKey.currentContext!).pop();
    Navigator.of(Keys.scaffoldKey.currentContext!).pop();
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

    final placemarkCollection = await ClusterDrawer.getPlacemarkCollection(
      points: points,
      clusterMapId: clusterMapId,
      clusterColor: clusterColor,
      clusterTextStyle: clusterTextStyle,
    );

    model.streamedMapObjects.accept(
      [
        ...model.streamedMapObjects.value ?? <MapObject>[],
        placemarkCollection,
      ],
    );
  }

  //* Обновление позиции пользователя и навигация к ней
  Future<void> moveToUserPosition() async {
    await _updateUserPosition();

    if (userPosition != null) {
      unawaited(
        CameraController.moveTo(
          userPosition!,
          controller,
        ),
      );
    }
  }

  //* Обновление позиции пользователя
  Future<void> _updateUserPosition() async {
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
    }
  }
}

MapScreenWM createMapScreenWM(BuildContext _) => MapScreenWM(MapScreenModel());
