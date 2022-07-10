import 'package:elementary/elementary.dart';
import 'package:map_draw/models/figure_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreenModel extends ElementaryModel {
  final streamedMapObjects = StateNotifier<List<MapObject>>();

  final streamedFigures = StateNotifier<List<FigureModel>>();

  final selectedFigure = StateNotifier<int>(initValue: 0);
}
