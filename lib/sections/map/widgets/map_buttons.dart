import 'package:flutter/material.dart';
import 'package:map_draw/static/static_data.dart';
import 'package:map_draw/widgets/circle_button.dart';

/// Интерфейс для управления картой
class MapButtons extends StatelessWidget {
  const MapButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleButton(
          icon: Icons.settings_rounded,
          // TODO(Nikita): onPressed
          onPressed: () {},
        ),
        const SizedBox(
          height: StaticData.defaultPadding,
        ),
        CircleButton(
          icon: Icons.delete_rounded,
          // TODO(Nikita): onPressed
          onPressed: () {},
        ),
        const SizedBox(
          height: StaticData.defaultPadding,
        ),
        CircleButton(
          icon: Icons.add_rounded,
          // TODO(Nikita): onPressed
          onPressed: () {},
        ),
        const SizedBox(
          height: StaticData.defaultPadding,
        ),
        CircleButton(
          icon: Icons.navigation_outlined,
          // TODO(Nikita): onPressed
          onPressed: () {},
        ),
      ],
    );
  }
}
