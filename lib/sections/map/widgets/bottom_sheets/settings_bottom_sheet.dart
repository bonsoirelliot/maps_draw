import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:map_draw/models/figure_model.dart';
import 'package:map_draw/sections/map/widgets/bottom_sheets/bottom_sheet_track.dart';
import 'package:map_draw/sections/map/widgets/bottom_sheets/custom_picker.dart';
import 'package:map_draw/sections/map/wm/map_screen_wm.dart';
import 'package:map_draw/static/static_data.dart';
import 'package:map_draw/theme/styles.dart';
import 'package:map_draw/theme/theme.dart';
import 'package:map_draw/widgets/buttons/bordered_button_with_icon.dart';
import 'package:map_draw/widgets/buttons/default_text_button.dart';
import 'package:map_draw/widgets/inputs/custom_text_field.dart';

class SettingsBottomSheet extends StatefulWidget {
  final MapScreenWM wm;
  const SettingsBottomSheet({
    required this.wm,
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  // late final loadedFigures = widget.wm.streamedFigures.value;
  // late final selectedFigure = widget.wm.selectedFigure.value!;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: StaticData.defaultPadding,
      ),
      child: StateNotifierBuilder<List<FigureModel>>(
        listenableState: widget.wm.streamedFigures,
        builder: (context, figures) {
          return StateNotifierBuilder<int>(
            listenableState: widget.wm.selectedFigure,
            builder: (context, selected) {
              // TODO(Nikita): tupoe gavno
              final nameController =
                  TextEditingController(text: figures?[selected!].name);

              // nameController.value =
              //     nameController.value.copyWith(text: figures?[selected!].name);
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
                          onCreateNewFigurePressed: widget.wm.createNewFigure,
                          onFigureSelected: widget.wm.selectFigure,
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
                    controller: nameController,
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
                  const BorderedButtonWithIcon(
                    text: 'Цвет',
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextButton(
                        text: 'СОХРАНИТЬ',
                        onPressed: () {},
                      ),
                      DefaultTextButton(
                        text: 'Сбросить',
                        textColor: Colors.black,
                        backgroundColor: AppTheme.lightGray,
                        onPressed: () {},
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
}
