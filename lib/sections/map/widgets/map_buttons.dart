import 'package:flutter/material.dart';
import 'package:map_draw/static/static_data.dart';
import 'package:map_draw/widgets/buttons/circle_button.dart';

/// Интерфейс для управления картой
class MapButtons extends StatelessWidget {
  final VoidCallback? onSettingsPressed;
  final VoidCallback? onDeletePressed;
  final VoidCallback? onPlusPressed;
  final VoidCallback? onUserPositionPressed;

  const MapButtons({
    this.onDeletePressed,
    this.onPlusPressed,
    this.onSettingsPressed,
    this.onUserPositionPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //* Настройки
        CircleButton(
          icon: Icons.settings_rounded,
          onPressed: onSettingsPressed,
        ),
        const SizedBox(
          height: StaticData.defaultPadding,
        ),

        //* Удалить
        CircleButton(
          icon: Icons.delete_rounded,
          onPressed: onDeletePressed,
        ),
        const SizedBox(
          height: StaticData.defaultPadding,
        ),

        //* Создать
        CircleButton(
          icon: Icons.add_rounded,
          onPressed: onPlusPressed,
        ),
        const SizedBox(
          height: StaticData.defaultPadding,
        ),

        //* Получить геолокацию
        CircleButton(
          icon: Icons.navigation_outlined,
          onPressed: onUserPositionPressed,
        ),
      ],
    );
  }
}
