import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:map_draw/models/color_model.dart';
import 'package:map_draw/models/figure_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreenModel extends ElementaryModel {
  final streamedMapObjects = StateNotifier<List<MapObject>>();

  final streamedFigures = StateNotifier<List<FigureModel>>();

  final streamedColors = StateNotifier<List<ColorModel>>(
    initValue: [
      ColorModel(name: 'Синий', color: Colors.blue),
      ColorModel(name: 'Красный', color: Colors.red),
      ColorModel(name: 'Желтый', color: Colors.yellow),
      ColorModel(name: 'Зеленый', color: Colors.green),
    ],
  );

  final selectedFigure = StateNotifier<int>(initValue: 0);
  final selectedColor = StateNotifier<int>(initValue: 0);
}
