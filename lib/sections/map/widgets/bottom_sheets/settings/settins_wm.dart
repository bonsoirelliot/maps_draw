import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:map_draw/models/color_model.dart';
import 'package:map_draw/models/figure_model.dart';
import 'package:map_draw/models/point_model.dart';
import 'package:map_draw/sections/map/widgets/bottom_sheets/settings/settings_bottom_sheet.dart';
import 'package:map_draw/sections/map/widgets/bottom_sheets/settings/settings_model.dart';

class SettingsWM extends WidgetModel<SettingsBottomSheet, SettingsModel> {
  final nameController = TextEditingController();

  ListenableState<int> get selectedFigure => model.selectedFigure;
  ListenableState<int> get selectedColor => model.selectedColor;

  ListenableState<List<FigureModel>> get streamedFigures =>
      model.streamedFigures;

  ListenableState<List<ColorModel>> get streamedColors => model.streamedColors;

  SettingsWM(super.model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    model.streamedFigures.accept(widget.figures);
    model.selectedFigure.accept(widget.selectedFigure);

    nameController.value = nameController.value.copyWith(
      text: model.streamedFigures.value?[model.selectedFigure.value!].name,
    );
  }

  void updateFigure({int? color, String? name, List<PointModel>? points}) {
    final figures = [...model.streamedFigures.value ?? <FigureModel>[]];
    final finalFigures = <FigureModel>[];

    final selected = model.selectedFigure.value!;

    for (var i = 0; i < figures.length; i++) {
      if (i == selected) {
        finalFigures.add(
          FigureModel(
            name: name ?? figures[i].name,
            lineColor: color != null
                ? streamedColors.value![color].color
                : figures[i].lineColor,
            points: points ?? figures[i].points,
          ),
        );
      } else {
        finalFigures.add(figures[i]);
      }
    }

    model.streamedFigures.accept(finalFigures);
  }

  void selectFigure(int figure) {
    if (model.streamedFigures.value != null &&
        model.streamedFigures.value!.isNotEmpty) {
      model.selectedFigure.accept(figure);

      nameController.value = nameController.value
          .copyWith(text: model.streamedFigures.value?[figure].name);

      widget.onFigureSelected?.call(figure);
    }
  }

  void createNewFigure() {
    final figures = [...model.streamedFigures.value ?? <FigureModel>[]];

    final number = figures.length;

    final newFigure = FigureModel(
      name: 'Figure $number',
      lineColor: Colors.blue,
      points: [],
    );

    model.streamedFigures.accept(figures..add(newFigure));

    widget.onFiguresListUpdated?.call(model.streamedFigures.value!);

    selectFigure(number - 1 > -1 ? number - 1 : number);

    Navigator.of(context).pop();
  }
}

SettingsWM createSettingsWM(BuildContext _) => SettingsWM(SettingsModel());
