import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:map_draw/models/color_model.dart';
import 'package:map_draw/models/figure_model.dart';
import 'package:map_draw/sections/map/widgets/bottom_sheets/bottom_sheet_track.dart';
import 'package:map_draw/sections/map/widgets/bottom_sheets/custom_picker.dart';
import 'package:map_draw/sections/map/widgets/bottom_sheets/settings/settins_wm.dart';
import 'package:map_draw/static/static_data.dart';
import 'package:map_draw/theme/styles.dart';
import 'package:map_draw/theme/theme.dart';
import 'package:map_draw/widgets/buttons/bordered_button_with_icon.dart';
import 'package:map_draw/widgets/buttons/default_text_button.dart';
import 'package:map_draw/widgets/inputs/custom_text_field.dart';

class SettingsBottomSheet extends ElementaryWidget<SettingsWM> {
  final List<FigureModel> figures;
  final int selectedFigure;
  final Function(List<FigureModel>)? onFiguresListUpdated;
  final Function(int)? onFigureSelected;
  const SettingsBottomSheet({
    required this.figures,
    required this.selectedFigure,
    this.onFiguresListUpdated,
    this.onFigureSelected,
    Key? key,
  }) : super(
          createSettingsWM,
          key: key,
        );

  @override
  Widget build(SettingsWM wm) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: StaticData.defaultPadding,
      ),
      child: StateNotifierBuilder<List<FigureModel>>(
        listenableState: wm.streamedFigures,
        builder: (context, figures) {
          return StateNotifierBuilder<int>(
            listenableState: wm.selectedFigure,
            builder: (context, selected) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                    child: BottomSheetTrack(),
                  ),
                  BorderedButtonWithIcon(
                    text: 'Список всех фигур в базе',
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                        ),
                        builder: (context) => CustomPicker(
                          items: figures?.map((e) => e.name).toList(),
                          onCreateNewFigurePressed: wm.createNewFigure,
                          onFigureSelected: wm.selectFigure,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Text(
                    'Название',
                    style: AppStyles.h6.copyWith(
                      color: AppTheme.gray,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  CustomTextField(
                    controller: wm.nameController,
                    hintText: 'Название фигуры',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Цвет',
                    style: AppStyles.h6.copyWith(
                      color: AppTheme.gray,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  StateNotifierBuilder<List<ColorModel>>(
                    listenableState: wm.streamedColors,
                    builder: (context, colors) {
                      return BorderedButtonWithIcon(
                        text: figures != null && figures.isNotEmpty
                            ? colors!
                                .firstWhere((element) =>
                                    element.color.value ==
                                    figures[selected!].lineColor.value)
                                .name
                            : 'Цвет',
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                            ),
                            builder: (context) => CustomPicker(
                              items: colors!.map((e) => e.name).toList(),
                              onFigureSelected: (color) {
                                wm.updateFigure(color: color);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextButton(
                        text: 'СОХРАНИТЬ',
                        onPressed: wm.updateFiguresAndSave,
                      ),
                      DefaultTextButton(
                        text: 'Сбросить',
                        textColor: Colors.black,
                        backgroundColor: AppTheme.lightGray,
                        onPressed: wm.setDefaultValues,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // void updateListener() {
  //   final loadedFigures = widget.mapScreenWM.streamedFigures.value;
  //   final selectedFigure = widget.mapScreenWM.selectedFigure.value!;

  //   nameController.text =
  //       loadedFigures?[selectedFigure].name ?? nameController.text;
  // }
}
